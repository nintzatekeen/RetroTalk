posicionarMenu();

$(window).scroll(function() {    
    posicionarMenu();
});

function posicionarMenu() {
    var altura_del_header = $('.header').outerHeight(true);
    var altura_del_menu = $('.menu').outerHeight(true);

    if ($(window).scrollTop() >= altura_del_header){
        $('.menu').addClass('fixed-top');
        $('.wrapper').css('margin-top', (altura_del_menu + 50) + 'px');
    } else {
        $('.menu').removeClass('fixed-top');
        $('.wrapper').css('margin-top', '0');
    }
}


