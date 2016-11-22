Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # We don't need a separate route for displaying subsequent quotes.
  # Instead use the request format when routing to quotes#index to discern
  # whether it is the initial page render or a subsequent ajax request.
  root 'quotes#index'
end
