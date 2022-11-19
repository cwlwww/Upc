import {sendGet,sendPost} from './request.js'

//调用用户登录接口：
export let userLogin = d=>sendPost('/api/userlogin',d);
//菜单管理调用接口开始：
//查询所有菜单
export let getAllMenu = ()=>sendGet('/api/menulist',{istree:true});
//添加菜单：
export let addMenu = d=>sendPost('/api/menuadd',d);
//根据菜单id查询菜单数据：
export let getOneMenus = d=>sendGet('/api/menuinfo',d);
//根据菜单id修改菜单数据：
export let modifyMenu = d=>sendPost('/api/menuedit',d);
//根据菜单id删除菜单数据：
export let deleteMenu = d=>sendPost('/api/menudelete',d);

//菜单管理调用接口结束


//角色管理调用接口开始：
export let addRole = d=>sendPost('/api/roleadd',d)
//查询所有角色
export let getRole = ()=>sendGet('/api/rolelist')
// 角色修改
export let getUsercount = d=>sendGet('/api/usercount',d)
//查询对应id角色
export let getRoleinfo = d=>sendGet('/api/roleinfo',d)
//删除角色
export let getRoledelete = d=>sendPost('/api/roledelete',d)
// 角色修改
export let getRoleedit = d=>sendPost('/api/roleedit',d)
//角色管理调用接口结束：

// 管理员管理调用接口开始
// 管理员列表查询
export let getUserlist = d=>sendGet('/api/userlist',d)
// 管理员列表添加
export let getUseradd = d=>sendPost('/api/useradd',d)
// 管理员列表删除
export let getUserdelete = d=>sendPost('/api/userdelete',d)
//查询对应id角色
export let getUserinfo = d=>sendGet('/api/userinfo',d)
// 管理员列表删除
export let getUseredit = d=>sendPost('/api/useredit',d)
// 管理员管理调用接口结束

//商品分类调用接口开始：
//添加商品分类：
export let addGoodsCate = d=>sendPost('/api/cateadd',d,true)
//商品分类列表：
export let goodsCateList = ()=>sendGet('/api/catelist',{istree:true})
//获得单个分类列表：
export let getOnecateinfo = d=>sendGet('/api/cateinfo',d)
//获得修改列表：
export let cateEdit = d=>sendPost('/api/cateedit',d,true)
//获得单个分类列表：
export let getCatedelete = d=>sendPost('/api/catedelete',d)

//商品分类调用接口结束：

//商品规格调用接口开始：
//添加商品规格：
export let addGoodsSpec = (d)=>sendPost('/api/specsadd',d);
// 商品规格查看
export let getGoodsSpec = d=>sendGet('/api/specslist',d)
// 商品分类删除
export let getSpecdelete = d=>sendPost('/api/specsdelete',d)
// 获得选中规格
export let getOnespecsone = d=>sendGet('/api/specsinfo',d)
// 商品分类删除
export let specsEdit = d=>sendPost('/api/specsedit',d)

//商品规格调用接口结束

//商品管理调用接口开始：
//添加商品：
export let addGoodsinfo = (d)=>sendPost('/api/goodsadd',d,true);
// 获得商品列表
export let getGoods = d=>sendGet('/api/goodslist',d)
// 删除商品
export let delGoods = d=>sendPost('/api/goodsdelete',d)
// 获得选中商品
export let getOneGoodsOne = d=>sendGet('/api/specsinfo',d)
// 修改商品信息
export let GoodsEdit = d=>sendPost('/api/specsedit',d)

//商品规格调用接口结束