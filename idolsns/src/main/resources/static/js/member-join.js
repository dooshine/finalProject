//회원가입 페이지 유효성 검사

$(function(){
    var valid = {
        memberIdVaild:false,
        memberPwValid:false,
        memberPwReValid:false,
        memberNickValid:false,
    };

    //아이디 검사
    $("[name=memberId]").blur(function(){
        var regex = /^[a-z][a-z0-9]{8,20}$/;
        var memberId = $(this).val();
        var isValid = regex.test(memberId);

        valid.memberIdVaild = isValid;

        if(isValid) {
            $.ajax({
                url:contextPath+"/rest/member/memberId" + memberId,
                method:"get",
                success:function(response) {
                    if(response == 'Y') {
                        valid.memberIdVaild = true;
                        $("[name=memberId]")
                                    .removeClass("valid invalid invalid2")
                                    .addClass("valid");
                    }
                    else {
                        valid.memberIdVaild = false;
                        $("[name=memberId]")
                                    .removeClass("valid invalid invalid2")
                                    .addClass("invalid2");
                    }
                },
                error:function(){
                    alert("오류가 발생했습니다.\n잠시 후에 다시 시도하세요.");
                    valid.memberIdVaild = false;
                }
            });
        }
        else {
            $(this).removeClass("valid invalid invalid2")
                    . addClass("invalid");
        }
    });

    //비밀번호 검사
    $("[name=memberPw]").blur(function(){
        var regax = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = regax.test($(this).val());

        valid.memberPwValid = isValid;

        $(this).removeClass("valid invalid")
                    .addClass(isValid ? "valid" : "invalid");
    });

    //비밀번호 확인 검사
    $("#passwordRe").blur(function(){
        var memberPw = $("[name=memberPw]").val();
        var memberPwRe = $(this).val();

        var isEmpty = memberPw.length == 0;
        var isValid = memberPw == memberPwRe;

        valid.memberPwReValid = !isEmpty && isValid;
        
        $(this).removeClass("valid invalid invalid2");

        if(isEmpty) {
            $(this).addClass("invalid2");
        }
        else if(isValid) {
            $(this).addClass("valid");
        }
        else {
            $(this).addClass("invalid");
        }
    });

    //닉네임 검사
    $("[name=memberNick]").blur(function(){
        var regex = /^[가-힣0-9a-z!@#$.-_]{1,10}]$/;
        var memberNick = $(this).val();
        var isValid = regex.test(memberNick);

        valid.memberNickValid = isValid;

        if(!isValid) {
            $(this).removeClass("valid invalid invalid2")
                    .addClass("invalid");
             return       
        }

        $.ajax({
            url:"/rest/member/memberNick/"+memberNick,
            method:"get",
            success:function(response) {
                if(response == "Y") {
                    valid.memberIdVaild = true;
                    $(this).removeClass("valid invalid invalid2")
                            .addClass("valid");
                }
                else {
                    valid.memberNickValid = false;
                    $(this).removeClass("valid invalid invalid2")
                            .addClass("invalid2");
                }
            },
            error:function(){
                alert("통신 오류 발생");
                valid.memberNickValid = false;
            },
        });
    });

});