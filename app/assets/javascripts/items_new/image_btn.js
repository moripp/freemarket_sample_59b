$(function() {

  // 【関数】Blob URL Schemeを作成する（サムネイルを表示させるURLのようなもの）
  function createBroburl(document) {
    const file_list = document.files; // ファイルリストを取得
    if(!file_list) return;
    const file = file_list[0]; // 0番目のfileオブジェクトを取得
    if(!file) return;
    var brob_url = window.URL.createObjectURL(file); // Blob URL Schemeを生成
    return brob_url;
  }

  // 【関数】アップロードした画像を表示させる
  function addSellImage(brob_url, n, insert_area) {
    const html = `
      <div class="sell-image-upload-container" id="sell-image-container-number-${n}">
        <figure class="sell-image-upload-container__image-box">
          <img id="file-preview" src="${brob_url}" style="width:114px; height: 114px;">
        </figure>
        <div class="sell-image-upload-container__btn">
          <div class="item-image-delete-btn" id="${n}">
            削除
          </div>
        </div>
      </div>
    `;
    $(html).insertBefore(insert_area);
  }

  // 【関数】画像アップロード済みボタンのclass名を変更
  function moveBtn(document) {
    $(document).removeClass().addClass("image-upload-btn-uploaded");
  }

  // 【関数】新しい画像アップロードボタンを追加
  function addNewInput(insert_area, n) {
    const new_input = $(`<input class="image-upload-btn"
                                accept="image/*"
                                type="file"
                                name="item[images_attributes][${n}][image]"
                                id="item_images_attributes_${n}_image"
                                >`);
    insert_area.prepend(new_input);
  }

  // 【関数】アップロードボタンのidとnameの番号、サムネのid番号を変更
  function changeNumber(num, n) {
    while(num < n) {
      const next_num = num + 1;
      // アップロードボタンのid、nama属性を修正
      const image_input = document.getElementById(`item_images_attributes_${next_num}_image`);
      image_input.removeAttribute('name');
      image_input.removeAttribute('id');
      image_input.setAttribute('name', `item[images_attributes][${num}][image]`);
      image_input.setAttribute('id', `item_images_attributes_${num}_image`);

      if(num < n-1) {
        // サムネのid属性修正
        const image_sell = document.getElementById(`sell-image-container-number-${next_num}`);
        image_sell.removeAttribute('id');
        image_sell.setAttribute('id', `sell-image-container-number-${num}`);
        // 削除ボタンのid属性修正
        const image_delete = document.getElementById(`${next_num}`);
        image_delete.removeAttribute('id');
        image_delete.setAttribute('id', `${num}`);
      };
      num = next_num;
    };
  }
//////////////////////////////////////////////////////////////////////////

  var n = 0;

  // 【A】画像アップロードを終えるとサムネを表示
  const insert_area = $('.image-upload-box'); 
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

  // 【B】削除ボタンを押すとアップロードした画像を削除
  $(document).on('click', '.item-image-delete-btn', function(e) {
    var num = Number($(this).attr('id'));
    $(`#sell-image-container-number-${num}`).remove(); // サムネ削除
    $(`#item_images_attributes_${num}_image`).remove(); // アップロードボタン削除
    changeNumber(num, n); // 必要な番号を変える
    n = n - 1;
  });
});