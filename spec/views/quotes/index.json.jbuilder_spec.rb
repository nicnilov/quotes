require 'rails_helper'

RSpec.describe "quotes/index.json.jbuilder", type: :view do
  it "displays the quote" do
    @expected = Quote.new(text: 'Quote text', author: 'Quote author')
    assign(:quote, @expected)
    render
    expect(response.body).to eq(@expected.to_json(only: [:text, :author]))
  end
end
