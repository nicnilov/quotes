class Quote < ActiveRecord::Base
  # NOTE: this is PostgreSQL-dependent. Does not qualify to be a proper scope
  # due to only returning a single record and in a non-deterministic fashion.
  def self.random
    Quote.order('RANDOM()').first
  end
end
