/** -------------数据库变更需要修改的地方----------- */
// 数据库连接参数
exports.dbConfig = {
    host: 'localhost', 
    user: 'root',
    password: '123456',//数据库密码
    port: 3306,
    database: 'm-ushop' ,// 数据库名字
	timezone:"SYSTEM"
}

// token过期时间 (分钟单位)
exports.tokenTimeout = 60;

// api路由权限对照列表(字段是用户表中用户身份标识字符串)
exports.apiAuthObj = [
    '/api/menulist','/api/menuadd','/api/menuinfo','/api/menuedit','/api/menudelete',
    '/api/rolelist','/api/roleadd','/api/roleinfo','/api/roleedit','/api/roledelete',
    '/api/usercount','/api/userlist','/api/useradd','/api/userinfo','/api/useredit','/api/userdelete',
    '/api/catelist','/api/cateadd','/api/cateinfo','/api/cateedit','/api/catedelete',
    '/api/specscount','/api/specslist','/api/specsadd','/api/specsinfo','/api/specsedit','/api/specsdelete',
    '/api/goodscount','/api/goodslist','/api/goodsadd','/api/goodsinfo','/api/goodsedit','/api/goodsdelete',
    '/api/bannerlist','/api/banneradd','/api/bannerinfo','/api/banneredit','/api/bannerdelete',
    '/api/secklist','/api/seckadd','/api/seckinfo','/api/seckedit','/api/seckdelete',
    '/api/membercount','/api/memberlist','/api/memberinfo','/api/memberedit',
    '/api/cartlist','/api/cartadd','/api/cartinfo','/api/cartedit','/api/cartdelete',
    '/checktoken','/api/orderadd','/api/orderlist','/api/vedioupload','/api/addressadd','/api/addresslist',
    '/api/addressedit','/api/addressremove','/api/getgoodlist','/api/getuserinfo','/api/infoedit','/api/avatarurl','/api/alipay',
    "api/returnUrl","/api/notifyUrl",'/api/orderall','/api/orderedit','/api/courier'
]