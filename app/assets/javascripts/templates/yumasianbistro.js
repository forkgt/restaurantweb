//= require jquery
//= require jquery_ujs
//= require jquery.ui.all

(function($) {
    // Set Fixed Position For An Div Within An Designated Area
    $.fn.smartFloat = function() {
        var position = function(element) {
            var y_start = element.position().top;

            $(window).scroll(function() {
                var scrolls = $(this).scrollTop();
                var y_stop = $('#main').offset().top + $('#main').height() - element.height() - 30;
                var x_start = $('#main').offset().left + $('#main').width() + 20;
                if (scrolls > y_start && scrolls < y_stop) {
                    if (window.XMLHttpRequest) {
                        element.css({
                            position: "fixed",
                            top: 0,
                            left:x_start
                        });
                    } else {
                        element.css({
                            top: scrolls,
                            left:x_start
                        });
                    }
                } else if (scrolls >= y_stop) {
                    element.css({
                        position: "absolute",
                        top: y_stop,
                        left:x_start
                    });
                } else {
                    element.css({
                        position: "absolute",
                        top: y_start,
                        left:x_start
                    });
                }
            });
        };
        return $(this).each(function() {
            position($(this));
        });
    };
})(jQuery);