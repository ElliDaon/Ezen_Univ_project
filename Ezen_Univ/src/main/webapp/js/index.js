const wrapper = document.querySelector('.wrapper');
const first = document.querySelector('.first');
const loginLink = document.querySelector('.login-link');
const registerLink = document.querySelector('.register-link');
const btnpopup = document.querySelector('.btnLogin-popup');
const closebtn = document.querySelector('.icon-close');
const adminbtn = document.querySelector('.admin_login_btn');
const adminclbtn = document.querySelector('.admin-close');
const adminWrapper = document.querySelector('.admin_login_wrapper');

registerLink.addEventListener('click', ()=> {
    wrapper.classList.add('active');
});

loginLink.addEventListener('click', ()=> {
    wrapper.classList.remove('active');
});

btnpopup.addEventListener('click', ()=> {
    wrapper.classList.add('active-popup');
    first.classList.add('active-popup');
});

closebtn.addEventListener('click', ()=> {
    wrapper.classList.remove('active-popup');
    first.classList.remove('active-popup');
});

adminbtn.addEventListener('click',()=> {
	adminWrapper.classList.add('active-popup')
})

adminclbtn.addEventListener('click',()=> {
	adminWrapper.classList.remove('active-popup')
})


$(document).ready(function(){
  $(window).scroll(function(){
    var scroll = $(window).scrollTop();
    if (scroll > 1) {
      $("header").css("background" , "#F3F3F3");
      $(".logo a").css("color" , "black");
      $(".navigation a").css("color" , "black");
      $(".btnLogin-popup").css("border" , "2px solid black");
      $(".btnLogin-popup").css("color" , "black");
      
    }
    else{
      $("header").css("background" , "transparent");
      $(".logo a").css("color" , "white");
      $(".navigation a").css("color" , "white");
      $(".btnLogin-popup").css("border" , "2px solid white");
      $(".btnLogin-popup").css("color" , "white");
      $(".btnLogin-popup").hover(function(){
    	  $(".btnLogin-popup").css("color" , "black");  
      }, function(){
  		$(".btnLogin-popup").css("color", "white");
  		})
    }
  })
})

function pwcheck(){
	var pw = $('#input-box-pwd [name="memberPwd"]').val();
	var pw2 = $('#input-box-pwd2 [name="memberPwd2"]').val();
	var num = pw.search(/[0-9]/g);
	var eng = pw.search(/[a-z]/ig);
    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
    
    $('#input-box-pwd [name="memberPwd"]').on('focusout',function(){
		$('#pass-info').css('visibility','hidden');
	});
    $('#input-box-pwd2 [name="memberPwd2"]').on('focusout',function(){
		$('#pass-check-info').css('visibility','hidden');
		$('#pass-info').css('visibility','hidden');
	});
    $('#input-box-name [name="memberName"]').on('focusin',function(){
		$('#pass-check-info').css('visibility','hidden');
	});
		
	
    if(pw.length < 8 || pw.search(/\s/) != -1 || num < 0 || eng < 0 || spe < 0 ){
		$('#pass-info').css('visibility','visible');
	    if(pw2 != ""){
			$('#pass-info').css('visibility','hidden');
		}else{
			$('#pass-info').css('visibility','visible');
	    	$('#pass-info').text('※ 영문, 숫자, 특수기호 포함 8자 이상').css('color','red');
		}
		$('#pwd-check1').css('visibility','visible');
		$('#pwd-check1').css('color','red');
    }else{
		$('#pass-info').css('visibility','hidden');
		$('#pwd-check1').css('visibility','visible');
		$('#pwd-check1').css('color','green');
    }
    

	if(pw == pw2){
		$('#pass-check-info').css('visibility','hidden');
		$('#pwd-check2').css('visibility','visible');
		$('#pwd-check2').css('color','green');
		
	}else{
		if( $('#input-box-name [name="memberName"]').val()==''){
			$('#pass-check-info').css('visibility','visible');
		}else{
			$('#pass-check-info').css('visibility','hidden');
		}
		$('#pass-check-info').text('비밀번호 불일치').css('color','red');
		$('#pwd-check2').css('visibility','visible');
		$('#pwd-check2').css('color','red');
	}
}

