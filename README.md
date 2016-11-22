#Quotes

A Rails application to display random quotes, refreshing every ten minutes.

## What is there

* A seed script picks up the quotes.csv file and populates the database, removing any previously existing quotes;
* The `Quote` model provides a method to fetch a random quote;
* The `QuotesController` implements `#index` action which fetches a quote and passes it over to a view, according to the request format (`:html` or `:json`);
* Initial request from a browser is rendered as `:html` while subsequent updates are requested via `:json` ajax requests;
* Client-side javascript fetches a new quote every ten minutes;
* A random backdrop image is fetched from `lorempixel.com` website with every new quote;
* Minimal tests for the controller and views.

## What is missing

  * Automatic fullscreen transition is prohibited by browsers if made outside of scope of a user-generated event. For this reason a limited implementation is provided, requiring a click anywhere on the page to go fullscreen. Although with some perseverance it would certainly be possible to fabricate a user-generated event outside of a browser, the approach would be associated with added constraints and therefore is considered outside of the task’s scope;

  * Tests for the seed script are not implemented;

  * Tests for frontend javascript are not implemented;

  * Deployment script is not implemented.