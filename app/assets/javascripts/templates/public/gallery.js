$(document).ready(function(){
    /* This code is executed after the DOM has been completely loaded */
    var totWidth=0;
    var positions = new Array();
    $('#gallery_slides .gallery_slide').each(function(i) {
        /* Loop through all the slides and store their accumulative widths in totWidth */
        positions[i]= totWidth;
        totWidth += $(this).width();
        /* The positions array contains each slide's commulutative offset from the left part of the container */
        if(!$(this).width()) {
            alert("Please, fill in width & height for all your images!");
            return false;
        }
    });

    $('#gallery_slides').width(totWidth);
    /* Change the cotnainer div's width to the exact width of all the slides combined */
    $('#gallery_menu ul li a').click(function(e){
        /* On a thumbnail click */
        $('li.act').removeClass('act').addClass('inact');
        $(this).parent().addClass('act');
        var pos = $(this).parent().prevAll('.gallery_menu_item').length;
        $('#gallery_slides').stop().animate({marginLeft:-positions[pos]+'px'},450);
        /* Start the sliding animation */
        e.preventDefault();
        /* Prevent the default action of the link */
    });

    setInterval(showpic,5000);

    function showpic(){
        var x = $('#gallery_menu ul li.act');
        x.removeClass('act').addClass('inact');
        if (x.is('#gallery_menu ul li:last-child')) {
            $('#gallery_menu ul li.gallery_menu_item:first').removeClass('inact').addClass('act');
            var pos = $('#gallery_menu ul li.gallery_menu_item:first').prevAll('.gallery_menu_item').length;
        } else {
            x.next().removeClass('inact').addClass('act');
            var pos = x.next().prevAll('.gallery_menu_item').length;
        }

        $('#gallery_slides').stop().animate({marginLeft:-positions[pos]+'px'},450);
    }

    $('#gallery_menu ul li.gallery_menu_item:first').addClass('act').siblings().addClass('inact');
    /* On page load, mark the first thumbnail as active */
});