// チェックボックスを押すと、パスワードが表示されるようにする
$(function() {
  const password = document.getElementById('user_password'); // パスワードのinputタグを取得
  const check = document.getElementById('password_check'); // チェックボックスのinputタグを取得

  if(password != null & check != null) { // 目的のページを開いている時だけ作動させる
    check.addEventListener('change', function() { // チェックボックスが押された時、イベント発火
      if(check.checked) {
        password.setAttribute('type', 'text'); // パスワードのtype属性をtextに変更
      } else {
        password.setAttribute('type', 'password'); // パスワードのtype属性をpasswordに変更
      };
    }, false);
  };
});