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

  // 【関数】　画像アップロード済みボタンのclass名を変更し、場所を移動
  function moveBtn(document, n) {
    $(document).removeClass().addClass("image-upload-btn-uploaded");
    const insert_area = $(`#sell-image-${n}`);
    $(document).appendTo(insert_area);
  }

  // 【関数】　新しい画像アップロードボタンを追加
  function addNewInput(insert_area, n) {
    const new_input = $(`<input class="image-upload-btn"
                                accept="image/*"
                                type="file"
                                name="item[images_attributes][${n}][image]"
                                id="item_images_attributes_${n}_image"
                                >`);
    insert_area.prepend(new_input);
  }

  $(document).on('change', '.image-upload-btn',function(e) {
    const brob_url = createBroburl(this); // Brob URL Scheme 作成

    addSellImage(brob_url, n, insert_area); // アップロード画像を表示

    moveBtn(this, n); // 画像アップロードを終えたボタンのclass名変更、場所移動

    if(n < 9) {
      // 新しいボタンを追加
      n = n + 1;
      addNewInput(insert_area, n);
    };
  });
});