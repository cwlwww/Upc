export default {  // 定义方法：用来返回state中的数据、同时可以对state中的数据进行二次处理
	cate(state){
		return state.cateone;
	},
	// 一级目录
	spec(state){
		return state.spec;
	},
	// 规格
	goodsArr(state){
       return state.goodsArr;
	},
	// 商品列表
	goodsone(state){
       return state.goodsone;
	},
	// 商品详情
}