$(document).ready(function(){

	$(window).scroll(scrollHandler);

	switch(getUrlVars()['page']){
		case "login":
			$('#txtEmail').keyup(checkEmail).blur(checkEmail);
			$('#txtUsername').keyup(checkSixChars).blur(checkSixChars);
			$('#txtRegPassword1').keyup(checkEightChars).blur(checkEightChars);
			break;
		case "addDuck":
			$('#txtDescription').keyup(checkThreeChars).blur(checkThreeChars);
			break;
		default:
			var container = $('#masonryContainer');
			container.imagesLoaded(function(){
				container.masonry({
				    itemSelector : '.duckContainer',
				    columnwidth : 220
			    });
			});
			break;
	}

});

function checkThreeChars(){
	if(!Modernizr.input.required){
		var $element = $(this);
		var errorMsg = "Should be at least 3 characters.";

		if($element.val().length < 3){
			showInvalid($element, $element.next(), errorMsg);
		}else{
			showValid($element, $element.next());
		}
	}
}

function checkSixChars(){
	if(!Modernizr.input.required){
		var $element = $(this);
		var errorMsg = "Should be at least 6 characters.";

		if($element.val().length < 6){
			showInvalid($element, $element.next(), errorMsg);
		}else{
			showValid($element, $element.next());
		}
	}
}

function checkEightChars(){
	if(!Modernizr.input.required){
		var $element = $(this);
		var errorMsg = "Should be at least 8 characters.";

		if($element.val().length < 8){
			showInvalid($element, $element.next(), errorMsg);
		}else{
			showValid($element, $element.next());
		}
	}
}

function checkEmail(){
	if(!Modernizr.input.required || !Modernizr.inputtypes.email){
		var $element = $(this);
		var errorMsg = "Please fill in a valid email adress.";
    	var regExp = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);

		if(!regExp.test($element.val())){
			showInvalid($element, $element.next(), errorMsg);
		}else{
			showValid($element, $element.next());
		}

		console.log("checking Email adress.");
	}
}

function showValid($element, $infoElement){
	$element.removeClass("error");
	$infoElement.text("");
}

function showInvalid($element, $infoElement, errorMsg){
	$element.addClass("error");
	$infoElement.text(errorMsg);
}

function scrollHandler(){
	if($(this).scrollTop() > 120){
		$("#container > header nav").addClass('fixedNav');
	}else{
		$("#container > header nav").removeClass('fixedNav');
	}
}

function getUrlVars(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++){
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}