$(function() {
  const insert_area = $('.image-upload-box'); 
  var n = 0;

  // 【関数】　Blob URL Schemeを作成する（サムネイルを表示させるURLのようなもの）
  function createBroburl(document) {
    const file_list = document.files; // ファイルリストを取得
    if(!file_list) return;
    const file = file_list[0]; // 0番目のfileオブジェクトを取得
    if(!file) return;
    var brob_url = window.URL.createObjectURL(file); // Blob URL Schemeを生成
    return brob_url;
  }
