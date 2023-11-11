const wrapper = document.querySelector('.wrapper');
const first = document.querySelector('.first');
const loginLink = document.querySelector('.login-link');
const registerLink = document.querySelector('.register-link');
const btnpopup = document.querySelector('.btnLogin-popup');
const closebtn = document.querySelector('.icon-close');

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
	