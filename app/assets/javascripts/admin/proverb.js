// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

if (document.getElementById('vue-proverb')) {

var vue_proverb = new Vue({
  el: '#vue-proverb',
  name: 'vue-proverb',
  data: function() {
    return {
      proverb_index: [],
      proverb: {
        name: '',
        kana: '',
        text: '',
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
    validation: function() {
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
    data: function() {
      return {
        proverb: {
          id: gon.id,
          name: '',
          kana: '',
          text: '',
        },
      }
    },
    created: function() {
      this.get(this.proverb.id);
    },
    computed: {
      validation: function() {
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
        axios.get('/admin/proverb/' + id).then(response => {
          this.proverb.name = response.data.name;
          this.proverb.kana = response.data.kana;
          this.proverb.text = response.data.text;
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