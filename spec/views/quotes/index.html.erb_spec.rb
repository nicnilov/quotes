require 'rails_helper'

RSpec.describe "quotes/index.html.erb", type: :view do
  it "displays the quote" do
    assign(:quote, Quote.new(text: 'Quote text', author: 'Quote author'))
    render
    expect(rendered).to include("Quote text")
    expect(rendered).to include("Quote author")
  end
end
