var express = require('express');
const formidable = require('formidable'); //处理含有文件上传的表单
const path = require('path');
const fs = require('fs');
var multipart = require('connect-multiparty');

var router = express.Router();
const tableName = 'member'
const { Success, MError } = require("../utils/Result");
const Db = require("../utils/Db");
const {getUUID} = require("../utils");
const { stat } = require('fs');


// 获取一条会员信息
router.get('/getuserinfo',async(req,res)=>{
    // 获取用户的uid
    let {uid} = req['query'];
    if (!uid) {
        res.send(MError("缺少必要条件"));return;
    }else{
        // 根据用户的uid获取用户的基本数据
        const info = await Db.select(req, `SELECT id,uid,phone,nickname,avatarurl,birthday,region,sex FROM ${tableName} WHERE uid = '${uid}'`);
        // console.log(info);
        res.send(Success(info, '获取成功'));
    }
})

// 移动用户头像图片的方法
const moveFile = async (req) => {
	const formObj = new formidable.IncomingForm(); // 新建form对象
	formObj.encoding = 'UTF-8'; // UTF8编码
	formObj.uploadDir = "./tempDir"; // 接收的文件缓存路径
	return new Promise((resolve, reject) => {
		formObj.parse(req, (err, fields, files) => {
            // console.log(files.avatarurl);return;
			if(!files.avatarurl){
				resolve({
					body: fields,
					fileName:''
				});
				return;
            }
            // 优化小程序端 默认没有修改图片直接返回原图路径即可不需要移动下图
            // if(files.avatarurl.name.indexOf('.') == -1){
            //     // console.log(fields);
            //     resolve({
			// 		body: fields,
			// 		fileName:fields.avatarurl
			// 	});
			// 	return;
            // }
			let fileObj = files.avatarurl;
			let oldPath = fileObj['path'];
			let fileName = getUUID() + path.extname(fileObj['name']);
            let newPath = "public/uploads/" + fileName;
            // console.log(newPath);return;
			fs.rename(oldPath, newPath, (err) => { // 7. 挪动
				if (err) {
					console.error(err);
					resolve(false);
				} else {
					resolve({
						body: fields,
						fileName: "/uploads/" + fileName
					});
				}
			});
		});
	})
}

//编辑会员信息
router.post('/infoedit',async(req,res)=>{
    let editParams = req['body'];//接受修改数据  如果是提交文件过来该参数值空值

    // 如果修改了头像就处理图片
    if(Object.keys(editParams).length === 0){
        console.log('走的是修改图片')
        // 处理图片路径
        const resultObj = await moveFile(req);
        if (resultObj === false) {
            res.send(MError([], "用户信息上传失败"));
            return;
        }
        editParams = resultObj['body'];//获取用户基本信息
        // 如果用户更改头像就重新赋值
        if(resultObj['fileName']){
            editParams.avatarurl = resultObj['fileName'];
        }
    }

    let id = editParams.id;//获取修改数据id
    if (!id) {
        res.send(MError("缺少必要条件"));
    }else{console.log('没有修改图片')
        delete editParams.id;//删除多余id
        // console.log(editParams);return;
        const result = await Db.update(req, tableName, editParams, ` WHERE id = ${id}`);
        result === true ? res.send(Success()) : res.send(MError(result));
        console.log(result)
        if (result) {
            res.send(Success([], "编辑成功"));
        } else {
            res.send(MError("编辑失败，请查看字段信息是否正确"));
        }
    }
}) 

module.exports = router;
