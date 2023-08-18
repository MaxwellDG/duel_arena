import { createApp } from 'vue'
import App from './App.vue'
import './assets/css/global.less'
import './assets/css/fonts.css'
import './assets/css/base.less'
import './assets/css/new-bet.less'
import store from './store/store.js'

import vSelect from 'vue-select';
import 'vue-select/dist/vue-select.css';
import Web3Client from './web3/web3Client'

const app = createApp(App)

// For crypto and browserify
require('buffer')
global.Buffer = global.Buffer || require("buffer").Buffer; 

app.component('v-select', vSelect)
app.use(store)

app.provide('$web3', new Web3Client()); // Provides global access to web3 

app.mount('#app');

