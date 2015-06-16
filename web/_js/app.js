$(document).ready(function(){

    $('.carousel-inner').carousel({
      	interval: 6000
    });

    $('.carousel-inner').on('slid', function() {
    	console.log("Sliding");

	    var to_slide = $('.item.active').attr('id');
	    $('.carousel-indicators').children().removeClass('active');
	    $('.carousel-indicators [data-slide-to=' + to_slide + ']').addClass('active');
  	});

});

/* ---- Social Sharing Popups ---------------------------------------------------------------- */

$('.shareButton').removeAttr('href');

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