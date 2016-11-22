# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'csv'

# Path to the source data file
QUOTES_SEED_FILE = "#{Rails.root}/db/seed_data/quotes.csv"

# Gather this many csv rows before persisting the batch to the database
QUOTES_SEED_BATCH_SIZE = 1000

# Figuring out list of fields to use in SQL
QUOTE_ATTRIBUTE_NAMES = Quote.attribute_names - ['id']

def seed_data
  # Delete all existing records in a single SQL statement
  Quote.delete_all

  # csv.each returns rows one by one. Although the simplest approach to insert
  # data to the database would also be on one by one basis, it would carry
  # some overhead and would be slower. The opposite, also inferior, approach
  # would be to parse all the data into memory and then insert as a batch. It
  # would only be feasible for smaller amounts of records and thus not universal.
  # Instead we gather batches of rows from the CSV and insert each batch in its
  # own transaction, limiting memory use to the size of a batch.
  rows = []

  # We could use CSV.foreach here but we need the csv object inside the block,
  # therefore going with separate #open and #each calls.
  # The quote_char is a Unicode 'zero byte', something that is not expected to be
  # encountered in a text file. It is used as a workaround for the CSV implementation
  # tripping on mixed use of unquoted and quoted fields.
  # See http://stackoverflow.com/a/8074099/2116518 for details.
  csv = CSV.open(
    QUOTES_SEED_FILE,
    headers: true,
    header_converters: [:downcase, :symbol],
    col_sep: ';',
    quote_char: "\x00"
  )

  # Make index 1-based for cleaner batch calculation
  csv.each.with_index(1) do |row, index|
    rows << row
    if index % QUOTES_SEED_BATCH_SIZE == 0 || csv.eof?
      # Separating the concerns of reading and persisting records
      yield rows if block_given?
      rows = []
    end
  end
end

def persist(rows)
  return unless rows.present?

  # Using lower level approach to avoid model overhead
  ActiveRecord::Base.connection_pool.with_connection do |conn|
    # Creating parameter list of form (value1, value2, value3),(...).
    # Using conn.quote to sanitize input
    values = rows.map do |row|
      "(#{row.fields.map { |field| conn.quote(field) }.join(',') })"
    end.join(',')

    # Persisting the batch in a single INSERT statement. Avoiding hardcoding the
    # column names although still relying on the assumption of having matched
    # field counts between csv and the underlying table.
    conn.execute(
      "INSERT INTO quotes (#{QUOTE_ATTRIBUTE_NAMES.join(',')}) VALUES #{values}"
    )
  end
end

# Entry point
# seed_data do |rows|
#   persist(rows)
# end

seed_data(&method(:persist))
