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

