class QuotesController < ApplicationController
  def index
    @quote = Quote.random
    # Nothing else to do here as Rails automatically picks up the proper
    # view from the request format
  end
end
