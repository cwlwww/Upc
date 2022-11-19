module.exports={
	publicPath:'',  //项目部署路径
	outputDir:'build', //项目编译后的存放目录
	assetsDir:'public', //项目编译后的静态资源存放目录
	indexPath:'index.html',//指定编译后生成的 index.html 的输出路径
	devServer:{
		proxy:{
			'/api':{
				target:'http://localhost:3000',
				ws:true,//用于支持websocket
				changeOrigin:true  //开启跨域调用
			}
		}
	}
}