function popupCall() {
	var button = eform.findControl("Button1");
	
	button.onClickEvent(function(eventTarget){
		var pop_title = "pop";
		window.open("childView.jsp", pop_title, "width=800, height=500, top=500");	//새창 띄우기
	});
	
}

function putControlValue(value1, value2) {
	var input1 = eform.findControl("Inputbox1");
	var input2 = eform.findControl("Inputbox2");
	input1.setValue(value1);
	input2.setValue(value2);
	
	var img = eform.findControl("InputImage1");
	var sign = eform.findControl("clipsign1");
	
	if(input1.getValue(value1) == "1") {
		img.setVisible(true);
		sign.setVisible(false);
	} else {
		img.setVisible(false);
		sign.setVisible(true);
	}	
}
