import Vue from 'vue'
import App from './App.vue'
import './assets/css/global.css'
import {store} from './store/store.js'
require('buffer')


// For crypto library and browserify
global.Buffer = global.Buffer || require("buffer").Buffer; 

// I dunno
Vue.config.productionTip = false

// //Routing
// const routes = [
//   { path: '/', component: Principal },
//   { path: '/legal', component: Legal }
// ]

// const router = new VueRouter({
//   routes
// })

//Init with index.html
new Vue({
  render: h => h(App),
  store
  // router,
}).$mount('#app')
