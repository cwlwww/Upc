var express = require('express');
var router = express.Router();
const tableName = 'cart'
const tableNameGoods = 'goods'
const tableNameOrder = 'shop_order'
const tableNameOrders = 'orders'
const tableNameMember = 'member'
const { Success, MError } = require("../utils/Result");
const Db = require("../utils/Db");
const {orderCode} = require("../utils");
moment = require('moment')//引入处理时间模块


///提交订单 
router.post("/orderadd", async (req, res) => {
	// 获取订单基本参数
    let { uid, countmoney,countnumber,addressid,idstr } = req['body'];
	if (idstr=='' || uid=='' || countmoney<=0 || countnumber <=0 || addressid == '') {
	    res.send(MError("缺少必要参数"));return;
    }
    
    let ordernumber = orderCode();////生成主订单数据订单号
	let nowTime = moment(new Date()).format('YYYY-MM-DD HH:mm:ss');//追加主订单生成时间
	let insertData={uid,addressid,countmoney,countnumber,ordernumber,addtime:nowTime}//组装主订单数据
    let result = await Db.insert(req, tableNameOrder, insertData); // 添加主订单数据
    
    //根据购物车数据id 连表查询购物车表和商品详情表，其实订单详情就是把购物车中的数据搬移到订单详情表中
    let sql = `SELECT a.*,b.goodsname,b.price,b.img FROM ${tableName} a LEFT 
                JOIN ${tableNameGoods} b ON a.goodsid = b.id WHERE a.id IN (${idstr})`;
    let cartData = await Db.select(req,sql);
    // console.log(cartData);return;

    let subordernumber = '';//初始子订单编号字符串；
    // 处理购物车数据，将购物车id去掉添加主订单id和子订单编号
    cartData.forEach((item,index) => {
        delete (item.id);
        delete (item.status);
        item.orderid = result;//追加主订单id
		item.subordernumber = 'sub_'+index+'_'+ordernumber;//追加子订单号
        // item.addressid = addressid;//追加收货地址id
        
        // subordernumber+='sub_'+index+'_'+ordernumber+',';
    })
    // subordernumber = subordernumber.substr(0,subordernumber.length-1);
    // console.log(subordernumber);return;

    // 批量添加子订单数据
    orderresult = await Db.insertAll(req, tableNameOrders, cartData);
    // 批量删除购物车中的数据 
    const deleteresult = await Db.delete(req, `DELETE FROM ${tableName} WHERE id IN (${idstr})`);
    // console.log(deleteresult);
    // 执行成功后发起
    if (orderresult) {
        // 订单生成功后返回主单编号字符串和总支付金额
        res.send(Success({outTradeNo:ordernumber}, "提交订单成功"));
    } else {
        res.send(MError("添加失败，请查看字段信息是否正确"));
    }
});


// 订单查询分页版本（前台系统pc h5 小程序）
router.get('/orderlist',async(req,res)=>{
    // 获取用户的uid
    let {uid,page=1,size=10,status} = req['query'];
    // console.log(uid,page,size);return;
    if (!uid) {
	    res.send(MError("缺少必要条件"));return;
    }
	
    // 连接订单主表和订单详情表
    let sql = `SELECT a.*,
                b.id as subid,b.goodsid,b.goodsname,b.price,b.num,b.img,b.subordernumber
                FROM ( SELECT * from  ${tableNameOrder} `; 
				
	// 组装获取总页码数sql
	let countSql = `SELECT count(id) as count from  ${tableNameOrder} `;
			
	// 拼接订单状态
	if(status){
	    sql+=' WHERE status = '+status;
		countSql+=' WHERE status = '+status;
	}
		
	// 拼接分页参数
	if(size && page){
	    let pagesize = (page-1)*size;//设置偏移量
	    sql += ` LIMIT ${pagesize},${size} `;
	}
				
    sql+= `) AS a inner JOIN ${tableNameOrders} AS b
                ON a.id = b.orderid and a.uid='${uid}' and b.uid='${uid}'`;
	
	// console.log(sql);return;
    const orderData = await Db.select(req, sql);
    // console.log(orderData);return;
    if(orderData == null){
        res.send(Success(orderData));
    }else{
		// 获取总页码数
		let countNum = await Db.select(req,countSql);
		let totalPage = Math.ceil(countNum[0].count / size);
		console.log(totalPage)
        let dataInfo = {};
        orderData.forEach((item, index) => {
            let { id,uid,ordernumber,tradeno,countmoney,countnumber,addtime,status} = item;
            if (!dataInfo[id]) {
                dataInfo[id] = {
                    id,	
                    uid,
                    ordernumber,
					tradeno,
                    countmoney,
                    countnumber,
                    addtime,
					status,
                    child: []
                }
            }
            dataInfo[id].child.push({subid:item.subid,subordernumber:item.subordernumber,goodsid:item.goodId,goodsname:item.goodsname,
                img:item.img,price:item.price,num:item.num});
        });
        let data = Object.values(dataInfo); //list 转换成功的数据
        // console.log(list);return;
        // 返回最终的数据
        res.send(Success({totalPage,data}));
    }
})


// 订单查询分页版本(商城管理系统)
router.get('/orderall',async(req,res)=>{
	
    // 获取用户的uid
    let {page=1,size=10} = req['query'];
	
	//查询订单主表 
    let sql = `SELECT a.*,u.id as uid,u.nickname,u.phone FROM ( SELECT * from  ${tableNameOrder} `; 
    			
    // 组装获取总页码数sql
    let countSql = `SELECT count(id) as count from  ${tableNameOrder} `;
    		
    	
    // 拼接分页参数
    if(size && page){
        let pagesize = (page-1)*size;//设置偏移量
        sql += ` LIMIT ${pagesize},${size} `;
    }
	
	sql+= `) AS a inner JOIN ${tableNameMember} AS u
	            ON a.uid = u.uid`;
    			
    // console.log(sql);return;

	// 获取分页数据
    const orderData = await Db.select(req, sql);
	
	// 获取总页码数
	let countNum = await Db.select(req,countSql);
	let totalPage = Math.ceil(countNum[0].count / size);
	
	res.send(Success({totalPage,orderData}));
})


// 修改订单状态
router.post('/orderedit',async(req,res)=>{
	// 获取订单数据id 修改后状态 
	let {id,couriernumber,couriercode,status} = req['body'];
	console.log(id,couriernumber,couriercode);
	if (!id) {
	    res.send(MError("缺少必要条件"));return;
	}
	// 执行修改订单
	let updateData='';
	if(status == 2){
		updateData={couriernumber,couriercode,status};
	}else{
		updateData={status};
	}
	
	let result = await Db.update(req, tableNameOrder, updateData, ` WHERE id = ${id}`);
	 result === true ? res.send(Success()) : res.send(MError(result));
}),


// 导出
module.exports = router;

