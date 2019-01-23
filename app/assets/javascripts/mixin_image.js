// mixin item image
module.exports = {
  data: function () {
    return {
      upload_dir: "/proverb",
      upload_file: null,
      upload_file_name: "",
      is_image_view: true,
    };
  },
  computed: {
    imageItemDir: function () {
      return this.upload_dir;
    },
    uploadFileName: function () {
      return this.upload_file_name;
    },
    validationImage: function() {
      return {
        upload_dir: (!!this.upload_dir),
        upload_file: (!!this.upload_file),
      }
    },
    isValidImage: function() {
      return Object.values(this.validationImage).every(val => val);
    },
  },
  methods: {
    selectedFile: function(e) {
      var file_obj = e.target.files;
      e.preventDefault();
      // 画像ファイル以外の場合は何もしない
      $.each(file_obj, function(index, value) {
        if(value.type.indexOf("image") < 0){
          alert('画像以外が含まれています');
          return false;
        }
      });
      // 選択された File の情報を保存しておく
      this.upload_file = file_obj;
      this.updatePreview();
    },
    updatePreview: function() {
      var tmp_preview = $(".preview-photo");
      var self = this;
      //既存のプレビューを削除
      tmp_preview.empty();
      $.each(this.upload_file, function(index, file) {
        // オブジェクト生成
        var reader = new FileReader();
        // ファイル読み込みが完了した際のイベント登録
        reader.onload = (function(file) {
          return function(e) {
            var preview_num = 'preview-div-' + index;
            // .prevewの領域の中にロードした画像を表示するimageタグを追加
            tmp_preview.append($('<div>').attr({
              class: preview_num + ' col-3 p-2',
            }));
            var tmp_preview_div = $('.' + preview_num);
            tmp_preview_div.append($('<img>').attr({
              src: e.target.result,
              width: '100%',
              class: 'img-fluid img-thumbnail mt-2',
              title: file.name
            }));
            tmp_preview_div.append($('<div>').attr({
              class: 'text-center',
            }).text(file.name));
            self.upload_file_name = file.name;
          };
        })(file);
        reader.readAsDataURL(file);
      });
    },
    upload: function() {
      var upload_dir = this.upload_dir;
      var upload_file = this.upload_file;
      // error
      var error_messege = '';
      if (!this.validationImage.upload_dir) {
        error_messege += 'アップロード先を指定してね\n'
      }
      if (!this.validationImage.upload_file) {
        error_messege += 'アップロードするファイルを選択してね\n'
      }
      if (!this.isValidImage) {
        alert(error_messege);
        return false;
      }
      // s3 に アップロード
      $.each(upload_file, function(index, file) {
        axios.post('/item/save_s3_images', {
          file_name: file.name,
          file_path: upload_dir + '/',
          content_type: file.type,
          size: file.size,
        }).then(
          response => {
            // サーバが返した情報をそのまま使ってFormDataを作成
            var data = response.data;
            var name, form_data = new FormData();
            for (name in data.form) if (data.form.hasOwnProperty(name)) {
              form_data.append(name, data.form[name]);
            }
            form_data.append('file', file);
            // 送信
            return axios.post(data.url, form_data);
          },
          response => {
            alert('画像をアップロードできません');
            return false;
        });
      });
      // 表示
      $(".message-area").append($('<div>').attr({
        class: 'alert alert-success mt-3',
      }).text(upload_file.length + '枚の画像がアップロードされました'));
    },
    clearImage: function() {
      this.is_image_view = false;
      this.upload_file = null;
      this.$nextTick(function () {
        this.is_image_view = true
         this.updatePreview();
      })
    },
  }
};
