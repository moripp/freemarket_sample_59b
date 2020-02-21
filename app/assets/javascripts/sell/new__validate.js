// 出品ページのフォームにバリデーションをかける
$(function(){
  //form指定
  $('#exhibit-form').validate({
    //バリデーション、ルール設定
    rules: {
      "item[images_attributes][0][image]": { //画像
        required: true, //入力必須
      },
      "item[name]": { //商品名
        required: true, //入力必須
        maxlength: 40 //40文字以内
      },
      "item[description]": { //商品説明
        required: true, //入力必須
        maxlength: 1000 //1000文字以内
      },
      "item[price]": { //商品価格
        required: true, //入力必須
        number: true, //整数限定
        range: [300, 9999999] //300以上9999999以内
      }
    },
    //エラーメッセージ設定
    messages: {
      "item[images_attributes][0][image]": { //画像
        required: '画像がありません'
      },
      "item[name]": { //商品名
        required: '入力してください',
        maxlength: '40文字以内で入力してください'
      },
      "item[description]": { //商品説明
        required: '入力してください',
        maxlength: '1000文字以内で入力してください'
      },
      "item[price]": { //商品価格
        required: '300以上9,999,999以下で入力してください',
        number: '300以上9,999,999以下で入力してください',
        range: '300以上9,999,999以下で入力してください'
      }

    },
    //エラーメッセージ出力場所設定
    errorPlacement: function(error, element){
      // 画像と商品価格に関してのエラー文はデフォルトだと変な場所に出力される。その為場所を指定している。
      if(element.attr("name")=="item[images_attributes][0][image]")
      {
        error.insertAfter("#exhibit-form-image");	
      }
      else if(element.attr("name")=="item[price]")
      {
        error.insertAfter("#exhibit-form-price");	
      }
      else{
        error.insertAfter(element);	
      }
    }
  });
});