$(document).on('turbolinks:load', function() {
  // // 大エリアのセレクトボックスで選択中のエリアコードを変数large_area_codeに代入
  // var large_area_code = $('#large_area option:selected').val();
  // // 中エリアのセレクトボックスをすべて非表示に
  // $('.selectbox').hide();
  // // 選択中の大エリアのコードと同名のIDが振られたDIV要素（中エリアセレクトボックス）のみ表示する
  // $('#' + large_area_code).show().appendTo($('#selects'));
  // // 大エリアのセレクトボックスで別のエリアを選択したら
  // $('#large_area').change(function() {
  // // 現在選択中の大エリアコードをlarge_area_codeに上書き
  // large_area_code = $('option:selected', this).val();
  // // 新しい大エリアコードと同名のIDが振られたDIV要素（中エリアセレクトボックス）を表示
  // $('#' + large_area_code).show();
  // // 新たに表示したDIV要素以外の中エリアセレクトボックスを非表示に
  // $('.selectbox').not($('#' + large_area_code)).hide();
  var large_area_code = $('#large_area option:selected').val();
  $.ajax(
  {
    url: '/api',
    type: 'GET',
    dataType: 'json',
    data: {
      "api": large_area_code
    },
    success: function(data) {
      for (let i = 0; i < data.results.middle_area.length; i++) {
          $('#middle_area_box').append(`<option value="${data.results.middle_area[i].code}">${data.results.middle_area[i].name}</option>`);
      }
    }
  });
  $('#large_area').change(function() {
      large_area_code = $('#large_area option:selected').val();
      $('#middle_area_box').empty();
      $.ajax(
      {
        url: '/api',
        type: 'GET',
        dataType: 'json',
        data: {
          "api": large_area_code
        },
        success: function(data) {
          for (let i = 0; i < data.results.middle_area.length; i++) {
              $('#middle_area_box').append(`<option value="${data.results.middle_area[i].code}">${data.results.middle_area[i].name}</option>`);
          }
        }
      });
  });
});
