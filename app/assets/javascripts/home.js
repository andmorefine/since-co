// axios を require してインスタンスを生成する
const axiosBase = require('axios');
const axios = axiosBase.create({
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  },
  responseType: 'json'
});

if (document.getElementById('vue-app')) {

var vue_app = new Vue({
  el: '#vue-app',
  name: 'vue-app',
  data: function() {
    return {
      user_index: [],
      user: {
        name: '',
        message: 'Hello Vue!'
      },
    }
  },
  created: function() {
    this.get();
  },
  computed: {
    userIndex: function() {
      return this.user_index;
    },
    validation: function() {
      var user = this.user;
      return {
        name: (!!user.name),
      };
    },
    isValid: function() {
      return Object.values(this.validation).every(val => val);
    },
  },
  methods: {
    // get: function() {
    //   axios.get('/user/').then(response => {
    //     this.user_index = response.data;
    //   });
    // },
    // deleteIndex: function(id) {
    //   axios.delete('/user/', {data: id}).then(response => {
    //     this.get();
    //   });
    // },
    post: function() {

      if (!this.isValid) {
        $('.is-valid-modal').modal('show');
        return false;
      }

      // axios.post('/user/', this.user).then(response => {
      //   this.user.name = "";
      //   this.get();
      // });
    },
  }
});
}
