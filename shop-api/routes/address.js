var express = require('express');
var router = express.Router();
const tableName = 'address'
const { Success, MError } = require("../utils/Result");
const Db = require("../utils/Db");


//添加收货地址数据 
router.post("/addressadd", async (req, res) => {
    let {uid,username,userphone,useraddress,status=0,label='家',location,regioncode=""} = req['body'];
    console.log(3333,req['body']);

	if (!uid || !username || !userphone || !useraddress || !location) {
	    res.send(MError("缺少必要字段"));return;
    }else{
        // 组装收获地址数据
        let insertData = {uid,username,userphone:userphone.toString(),location,regioncode,useraddress,status,label}
        // console.log(insertData);return;
        // 添加收获地址数据
        result = await Db.insert(req, tableName, insertData);
        // console.log(result);
        if (result) {
            res.send(Success([], "地址添加成功"));
        } else {
            res.send(MError("添加失败，请查看字段信息是否正确"));
        }
    }
    
});

// 查询当前用户下的收货地址
router.get('/addresslist', async (req, res) => {
    // 获取uid
    let {uid,id,status} = req['query'];
    // console.log(uid);
    if (!uid) {
        res.send(MError("缺少必要条件"));
        return;
    }else{
        // 组装sql  根据用户的uid查询收获地址列表
        let sql = `SELECT * FROM  ${tableName} where uid = '${uid}'`;
		if(id){
			sql+= ` AND id = ${id}`
		};
		
		if(status){
			sql+= ` AND status = ${status}`;
			let  addresslist = await Db.select(req, sql);
			// console.log(addresslist);return;
			if(addresslist == null && status == 1 && !id){// 兼容生成订单查询默认地址 如果没有默认地址就返回全部收货地址
				// 再次查询status == 0的数据
				addresslist = await Db.select(req, `SELECT * FROM  ${tableName} where uid = '${uid}' AND  status=0`);
				res.send(Success(addresslist));
			}else{
				res.send(Success(addresslist));
			}	
		}else{
			// 查询全部收货地址或者知道id编号的数据
			let  addresslist = await Db.select(req, sql);
			res.send(Success(addresslist));
		}  
    }
  
})

//根据数据id修改一条收货地址
router.post("/addressedit", async (req, res) => {
    let {id,username,userphone,useraddress,status=0,label='家',location,regioncode=""} = req['body'];

    if (!id || !username || !userphone || !useraddress || !location) {
	    res.send(MError("缺少必要字段"));return;
    } else {
        // 组装修改字段
        let updateData = {username,userphone:userphone.toString(),location,regioncode,useraddress,status,label}
        // console.log(updateData);
        const result = await Db.update(req, tableName, updateData, ` WHERE id = ${id}`);
		console.log(result);
        result === true ? res.send(Success()) : res.send(MError(result));
    }
});

// 根据数据id删除一条收货地址
router.post("/addressremove",async(req,res)=>{
    let {id} = req['body'];
    if (!id) {
        res.send(MError("缺少必要条件"));return;
    } else {
        const result = await Db.delete(req, `DELETE FROM ${tableName} WHERE id = '${id}'`);
        if (result === true) {
            res.send(Success([], "删除成功"))
        } else {
            res.send(MError());
        }
    }
})


module.exports = router;