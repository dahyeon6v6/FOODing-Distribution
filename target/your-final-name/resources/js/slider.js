$(document).ready(function() {
    let currentIndex = 0;
    const slides = $('.mainSliderList .slider');
    const totalSlides = slides.length;

    // 초기에 첫 번째 슬라이드를 활성화
    slides.eq(currentIndex).addClass('active').css('left', '0');

    $('.nextBtn').on('click', function() {
        // 현재 슬라이드를 왼쪽으로 이동
        slides.eq(currentIndex).animate({ left: '-100%' }, 500, function() {
            $(this).removeClass('active').css('left', '100%');
        });

        // 다음 슬라이드를 오른쪽에서 등장하도록 준비
        currentIndex = (currentIndex + 1) % totalSlides;
        slides.eq(currentIndex).css('left', '100%').addClass('active').animate({ left: '0' }, 500);
    });

    $('.preBtn').on('click', function() {
        // 현재 슬라이드를 오른쪽으로 이동
        slides.eq(currentIndex).animate({ left: '100%' }, 500, function() {
            $(this).removeClass('active').css('left', '-100%');
        });

        // 이전 슬라이드를 왼쪽에서 등장하도록 준비
        currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
        slides.eq(currentIndex).css('left', '-100%').addClass('active').animate({ left: '0' }, 500);
    });
});
