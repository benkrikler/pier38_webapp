// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets

function hideFirst() {
  $('#first-buttons').hide();
}

function showFirst() {
  $('#first-buttons').show();
}

function hideSecond() {
  $('#second-buttons').hide();
}

function showSecond() {
  $('#second-buttons').show();
}

function audioCheck(){
  console.log('audio test');
}

function startTest(){
  console.log('start test');
  hideFirst();
  showSecond();
}

function buttonYes(){
  console.log('yes');
}

function buttonNo(){
  console.log('no');
  $('#audio-form').submit();
}

function submitForm(){

}

$(document).on('turbolinks:load', function() {
  hideSecond();
  $('#audio-form').hide();
});
