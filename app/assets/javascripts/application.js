// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
    $('a').mouseenter(function() {
    $(".main_logo").addClass("fa-spin");
    $(".main_logo").css("color", "#18bc9c");
    $(".navbar").css("background-color", "black");
    // $(".main_logo").removeClass("leave");
  });
  $('a').mouseleave(function() {
    $(".main_logo").removeClass("fa-spin");
    $(".main_logo").css("color", "white");
    $(".navbar").css("background-color", "#383838");
    // $(".main_logo").addClass("leave");
  });

  $('.allDrills').on('click', function() {
    $('.big-well').show();
    $('.userDrills').hide();
  });

  $('.myDrills').on('click', function() {
    $('.big-well').hide();
    $('.userDrills').show();
  });

  var url = window.location;
  $('ul.nav a[href="'+ url +'"]').parent().addClass('active');
  $('ul.nav a').filter(function() {
       return this.href == url;
  }).parent().addClass('active');

  $('.btn-engage').on('mouseenter', function() {
    $('.titler').removeClass('intro-title');
    $('.titler').addClass('intro-title-hover');
  });
  $('.btn-engage').on('mouseleave', function() {
    $('.titler').removeClass('intro-title-hover');
    $('.titler').addClass('intro-title');
  });
  $('[data-toggle="tooltip"]').tooltip();

  $('.btntoggler').on('mouseenter', function() {
    $(this).parent().addClass('drills-inner-container2');
    $(this).parent().removeClass('drills-inner-container');
    $(this).prev().prev().children().css('color', 'white');

  });
  $('.btntoggler').on('mouseleave', function() {
    $(this).parent().addClass('drills-inner-container');
    $(this).parent().removeClass('drills-inner-container2');
    $(this).prev().prev().children().css('color', '#051938');
  });
});
