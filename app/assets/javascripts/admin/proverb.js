// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var image_mixin = require('mixin_image.js');


if (document.getElementById('vue-proverb')) {

var vue_proverb = new Vue({
  el: '#vue-proverb',
  name: 'vue-proverb',
  mixins: [image_mixin],
  data: function() {
    return {
      proverb_index: [],
      proverb: {
        name: '',
        kana: '',
        text: '',
        image: '',
      },
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
      };
    },
    isValid: function() {
      return Object.values(this.validation).every(val => val);
    },
  },
  methods: {
    get: function() {
      axios.get('/admin/proverb/preview').then(response => {
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
    mixins: [image_mixin],
    data: function() {
      return {
        proverb: {
          id: gon.id,
          name: '',
          kana: '',
          text: '',
          image: '',
        },
      }
    },
    created: function() {
      this.get(this.proverb.id);
    },
    computed: {
      validation: function() {
        this.proverb.image = this.uploadFileName;
        var proverb = this.proverb;
        return {
          name: (!!proverb.name),
        };
      },
      isValid: function() {
        return Object.values(this.validation).every(val => val);
      },
    },
    methods: {
      get: function(id) {
        axios.get('/admin/proverb/' + id + '/fetch').then(response => {
          this.proverb.name = response.data.name;
          this.proverb.kana = response.data.kana;
          this.proverb.text = response.data.text;
          this.proverb.image = response.data.image;
        });
      },
      proverbUpdate: function() {
        if (!this.isValid) {
          $('.is-valid-modal').modal('show');
          return false;
        }
        axios.put('/admin/proverb/' + this.proverb.id, this.proverb).then(response => {

        });
      },
    }
  });
}
