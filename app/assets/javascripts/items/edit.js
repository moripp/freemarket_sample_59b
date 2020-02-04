$(function() {
  // 【関数】保存済みの画像をサムネ表示
  function addSellSavedImage(index, value, insert_area) {
    const html = `
      <div class="sell-image-upload-container" id="sell-image-container-number-${index}">
        <figure class="sell-image-upload-container__image-box">
          <img id="file-preview" src="${value.image.url}" style="width:114px; height: 114px;">
        </figure>
        <div class="sell-image-upload-container__btn">
          <div class="item-image-delete-btn gon_item_images" id="${index}" data-id="${value.id}">
            削除
          </div>
        </div>
      </div>
    `;
    $(html).insertBefore(insert_area);
  }

  const images = gon.item_images; // items_controllerのインスタンス変数を使う準備
  const insert_area = $('.image-upload-box'); 

  if(images) { // 出品ページで動くと困るので条件定義
    const images_length = images.length;
    n = images_length - 1;

    // 保存済みの画像をサムネ表示
    images.some(function(value, index) {
      if(index == n){return;}
      addSellSavedImage(index, value, insert_area);
      $(`#item_images_attributes_${index}_image`).remove(); // 不要なinputが作成されてしまうので削除
      $(`#item_images_attributes_${index}_id`).remove(); // 不要なinputが作成されてしまうので削除
    });  
  };
