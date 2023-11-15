function pwcheck2(){
	var pw = $('#pwdinfo-input [name="newpwd"]').val();
	var pw2 = $('#pwdinfo-input [name="newpwdCheck"]').val();
	var num = pw.search(/[0-9]/g);
	var eng = pw.search(/[a-z]/ig);
    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	
    if(pw.length < 8 || pw.search(/\s/) != -1 || num < 0 || eng < 0 || spe < 0 ){
		$('#checkpw').css('color','red');
		$('#checkpw2').css('color','red');
    }else{
		$('#checkpw').css('color','green');
		
		if(pw == pw2){
			$('#checkpw2').css('color','green');
		}else{
			$('#checkpw2').css('color','red');
		}
		
    }
    

}