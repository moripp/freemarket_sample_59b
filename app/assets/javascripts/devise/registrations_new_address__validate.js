// ユーザー新規登録new_addressページのフォームにバリデーションをかける
$(function(){
  //form指定
  $('#new_address').validate({
    //バリデーション、ルール設定
    rules: {
      "address[name_sei]": { //名前 姓
        required: true //入力必須
      },
      "address[name_mei]": { //名前 名
        required: true //入力必須
      },
      "address[kana_sei]": { //カナ 姓
        required: true, //入力必須
        katakana: true //全角カタカナ
      },
      "address[kana_mei]": { //カナ 名
        required: true, //入力必須
        katakana: true //全角カタカナ
      },
      "address[postal_code]": { //郵便番号
        required: true, //入力必須
        postnum: true //郵便番号
      },
      "address[prefectures]": { //都道府県
        required: true //入力必須
      },
      "address[city]": { //市区町村
        required: true //入力必須
      },
      "address[address]": { //番地
        required: true //入力必須
      }
    },
    //エラーメッセージ設定
    messages: {
      "address[name_sei]": { //名前 姓
        required: '入力してください'
      },
      "address[name_mei]": { //名前 名
        required: '入力してください'
      },
      "address[kana_sei]": { //カナ 姓
        required: '入力してください',
        katakana: "全角カタカナで入力してください"
      },
      "address[kana_mei]": { //カナ 名
        required: '入力してください',
        katakana: "全角カタカナで入力してください"
      },
      "address[postal_code]": { //郵便番号
        required: '入力してください',
        postnum: '郵便番号を入力してください（半角のみ）'
      },
      "address[prefectures]": { //都道府県
        required: '入力してください'
      },
      "address[city]": { //市区町村
        required: '入力してください'
      },
      "address[address]": { //番地
        required: '入力してください'
      }
    },
    //エラーメッセージ出力場所設定
    errorPlacement: function(error, element){
      error.insertAfter(element);	
    }
  });
});