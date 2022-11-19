import Vue from 'vue'

//设置全局过滤器：
import transprice from "./transprice.js";
import transtel from './transtel.js';

let obj = {transprice,transtel};

for(let keys in obj){
	Vue.filter(keys,obj[keys]);
}
// Vue.filter('transprice',transprice);
// Vue.filter('transtel',transtel);