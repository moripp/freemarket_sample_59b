// ユーザー新規登録newページのフォームにバリデーションをかける
$(function(){
  //form指定
  $('#new_user').validate({
    //バリデーション、ルール設定
    rules: {
      "user[nickname]": { //ニックネーム
        required: true //入力必須
      },
      "user[email]": { //Eメール
        required: true, //入力必須
        email: true //email確認
      },
      "user[password]": { //パスワード
        required: true, //入力必須
        alphanum: true, //半角英数字で入力 英数字両方含む
        minlength: 7 //7文字以上
      },
      "user[name_sei]": { //名前 姓
        required: true //入力必須
      },
      "user[name_mei]": { //名前 名
        required: true //入力必須
      },
      "user[kana_sei]": { //カナ 姓
        required: true, //入力必須
        katakana: true //全角カタカナ
      },
      "user[kana_mei]": { //カナ 名
        required: true, //入力必須
        katakana: true //全角カタカナ
      }
    },
    //エラーメッセージ設定
    messages: {
      "user[nickname]": { //ニックネーム
        required: '入力してください'
      },
      "user[email]": { //Eメール
        required: '入力してください',
        email: '有効なEメールアドレスを入力してください'
      },
      "user[password]": { //パスワード
        required: '入力してください',
        alphanum: '半角英数字のみで入力してください（英字と数字の両方を含めて設定してください）',
        minlength: '7文字以上で入力してください'
      },
      "user[name_sei]": { //名前 姓
        required: '入力してください'
      },
      "user[name_mei]": { //名前 名
        required: '入力してください'
      },
      "user[kana_sei]": { //カナ 姓
        required: '入力してください',
        katakana: "全角カタカナで入力してください"
      },
      "user[kana_mei]": { //カナ 名
        required: '入力してください',
        katakana: "全角カタカナで入力してください"
      }
    },
    //エラーメッセージ出力場所設定
    errorPlacement: function(error, element){
      error.insertAfter(element);	
    }
  });
});