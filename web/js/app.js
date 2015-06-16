/* 
- HUMO's Invasie 
- App Onepager Promo for Humo's Invasie App 
- v1.0.0 
- MIT licensed 
- Copyright (C) 2015 Thorr Stevens & Wannes Monchy 
*/

(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
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
},{}]},{},[1])


//# sourceMappingURL=app.js.map