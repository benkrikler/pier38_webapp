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
  if($('#anchor').length){
    $('html, body').animate({
      scrollTop: $('#anchor').offset().top
    }, 1000);
  }
  hideSecond();
  $('#audio-form').hide();
});
