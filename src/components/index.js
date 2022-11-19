import Vue from 'vue'

//引入全局组件：
//  import footerbar from "./footerbar.vue";

//let obj = {goback:goback,headers:headers};
let obj = {};

for(let keys in obj){
	//设置全局组件：
	Vue.component(keys,obj[keys]);
}