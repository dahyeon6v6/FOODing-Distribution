$(document).ready(function() {
    $(".snb").hide();

    $(".nav").hover(
        function() {
            let $snb = $(this).closest(".nav-div").find(".snb");
            if (!$snb.is(":visible")) {
                $snb.stop(true, true).slideDown(500);
            }
        },
        function() {
            // Do nothing on mouse leave from .nav
        }
    );

    $(".nav-div").hover(
        function() {
            // Do nothing on mouse enter to .nav-div
        },
        function() {
            let $snb = $(this).find(".snb");
            $snb.stop(true, true).slideUp(500);
        }
    );

    $(".snb").hover(
        function() {
            $(this).stop(true, true);
        },
        function() {
            $(this).stop(true, true).slideUp(500);
        }
    );

    <!-- 알림 기능 추가(희진) -->
    // 추가할 코드: 종 모양 이미지를 클릭했을 때 anb 보이기/숨기기
    $(".bell").click(function(event) {
        event.preventDefault(); // 링크 기본 동작 막기
        $(".anb").toggle(); // anb를 보이거나 숨김
    });

    $(document).click(function(event) {
        if (!$(event.target).closest('.bell, .anb').length) {
            $(".anb").hide(); // anb 숨기기
        } else {
            $(".anb").css("display", "flex"); // anb의 display 속성을 flex로 변경
        }
    });

});