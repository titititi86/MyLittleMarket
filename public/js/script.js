$(function() {
    return $('#product_category_name').autocomplete({
        source: $('#product_category_name').data('autocomplete-source')
    });
});


$(function() {
    /* Push the body and the nav over by 285px over */
    $('.icon-menu').click(function() {
        $('.menu').animate({
            left: "0px"
        }, 200);

        $('.container').animate({
            left: "285px"
        }, 200);
    });

    /* Then push them back */
    $('.icon-close').click(function() {
        $('.menu').animate({
            left: "-285px"
        }, 200);

        $('.container').animate({
            left: "0px"
        }, 200);
    });
});
