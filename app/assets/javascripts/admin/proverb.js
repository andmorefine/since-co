// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// クエリストリングのパース
var qs = require('qs');

var image_mixin = require('mixin_image.js');
var alphabetal_mixin = {
  data: function () {
    return {
      alphabetal_index: {},
    };
  },
  created: function () {
    this.getAlphabetal();
  },
  methods: {
    getAlphabetal: function () {
      axios.get('/admin/proverb/alphabetal').then(response => {
        this.alphabetal_index = response.data;
      });
    },
  },
};

if (document.getElementById('vue-proverb')) {

var vue_proverb = new Vue({
  el: '#vue-proverb',
  name: 'vue-proverb',
  mixins: [image_mixin, alphabetal_mixin],
  data: function() {
    return {
      proverb_index: [],
      proverb: {
        name: '',
        kana: '',
        text: '',
        image: '',
        alphabetal_id: '0',
      },
      query: {
        name_cont: null,
        page: 1,
        limit: 50,
      }
    }
  },
  created: function() {
    this.get();
  },
  computed: {
    proverbIndex: function() {
      return this.proverb_index;
    },
    validation: function () {
      this.proverb.image = this.uploadFileName;
      var proverb = this.proverb;
      return {
        name: (!!proverb.name),
        kana: (!!proverb.kana),
        text: (!!proverb.text),
      };
    },
    isValid: function() {
      return Object.values(this.validation).every(val => val);
    },
  },
  methods: {
    get: function () {
      var params = {
        q: this.query
      };
      const paramsSerializer = (params) => qs.stringify(params);
      // params = qs.stringify(params, { arrayFormat: 'brackets' });
      console.log(params);
      axios.get('/admin/proverb/preview', { params, paramsSerializer }).then(response => {
        this.proverb_index = response.data;
      });
    },
    deleteIndex: function(id) {
      axios.delete('/admin/proverb', {data: id}).then(response => {
        this.get();
      });
    },
    proverbPost: function() {
      if (!this.isValid) {
        $('.is-valid-modal').modal('show');
        return false;
      }
      axios.post('/admin/proverb', this.proverb).then(response => {
        this.proverb.name = "";
        this.proverb.kana = "";
        this.proverb.text = "";
        this.proverb.image = "";
        this.proverb.alphabetal_id = "0";
        $(".preview-photo").empty();
        this.get();
      });
    },
  }
});
}

if (document.getElementById('vue-proverb-edit')) {
  var vue_proverb_edit = new Vue({
    el: '#vue-proverb-edit',
    name: 'vue-proverb-edit',
    mixins: [image_mixin, alphabetal_mixin],
    data: function() {
      return {
        proverb: {
          id: gon.id,
          name: '',
          kana: '',
          text: '',
          image: '',
          alphabetal_id: '0',
          delete_flag: false,
        },
        versions: [],
      }
    },
    created: function() {
      this.get(this.proverb.id);
      this.getVersions(this.proverb.id);
    },
    computed: {
      customSwitch: function() {
        return this.proverb.delete_flag ? '非表示' : '表示';
      },
      validation: function() {
        this.proverb.image = this.uploadFileName;
        var proverb = this.proverb;
        return {
          name: (!!proverb.name),
          kana: (!!proverb.kana),
          text: (!!proverb.text),
        };
      },
      isValid: function() {
        return Object.values(this.validation).every(val => val);
      },
    },
    methods: {
      get: function (id) {
        axios.get('/admin/proverb/' + id + '/fetch').then(response => {
          this.proverb.name = response.data.name;
          this.proverb.kana = response.data.kana;
          this.proverb.text = response.data.text;
          this.proverb.image = response.data.image;
          this.proverb.alphabetal_id = response.data.alphabetal_id;
          this.proverb.delete_flag = response.data.delete_flag ? true : false ;
        });
      },
      getVersions: function (id) {
        axios.get('/admin/proverb/' + id + '/versions').then(response => {
          this.versions = response.data;
        });
      },
      proverbUpdate: function () {
        var self = this;
        if (!this.isValid) {
          $('.is-valid-modal').modal('show');
          return false;
        }
        axios.put('/admin/proverb/' + this.proverb.id, this.proverb).then(response => {
          self.get(this.proverb.id);
          self.getVersions(this.proverb.id);
        });
      },
    }
  });
}
