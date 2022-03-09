const menuBtn = document.querySelector('.menu-btn');
const mobile_menu = document.querySelector('.mobile-nav');

// listen for click on hamburger menu 
menuBtn.addEventListener('click', function () {
    menuBtn.classList.toggle('open'); 
    mobile_menu.classList.toggle('open'); // adds .open class to our .menu-btn & .mobile-nav class
    document.body.classList.toggle('lock-scroll')
})


// mobile menu logic
var btn = $('#button');

$(window).scroll(function () {
    if ($(window).scrollTop() > 300) {
        btn.addClass('show');
    } else {
        btn.removeClass('show');
    }
});

btn.on('click', function (e) {
    e.preventDefault();
    $('html, body').animate({ scrollTop: 0 }, '300');
});