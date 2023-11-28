for(let i=1; i<=4; i++){

    function getValue(event,i){
        const value=event.target.value;
        const eleid="value"+i;
        document.getElementById(eleid).value=value;
    }
}

function selectAtt(selectAll){
    const checkboxes = document.getElementsByName('student');
    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAll.checked;
    })
}

var attval = $("input[name='attendvalue1']:checked").val();
if(attval === '지각'){
	
}
$('input[name="attendvalue1"]').change(function() {
    $('input[name="attendvalue1"]').each(function() {
        var value = $(this).val();             
        var checked = $(this).prop('checked'); 
        
        var $label = $(this).next();
 
        if(checked && value==='출석'){
            $label.css('background-color', '#459B60');
            $label.css('border', '1px solid #459B60');
            $label.css('color', 'white');
        }
        else if(checked && (value==='지각' || value === '조퇴')){
            $label.css('background-color', '#E3C22A');
            $label.css('border', '1px solid #E3C22A');
            $label.css('color', 'white');
        }else if(checked && value === '결석'){
			$label.css('background-color', '#D95321');
            $label.css('border', '1px solid #D95321');
            $label.css('color', 'white');
		}else{
			$label.css('background-color','white');
			$label.css('border','1px solid black');
			$label.css('color','gray');
		}
    });
});

$(document).ready(function(){
	$("#allatt").on("click",function(){
		var size = $('input:checkbox[name="student"]').length;
		for(var i=1; i<size; i++){
			var ra = "#att"+i;
			var cs = "input[name=\"attendvalue"+i+"\"][value='출석']"
			var cs1 = "input[name=\"attendvalue"+i+"\"][value='지각']"
			var cs2 = "input[name=\"attendvalue"+i+"\"][value='조퇴']"
			var cs3 = "input[name=\"attendvalue"+i+"\"][value='결석']"
			var tex = "#value"+i;
			$(ra).prop('checked', true);
			var val = "input[name='attendvalue"+i+"']";
			var val1 = $(val).val();
			var ne = $(cs).next();
			var ne1 = $(cs1).next();
			var ne2 = $(cs2).next();
			var ne3 = $(cs3).next();
			ne.css('background-color', '#459B60');
            ne.css('border', '1px solid #459B60');
            ne.css('color', 'white');
            $(tex).val('출석');
            ne1.css('background-color', 'white');
            ne1.css('border', '1px solid #555555');
            ne1.css('color', '#555555');
            
            ne2.css('background-color', 'white');
            ne2.css('border', '1px solid #555555');
            ne2.css('color', '#555555');
            
            ne3.css('background-color', 'white');
            ne3.css('border', '1px solid #555555');
            ne3.css('color', '#555555');
		}
	});
});