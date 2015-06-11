$(document).ready(function(){

	switch(getUrlVars()['p']){
		case "home":
		case "resources":
		case "modularity":
		case "campaign":
		case "takePart":
			$(window).scroll(scrollHandler);
			$('.campaignLink').on("click", {hash: "#campaign"}, scrollToPage);
			$('.takePartLink').on("click", {hash: "#takePart"}, scrollToPage);
			$('.homeLink').on("click", {hash: "#content"}, scrollToPage);
			resetHomeEventListeners();
			scrollHandler();
			$('.fixed_nav').removeClass('fixed_nav');
			break;
		case "campaignDetails":
		case "donatePhone":
		case "createCover":
		case "shareCampaign":
			resetCampaignEventListeners();
			initAraCoverEditor();
			break;
	}

	$('.shareButton').removeAttr('href');

});

/* ---- Ara Cover Editor ---------------------------------------------------------------- */

function initAraCoverEditor(){

	convertToImgData();

	$('.phoneBlock').on('click', selectPhoneBlock);

	// Remove .selected on save button hover
	$('#btnSaveCover').mouseover(function(){
		$('.selectedBlock').removeClass('selectedBlock');
		convertToImgData();
	});

	// Init colorPicker
	var imgObj = new Image();
    imgObj.onload = function() {
       initColorPicker(this);
    };
    imgObj.src = 'img/ColorPicker.png';
	initColorPicker();

}

function editSelectedBlock(color){
	$('.selectedBlock').css('background-color', color);
	var selector = "input[name=\"" + $('.selectedBlock').attr('id') + "BgColor\"]";
	$(selector).val($('.selectedBlock').css('background-color'));

	convertToImgData();
}

function getMousePos(canvas, evt) {
	var rect = canvas.getBoundingClientRect();
	return {
		x: evt.clientX - rect.left,
		y: evt.clientY - rect.top
	};
}

function initColorPicker(imgObj){
    var canvas = document.getElementById('colorPicker');
    var context = canvas.getContext('2d');
    var mouseDown = false;

    context.strokeStyle = '#444';
    context.lineWidth = 2;

    canvas.addEventListener('mousedown', function(){
      	mouseDown = true;
    }, false);

    canvas.addEventListener('mouseup', function(){
      	mouseDown = false;
    }, false);

    canvas.addEventListener('mousemove', function(evt){
      	var mousePos = getMousePos(canvas, evt);
      	var color = undefined;

      	if(mouseDown && mousePos !== null && mousePos.x > 0 && mousePos.x < 256 && mousePos.y > 0 && mousePos.y < 256){
        	var imageData = context.getImageData(0, 0, 256, 256);
        	var data = imageData.data;

        	var r = data[((256 * mousePos.y) + mousePos.x) * 4];
        	var g = data[((256 * mousePos.y) + mousePos.x) * 4 + 1];
        	var b = data[((256 * mousePos.y) + mousePos.x) * 4 + 2];

        	var color = 'rgb(' + r + ',' + g + ',' + b + ')';

        	editSelectedBlock(color);
      	}

    }, false);

    context.drawImage(imgObj, 0, 0);
}

function selectPhoneBlock(evt){
	$('.selectedBlock').removeClass('selectedBlock');
	$(this).addClass('selectedBlock');
}

function convertToImgData(){
	var araModel = document.getElementById("AraPhoneModel");

	html2canvas(araModel, {
		onrendered: function(canvas) {
			canvas.id = "imgResult";
	    	$('#Customisation').append(canvas);

	    	// Save to form hidden data
	    	$('#imgDataUrl').val(canvas.toDataURL("image/png"));
	    }
	});
}

/* ---- Social Sharing Popups ---------------------------------------------------------------- */

function fbShare(url, title, descr, image, winWidth, winHeight){
    var winTop = (screen.height / 2) - (winHeight / 2);
    var winLeft = (screen.width / 2) - (winWidth / 2);
    window.open('http://www.facebook.com/sharer.php?s=100&p[title]=' + title + '&p[summary]=' + descr + '&p[url]=' + url + '&p[images][0]=' + image, 'sharer', 'top=' + winTop + ',left=' + winLeft + ',toolbar=0,status=0,width=' + winWidth + ',height=' + winHeight);
}

function tweet(url, text, winWidth, winHeight){
	var winTop = (screen.height / 2) - (winHeight / 2);
    var winLeft = (screen.width / 2) - (winWidth / 2);
	window.open('https://twitter.com/share?url=' + url + '&text=' + text, "Tweet", 'top=' + winTop + ',left=' + winLeft + ',toolbar=0,status=0,width=' + winWidth + ',height=' + winHeight);
}

function googlePlusShare(url, winWidth, winHeight){
	var winTop = (screen.height / 2) - (winHeight / 2);
    var winLeft = (screen.width / 2) - (winWidth / 2);
	window.open('https://plus.google.com/share?url=' + url, "Share to Google+", 'top=' + winTop + ',left=' + winLeft + ',toolbar=0,status=0,width=' + winWidth + ',height=' + winHeight);
}

/* ---- Campaign / Take Action Pagination ---------------------------------------------------------------- */

function removeCampaignEventListeners(){
	$('.toCampaignDetailsPage').off('click', gotoCampaignDetailsPage);
	$('.toPhoneDonationPage').off('click', gotoPhoneDonationPage);
	$('.toCoverCreationPage').off('click', gotoCoverCreationPage);
	//$('.toCompletionPage').off('click', gotoCompletionPage);
}

function resetCampaignEventListeners(){
	$('.toCampaignDetailsPage').on('click', gotoCampaignDetailsPage);
	$('.toPhoneDonationPage').on('click', gotoPhoneDonationPage);
	$('.toCoverCreationPage').on('click', gotoCoverCreationPage);
	//$('.toCompletionPage').on('click', gotoCompletionPage);
}

function gotoCampaignDetailsPage(evt){

	evt.preventDefault();
	var $campaign = $('#campaign_parts');

	removeCampaignEventListeners();

	$(".selected").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton invisible");

	$("#next_button").attr('class', "arrowButton toPhoneDonationPage");
	$("#next_button").attr('href', "?p=donatePhone");

	$campaign.attr('class', "CampaignDetailsPage");
	$("#toCampaign").addClass("selected");

	resetCampaignEventListeners();

}

function gotoPhoneDonationPage(evt){

	evt.preventDefault();
	var $campaign = $('#campaign_parts');

	removeCampaignEventListeners();

	$(".selected").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton toCampaignDetailsPage");
	$("#previous_button").attr('href', "?p=campaignDetails");

	$("#next_button").attr('class', "arrowButton toCoverCreationPage");
	$("#next_button").attr('href', "?p=createCover");

	$campaign.attr('class', "DonatePhonePage");
	$("#toTakeAction").addClass("selected");

	resetCampaignEventListeners();

}

function gotoCoverCreationPage(evt){

	evt.preventDefault();
	var $campaign = $('#campaign_parts');

	removeCampaignEventListeners();

	$(".selected").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton toPhoneDonationPage");
	$("#previous_button").attr('href', "?p=donatePhone");

	$("#next_button").attr('class', "arrowButton invisible");
	$("#next_button").attr('href', "");

	$campaign.attr('class', "CreateCoverPage");
	$("#toTakeAction").addClass("selected");

	resetCampaignEventListeners();

}

function gotoCompletionPage(evt){

	evt.preventDefault();
	var $campaign = $('#campaign_parts');

	removeCampaignEventListeners();

	$(".selected").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton toCoverCreationPage");
	$("#previous_button").attr('href', "?p=createCover");

	$("#next_button").attr('class', "arrowButton invisible");
	$("#next_button").attr('href', "?p=completionPage");

	$campaign.attr('class', "CompletionPage");
	$("#toTakeAction").addClass("selected");

	resetCampaignEventListeners();

}

/* ---- Home / Intro Pagination ---------------------------------------------------------------- */

function removeHomeEventListeners(){
	$('.toFairphonePage').off('click', gotoFairphonePage);
	$('.toPartnershipPage').off('click', gotoPartnershipPage);
	$('.toProjectAraPage').off('click', gotoProjectAraPage);
}

function resetHomeEventListeners(){
	$('.toFairphonePage').on('click', gotoFairphonePage);
	$('.toPartnershipPage').on('click', gotoPartnershipPage);
	$('.toProjectAraPage').on('click', gotoProjectAraPage);
}

function gotoFairphonePage(evt){

	evt.preventDefault();
	var $intro = $('#intro');

	removeHomeEventListeners();

	$(".selected").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton invisible");

	$("#next_button").attr('class', "arrowButton toPartnershipPage");
	$("#next_button").attr('href', "?p=home");

	$intro.attr('class', "FairphonePage");
	$("#toFairphonePage").addClass("selected");

	resetHomeEventListeners();

}

function gotoPartnershipPage(evt){

	evt.preventDefault();
	var $intro = $('#intro');

	removeHomeEventListeners();

	$(".selected").removeClass("selected");
	$("#toFairphonePage").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton toFairphonePage");
	$("#previous_button").attr('href', "?p=resources");

	$("#next_button").attr('class', "arrowButton toProjectAraPage");
	$("#next_button").attr('href', "?p=modularity");

	$intro.attr('class', "PartnershipPage");

	resetHomeEventListeners();

}

function gotoProjectAraPage(evt){

	evt.preventDefault();
	var $intro = $('#intro');

	removeHomeEventListeners();

	$(".selected").removeClass("selected");

	$("#previous_button").attr('class', "arrowButton toPartnershipPage");
	$("#previous_button").attr('href', "?p=home");

	$("#next_button").attr('class', "arrowButton invisible");

	$intro.attr('class', "ProjectAraPage");
	$("#toProjectAraPage").addClass("selected");

	resetHomeEventListeners();

}

/* ---- ScrollHandling ---------------------------------------------------------------- */

function scrollToPage(evt){

	console.log(evt.data.hash);
	evt.preventDefault();

	$('html, body').animate({
        scrollTop: $(evt.data.hash).offset().top
    }, 700);

	gotoPartnershipPage(evt);
    scrollHandler();

}

function scrollHandler(){

	var yPos = $(this).scrollTop();

	/* ---- Header modification ---------------------------------------------------------------- */

	switch(true){
		case (yPos < 120): 
			$("#container > header").removeClass('animate_out');
			$("#container > header").removeClass('fixed_nav');
			$(".campaignLink").removeClass('selected');
			$(".takePartLink").removeClass('selected');
			console.log("derp");
			break;
		case (yPos < 150):
			$("#container > header").addClass('fixed_nav');
			$("#container > header").addClass('animate_out');
			$(".selected").removeClass('selected');
			//$("#social_buttons").removeClass('fixed');
			break;
		case (yPos < 700):
			$("#container > header").removeClass('animate_out');
			$(".selected").removeClass('selected');
			$(".campaignLink").removeClass('selected');
			$(".takePartLink").removeClass('selected');
			break;
		case (yPos < 1200):
			$("#container > header").addClass('fixed_nav');
			$("#container > header").removeClass('animate_out');
			$(".selected").removeClass('selected');
			$(".campaignLink").addClass('selected');
			break;
		default:
			$("#container > header").addClass('fixed_nav');
			$("#container > header").removeClass('animate_out');
			$(".selected").removeClass('selected');
			$(".takePartLink").addClass('selected');
			break;
	}

	/* ---- Campaign: Phones Parallax ---------------------------------------------------------------- */

	switch(true){
		case (yPos < 600):
			$('#campaign_wrapper').css({'width':'146%', 'left':'-23%'});
			break;
		case (yPos <= 760):
			var diffPerc = (yPos - 600) / 160;
			var strWidth = (146 - (diffPerc * 46)) + "%";
			var strLeft = "-" + (23 - (diffPerc * 23)) + "%";
			$('#campaign_wrapper').css({'width':strWidth, 'left':strLeft});
			break;
		case (yPos < 860):
		default:
			$('#campaign_wrapper').css({'width':'100%', 'left':'0%'});
			break;
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