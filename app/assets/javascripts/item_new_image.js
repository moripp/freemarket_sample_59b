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

  // 【関数】　アップロードした画像を表示させる
  function addSellImage(brob_url, n, insert_area) {
    const html = `
      <div class="sell-image-upload-container">
        <figure class="sell-image-upload-container__image-box">
          <img id="file-preview" src="${brob_url}" style="width:114px; height: 114px;">
        </figure>
        <div class="sell-image-upload-container__btn" id="sell-image-${n}"></div>
      </div>
    `;
    $(html).insertBefore(insert_area);
  }
