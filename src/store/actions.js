
import { goodsCateList,getGoodsSpec,getGoods,getOneGoodsOne,delGoods,addGoodsinfo,getOnespecsone } from '../request/api'

export default { // 定义方法：执行异步操作或业务处理

	getCateList(context){
		goodsCateList().then(d=>{
			if(d.data.code == 200){
				context.commit('updateCate',d.data.list);
			}
		})
	},

	getGoodsSpec(context){
		getGoodsSpec().then(d=>{
			if(d.data.code == 200){
				context.commit('updateSpec',d.data.list);
			}
		})
	},
	//调用商品列表接口：
	getGoods(context) {
		getGoods().then(d => {
			if (d.data.code == 200) {
				context.commit('updateGood', d.data.list);
				console.log(d.data.list);
			}

		})
	},
	// 添加商品
	addGoods(context,goods){
		addGoodsinfo(goods).then(d=>{
			console.log(goods);
			if(d.data.code == 200){
				console.log('添加成功');
			}
		})
	},
	// 删除商品
	delGoods(commit,id) {
		delGoods({id:id}).then(d => {
			if (d.data.code == 200) {
				console.log(d.data.list);
			}
		})
	},
	// 调用商品详情接口：
	getOneGoodsOne(context) {
		getOneGoodsOne().then(d => {
			if (d.data.code == 200) {
				context.commit('updateGoodOne', d.data.list);
				console.log(d.data.list);
			}
		})
	},
}