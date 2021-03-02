$(document).on('turbolinks:load', function() {
  var large_area_code = $('#large_area option:selected').val();
  $('.selectbox').hide();
  $('#' + large_area_code).show().appendTo($('#selects'));
  $('#large_area').change(function() {
  large_area_code = $('option:selected', this).val();
  $('#' + large_area_code).show();
  $('.selectbox').not($('#' + large_area_code)).hide();
});
});
