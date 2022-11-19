export default {  //定义方法：这些方法用来修改state数据的值
	updateCate(state,data){
		state.cate = data;
	},
	// 一级目录
	updateSpec(state,data){
		state.spec = data;
	},
	// 规格
	updateGood(state,goods){
		// console.log(state,names,1113);
		state.goodsArr = goods;
	},
	updateGoodOne(state,goodsone){
		// console.log(state,names,1113);
		state.goodsOne = goodsone;
	},
}