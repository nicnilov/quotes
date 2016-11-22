/* An encapsulating module to avoid polluting global scope */
var Quotes = (function($) {

    'use strict';

    function _attachFullScreenHandler () {
        $('body').click(function() {
            screenfull.request();
        });
    };

    function _updateQuoteAfterTimeout () {
        /* set timeout to ten minutes */
        var timeout = 10 * 60 * 1000;
        setTimeout(_updateQuote, timeout);
    };

    function _updateQuote () {
        $.ajax({
            dataType: 'json',
            success: function(data, textStatus, jqXHR) {
                _renderQuote(data);
                _updateBackdrop();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                /* Outputting errors to the console. Better alternative would
                 * be to connect a monitoring service such as New Relic */
                console.log(errorThrown);
            }
        });

        _updateQuoteAfterTimeout();
    };

    function _renderQuote(quote) {
        $('.quote-text').text(quote.text);
        $('.quote-author').text(quote.author);
    };

    function _updateBackdrop () {
        /* Fecthing an image, adding a random query to counter browser's image caching */
        $('html').css(
            'background-image',
            'url(http://lorempixel.com/1920/1080/' + '?' + Math.random() + ')'
        );
    };

    /* IIFE performs the initial setup on jQuery ready event */
    (function initialize () {
        $(function() {
            _attachFullScreenHandler();
            _updateQuoteAfterTimeout();
        });
    }());

    return {
        /* no exports */
    };

}(jQuery));
