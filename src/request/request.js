import Vue from 'vue';
import axios from 'axios';
import qs from "qs"

//请求拦截器：对所有请求数据作统一处理
axios.interceptors.request.use(config=>{
	console.log(`当前请求地址为：${config.url}   当前请求方式为：${config.method}`);

	//获取localStorage中的用户Tocken
	config.headers.tockens = 	localStorage['userTocken']?localStorage['userTocken']:'yesok';
	//console.log(config,777);

	return config;
});



//开发环境 8080
if (process.env.NODE_ENV==="development") {
    Vue.prototype.imgHost = "http://localhost:3000"
}

//生产环境：将打包后的vue项目代码部署到服务端应用程序中
if (process.env.NODE_ENV==="production") {
    Vue.prototype.imgHost = ""
}

//响应拦截器：对所有响应数据作统一处理
axios.interceptors.response.use(d=>{

   if(d.data.code != 200){
	  console.log(`服务端返回的异常信息为：${d.data.msg}`);
   }

	return d;
});


//封装方法：通过axios.get()方法发送get请求与服务端交互
export function sendGet(url,params={},headers={}){
	//params:通过get方式发送请求时的参数
	//headers:通过请求头传参，比如：传令牌
    return axios.get(url,{params,headers})
}

//封装方法：通过axios.post()方法发送post请求与服务端交互
export function sendPost(url,params={},isFile=false,headers={}){

		let data = '';
		if(isFile) {  //params参数中含有文件上传的参数
          let formObj = new FormData();
		  for(let keys in params){
			formObj.append(keys,params[keys]);
		  }

		  data = formObj;
		}else{//params参数中没有文件上传的参数
		  //将params参数的对象(比如：{usr:'lisi',pwd:123})转换成查询字符串格式(比如：usr=lisi&pwd=123)
          data = qs.stringify(params); 
		}

	      return axios.post(url,data,{
		  headers  //通过请求头传参，比如：传令牌
		});
}
