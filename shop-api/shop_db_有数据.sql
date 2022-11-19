/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : shop_db

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2021-01-26 19:14:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) DEFAULT NULL COMMENT '会员uid',
  `username` varchar(10) DEFAULT '' COMMENT '收获人姓名',
  `userphone` char(11) DEFAULT '' COMMENT '收货人手机号',
  `regioncode` varchar(20) DEFAULT NULL COMMENT '行政区码，冗余字段，如：100,1001,10001',
  `location` varchar(20) DEFAULT NULL COMMENT '行政区字符串冗余字段：山东省，滨州市，无棣县',
  `useraddress` varchar(50) DEFAULT '' COMMENT '收货人详情地址，如：山东省滨州市无棣县县一中',
  `status` tinyint(1) DEFAULT '0' COMMENT '默认地址状态：1是默认 0不是',
  `label` char(5) DEFAULT '' COMMENT '地址标签：公司、家、学校',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '关羽', '13716052241', '', '安徽省合肥市瑶海区', '五方桥中公教育基地', '0', '学校');
INSERT INTO `address` VALUES ('21', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '刘备', '13716052241', '', '山东省滨州市无棣县', '棣新一路圣豪购物广场', '0', '家');
INSERT INTO `address` VALUES ('22', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '周瑜', '13716052241', '', '北京市市辖区朝阳区', '五方桥中公教育基地', '0', '公司');
INSERT INTO `address` VALUES ('23', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '曹操', '13716052241', '', '北京市市辖区朝阳区', '五方桥中公教育基地', '1', '公司');
INSERT INTO `address` VALUES ('33', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '鲁班', '13788995678', '', '黑龙江省哈尔滨市道里区', '王者峡谷', '1', '学校');
INSERT INTO `address` VALUES ('34', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '鲁班大师', '13716052241', '', '山东省滨州市无棣县', '棣新一路', '0', '公司');
INSERT INTO `address` VALUES ('35', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '亚瑟', '13767782879', '', '山东省滨州市无棣县', '棣新一路', '1', '学校');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '轮播图id',
  `first_cateid` int(11) DEFAULT NULL COMMENT '一级商品分类',
  `second_cateid` int(11) DEFAULT NULL COMMENT '商品二级分类',
  `title` varchar(50) NOT NULL COMMENT '轮播图标题',
  `img` varchar(255) NOT NULL COMMENT '轮播图图片地址',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  `description` text COMMENT '活动描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='轮播图表';

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('1', '3', '16', '活动3', '/uploads/banner/58276080-5ed6-11eb-a737-b595a5439ea8.jpg', '1', '<p>不错商品</p>');
INSERT INTO `banner` VALUES ('2', '2', '13', '活动4', '/uploads/banner/00752970-5ed7-11eb-a737-b595a5439ea8.jfif', '1', null);
INSERT INTO `banner` VALUES ('3', '3', '11', '轮播图3', '/uploads/banner/e2175bb0-5aee-11eb-9b31-1f1328e23470.png', '1', null);
INSERT INTO `banner` VALUES ('4', '3', '11', '活动1', '/uploads/banner/0b75ef30-5ed7-11eb-a737-b595a5439ea8.jpg', '1', '');
INSERT INTO `banner` VALUES ('5', '3', '11', '活动2', '/uploads/banner/2d7a6e30-5ed7-11eb-a737-b595a5439ea8.jfif', '1', '<p><img src=\"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1766662947,2678086745&amp;fm=26&amp;gp=0.jpg\" style=\"max-width:100%;\"><br></p>');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '购物车主键',
  `uid` varchar(50) NOT NULL COMMENT '用户id',
  `goodsid` int(11) NOT NULL COMMENT '商品编号',
  `num` tinyint(3) NOT NULL COMMENT '数量',
  `status` tinyint(1) NOT NULL COMMENT '选中状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uid` (`uid`,`goodsid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='购物车表';

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `pid` smallint(5) unsigned NOT NULL COMMENT '上级分类编号',
  `catename` varchar(50) NOT NULL COMMENT '分类名称',
  `img` varchar(255) NOT NULL COMMENT '分类图片',
  `status` tinyint(1) unsigned NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品分类表';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '0', '家用电器', '', '1');
INSERT INTO `category` VALUES ('2', '0', '手机通讯', '', '1');
INSERT INTO `category` VALUES ('3', '0', '电脑办公', '', '1');
INSERT INTO `category` VALUES ('4', '0', '家居', '', '1');
INSERT INTO `category` VALUES ('5', '0', '服装', '', '1');
INSERT INTO `category` VALUES ('7', '1', '电视', '/uploads/category/fc3abc50-6c2c-11ea-b86c-579aced212c2.jpg', '1');
INSERT INTO `category` VALUES ('8', '1', '空调', '/uploads/category/354b31f0-6c2d-11ea-b86c-579aced212c2.jpg', '1');
INSERT INTO `category` VALUES ('9', '1', '洗衣机', '/uploads/category/436e9470-6c2d-11ea-b86c-579aced212c2.jpg', '1');
INSERT INTO `category` VALUES ('10', '2', '诺基亚手机', '/uploads/category/fee7e580-6c2d-11ea-b86c-579aced212c2.png', '1');
INSERT INTO `category` VALUES ('11', '3', '笔记本', '/uploads/category/ddb0b9f0-6de0-11ea-a8e1-0d680bf54839.jpg', '1');
INSERT INTO `category` VALUES ('12', '2', '手机配件', '/uploads/category/764b6740-9673-11ea-b348-a734901db180.jpg', '1');
INSERT INTO `category` VALUES ('13', '2', '小米手机', '/uploads/category/91238110-9673-11ea-b348-a734901db180.jpg', '1');
INSERT INTO `category` VALUES ('14', '2', 'oppo手机', '/uploads/category/5f200c50-9674-11ea-b348-a734901db180.jpg', '1');
INSERT INTO `category` VALUES ('15', '3', 'mac本', '/uploads/category/86b1e680-9674-11ea-b348-a734901db180.jpg', '1');
INSERT INTO `category` VALUES ('16', '3', '华为笔记本', '/uploads/category/a740dc80-9674-11ea-b348-a734901db180.jpg', '1');
INSERT INTO `category` VALUES ('17', '3', '戴尔笔记本', '/uploads/category/b63aeff0-9674-11ea-b348-a734901db180.jpg', '1');
INSERT INTO `category` VALUES ('18', '0', '男鞋', '', '1');
INSERT INTO `category` VALUES ('19', '0', '女鞋', '', '1');
INSERT INTO `category` VALUES ('20', '0', '化妆品', '', '1');
INSERT INTO `category` VALUES ('21', '0', '运动户外', '', '1');

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `code` int(4) DEFAULT NULL COMMENT '验证码',
  `addtime` varchar(20) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code
-- ----------------------------
INSERT INTO `code` VALUES ('1', '13716052241', '1234', '1602333418000');
INSERT INTO `code` VALUES ('2', '13716052241', '1111', '1602333418030');
INSERT INTO `code` VALUES ('3', '13716052242', '7313', '1602336569581');
INSERT INTO `code` VALUES ('4', '13716052245', '5768', '1602336608496');
INSERT INTO `code` VALUES ('5', '13716052241', '1289', '1603412923487');
INSERT INTO `code` VALUES ('6', '13716052241', '5275', '1610544545930');
INSERT INTO `code` VALUES ('7', '13716052241', '1489', '1610590852378');
INSERT INTO `code` VALUES ('8', '13716052241', '6830', '1611131913771');
INSERT INTO `code` VALUES ('9', '13716052241', '8562', '1611192562187');
INSERT INTO `code` VALUES ('10', '13716052241', '6515', '1611231827525');
INSERT INTO `code` VALUES ('11', '13716052241', '8407', '1611573777821');
INSERT INTO `code` VALUES ('12', '13716052241', '1055', '1611625595895');
INSERT INTO `code` VALUES ('13', '13716052241', '6875', '1611648422899');

-- ----------------------------
-- Table structure for courier
-- ----------------------------
DROP TABLE IF EXISTS `courier`;
CREATE TABLE `courier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyname` varchar(10) DEFAULT '' COMMENT '快递公司代码',
  `companycode` varchar(10) DEFAULT '' COMMENT '快递公司名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courier
-- ----------------------------
INSERT INTO `courier` VALUES ('1', '顺丰速运', 'SFSY');
INSERT INTO `courier` VALUES ('2', '韵达快递', 'YDKD');
INSERT INTO `courier` VALUES ('3', '圆通速递', 'YTSD');
INSERT INTO `courier` VALUES ('4', '菜鸟裹裹', 'GUOGUO');
INSERT INTO `courier` VALUES ('5', '德邦快递', 'DBKD');

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) DEFAULT '' COMMENT '用户uid',
  `orderid` int(11) DEFAULT NULL COMMENT '主订单id',
  `desc` text COMMENT '商品评价描述',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluate
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `first_cateid` smallint(5) unsigned NOT NULL COMMENT '一级分类编号',
  `second_cateid` smallint(6) NOT NULL COMMENT '二级分类编号',
  `goodsname` varchar(100) NOT NULL COMMENT '商品名称',
  `price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `market_price` decimal(10,2) NOT NULL COMMENT '市场价格',
  `img` varchar(255) NOT NULL COMMENT '商品图片',
  `description` text COMMENT '商品描述',
  `specsid` int(11) NOT NULL COMMENT '规格id',
  `specsattr` varchar(255) NOT NULL COMMENT '规则属性值',
  `isnew` tinyint(1) NOT NULL COMMENT '是否新品1是2不是',
  `ishot` tinyint(1) NOT NULL COMMENT '是否热卖1是2不是',
  `status` tinyint(1) NOT NULL COMMENT '状态1启用2禁用',
  `number` tinyint(5) NOT NULL DEFAULT '100' COMMENT '商品库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品表';

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '2', '10', '小米10', '3999.00', '3999.00', '/uploads/d6a0eff0-70be-11ea-91a2-9395060d7390.jpg', '<p>11</p><p>22</p><p>33</p>', '3', '白色,黑色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('2', '3', '11', '联想小新', '4499.00', '4699.00', '/uploads/2747d670-6de1-11ea-a8e1-0d680bf54839.jpg', '<p><img src=\"https://img30.360buyimg.com/sku/jfs/t1/92075/21/15594/69153/5e7332afE99041ba5/6796969792546bcf.jpg\" style=\"max-width:100%;\"><br></p>', '3', '白色', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('3', '2', '10', '荣耀9X', '1299.00', '1399.00', '/uploads/d6a0eff0-70be-11ea-91a2-9395060d7390.jpg', '', '3', '白色', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('4', '2', '10', '华为matep30', '3999.00', '4999.00', '/uploads/fb704ec0-70be-11ea-91a2-9395060d7390.jpg', '', '3', '黑色', '2', '2', '1', '100');
INSERT INTO `goods` VALUES ('5', '3', '11', '华为MateBook13', '4299.00', '4597.00', '/uploads/2a3e16d0-5ef6-11eb-8407-bb52993c067f.jpg', '', '3', '白色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('6', '3', '11', '华为MateBook14', '5299.00', '4597.00', '/uploads/08188b00-5ee5-11eb-9611-cfb4d6b321e9.jpg', '', '3', '白色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('7', '3', '11', '华为MateBook15', '6299.00', '4597.00', '/uploads/10bdd490-5ee5-11eb-9611-cfb4d6b321e9.jpg', '', '3', '白色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('8', '3', '11', '华为MateBook16', '7299.00', '4597.00', '/uploads/1faae7a0-70bf-11ea-91a2-9395060d7390.jpg', '', '3', '白色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('9', '3', '11', '华为MateBook17', '8299.00', '4597.00', '/uploads/1faae7a0-70bf-11ea-91a2-9395060d7390.jpg', '', '3', '白色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('10', '3', '11', '华为MateBook18', '9299.00', '4597.00', '/uploads/1faae7a0-70bf-11ea-91a2-9395060d7390.jpg', '', '3', '白色', '2', '1', '1', '100');
INSERT INTO `goods` VALUES ('11', '3', '11', '华为笔记本Book19', '5000.00', '6000.00', '/uploads/2a61cc70-d8a4-11ea-b018-b35815b27deb.jpg', '<p>不错的商品</p>', '5', '55英寸', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('12', '3', '11', '小米笔记本1', '2003.00', '2222.00', '/uploads/43eaf810-d8a4-11ea-b018-b35815b27deb.jpg', '<p>不错的手机</p>', '5', '55英寸', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('13', '3', '11', '小米笔记本2', '2003.00', '2222.00', '/uploads/43eaf810-d8a4-11ea-b018-b35815b27deb.jpg', '<p>不错的商品</p>', '3', '白色,黑色', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('14', '3', '11', '小米笔记本3', '2003.00', '2222.00', '/uploads/43eaf810-d8a4-11ea-b018-b35815b27deb.jpg', '<p>不错的商品</p>', '3', '白色,黑色', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('15', '3', '11', '小米笔记本4', '2003.00', '2222.00', '/uploads/43eaf810-d8a4-11ea-b018-b35815b27deb.jpg', '<p>不错的商品</p>', '3', '白色,黑色', '1', '2', '1', '100');
INSERT INTO `goods` VALUES ('16', '3', '11', '小米笔记本5', '2003.00', '2222.00', '/uploads/43eaf810-d8a4-11ea-b018-b35815b27deb.jpg', '<p>不错的商品</p>', '3', '白色,黑色', '1', '2', '1', '100');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL COMMENT '用户编号',
  `phone` char(11) NOT NULL COMMENT '手机号',
  `password` char(32) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatarurl` varchar(50) DEFAULT '/uploads/tou.jpg' COMMENT '会员头像',
  `sex` tinyint(2) DEFAULT '1' COMMENT '会员性别 1代表男  2 代表女',
  `birthday` varchar(10) DEFAULT NULL COMMENT '出生日期',
  `region` varchar(20) DEFAULT NULL COMMENT '会员住址',
  `profession` varchar(10) DEFAULT NULL COMMENT '会员职业',
  `randstr` char(5) DEFAULT NULL COMMENT '密码随机串',
  `addtime` char(13) DEFAULT NULL COMMENT '注册时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员表';

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('6', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '13716052241', '', '奋斗小青年', '/uploads/53038630-5f7e-11eb-a812-236e05ed9bf3.jpg', '1', '1992-02-14', '山东省滨州市滨城区', 'it讲师', null, '1599556783839', '1');
INSERT INTO `member` VALUES ('14', 'f321af60-5efd-11eb-859b-3f382ce9a454', '13716052247', null, '137****2247', '/uploads/tou.jpg', '1', null, null, null, null, '1611573036378', '1');
INSERT INTO `member` VALUES ('15', '88b805f0-5f86-11eb-bdf2-1767f72b094f', '15611809087', '53dcf37cefe866f63a41d1ada67bee1f', '艺术小青年', '/uploads/tou.jpg', '1', null, null, null, 'RbUpL', '1611631698895', '1');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `pid` smallint(6) NOT NULL COMMENT '上级菜单编号',
  `title` varchar(50) NOT NULL COMMENT '菜单名称',
  `icon` varchar(100) NOT NULL COMMENT '菜单图标',
  `type` tinyint(1) NOT NULL COMMENT '菜单类型1目录2菜单',
  `url` varchar(100) NOT NULL COMMENT '菜单地址',
  `status` tinyint(1) NOT NULL COMMENT '菜单状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台菜单权限表';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '系统设置', 'el-icon-setting', '1', '', '1');
INSERT INTO `menu` VALUES ('2', '1', '菜单管理', '', '2', '/menu', '1');
INSERT INTO `menu` VALUES ('3', '1', '角色管理', '', '2', '/role', '1');
INSERT INTO `menu` VALUES ('7', '1', '管理员管理', '', '2', '/user', '1');
INSERT INTO `menu` VALUES ('8', '0', '商城管理', 'el-icon-s-goods', '1', '', '1');
INSERT INTO `menu` VALUES ('9', '8', '商品分类', '', '2', '/category', '1');
INSERT INTO `menu` VALUES ('10', '8', '商品规格', '', '2', '/specs', '1');
INSERT INTO `menu` VALUES ('11', '8', '商品管理', '', '2', '/goods', '1');
INSERT INTO `menu` VALUES ('12', '8', '会员管理', '', '2', '/member', '1');
INSERT INTO `menu` VALUES ('14', '8', '活动管理', '', '2', '/banner', '1');
INSERT INTO `menu` VALUES ('15', '8', '秒杀活动', '', '2', '/seckill', '1');
INSERT INTO `menu` VALUES ('19', '8', '订单管理', '', '2', '/orders', '1');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) DEFAULT NULL COMMENT '会员id',
  `orderid` int(11) DEFAULT NULL COMMENT '主订单id',
  `subordernumber` varchar(50) DEFAULT '' COMMENT '子订单编号',
  `goodsid` int(11) DEFAULT NULL COMMENT '商品id',
  `goodsname` varchar(20) DEFAULT '' COMMENT '商品的名称',
  `price` decimal(10,2) DEFAULT NULL COMMENT '商品的单价',
  `img` varchar(50) DEFAULT '' COMMENT '商品的图片路径',
  `num` tinyint(3) DEFAULT NULL COMMENT '购买的商品数量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('242', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '155', 'sub_0_1611630449709372294', '1', '小米10', '3999.00', '/uploads/d6a0eff0-70be-11ea-91a2-9395060d7390.jpg', '1');
INSERT INTO `orders` VALUES ('243', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '155', 'sub_1_1611630449709372294', '5', '华为MateBook13', '4299.00', '/uploads/2a3e16d0-5ef6-11eb-8407-bb52993c067f.jpg', '1');
INSERT INTO `orders` VALUES ('244', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '156', 'sub_0_1611630499451690726', '6', '华为MateBook14', '5299.00', '/uploads/08188b00-5ee5-11eb-9611-cfb4d6b321e9.jpg', '1');
INSERT INTO `orders` VALUES ('245', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '157', 'sub_0_1611632778133558188', '1', '小米10', '3999.00', '/uploads/d6a0eff0-70be-11ea-91a2-9395060d7390.jpg', '1');
INSERT INTO `orders` VALUES ('246', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '158', 'sub_0_1611642994191449126', '1', '小米10', '3999.00', '/uploads/d6a0eff0-70be-11ea-91a2-9395060d7390.jpg', '1');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `rolename` varchar(100) NOT NULL COMMENT '角色名称',
  `menus` varchar(255) NOT NULL COMMENT '菜单权限 存放的是菜单编号，用逗号隔开',
  `status` tinyint(1) NOT NULL COMMENT '角色状态1正常2禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3', '系统管理员', '1,2,3,7,8,9,10,11,12,14,15,19', '1');
INSERT INTO `role` VALUES ('4', '客服专员', '8,9,10,11,12,13', '1');

-- ----------------------------
-- Table structure for seckill
-- ----------------------------
DROP TABLE IF EXISTS `seckill`;
CREATE TABLE `seckill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '秒杀表id',
  `title` varchar(100) NOT NULL COMMENT '活动名称',
  `begintime` char(13) NOT NULL COMMENT '秒杀开始时间',
  `endtime` char(13) NOT NULL COMMENT '秒杀结束时间',
  `first_cateid` smallint(5) NOT NULL COMMENT '商品一级分类编号',
  `second_cateid` smallint(5) NOT NULL COMMENT '商品二级分类编号',
  `goodsid` int(11) NOT NULL COMMENT '商品编号',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='限时秒杀活动表';

-- ----------------------------
-- Records of seckill
-- ----------------------------
INSERT INTO `seckill` VALUES ('6', '活动2', '1611158400000', '1611936000000', '2', '10', '1', '1');
INSERT INTO `seckill` VALUES ('7', '限时秒杀', '1610467200000', '1611158400000', '2', '10', '1', '1');
INSERT INTO `seckill` VALUES ('8', '今日特价', '1610467200000', '1611158400000', '3', '11', '1', '1');

-- ----------------------------
-- Table structure for shop_order
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) DEFAULT NULL COMMENT '会员id',
  `addressid` int(11) DEFAULT NULL COMMENT '收货地址id',
  `ordernumber` varchar(80) DEFAULT '' COMMENT '订单编号',
  `tradeno` varchar(50) DEFAULT '' COMMENT '微信、支付宝交易号',
  `paytype` tinyint(2) DEFAULT NULL COMMENT '支付方式 1支付宝 2微信',
  `countmoney` decimal(10,2) DEFAULT NULL COMMENT '订单支付金额',
  `countnumber` smallint(5) DEFAULT NULL COMMENT '商品数量',
  `couriercode` varchar(10) DEFAULT '' COMMENT '快递公司码',
  `couriernumber` varchar(50) DEFAULT '' COMMENT '快递单号',
  `addtime` timestamp NULL DEFAULT NULL COMMENT '订单添加时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单的状态：0是待支付 1是待发货  2待确认 3待评价 4订单完成 5订单取消',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_order
-- ----------------------------
INSERT INTO `shop_order` VALUES ('155', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '23', '1611630449709372294', '2021012622001420320501138046', '1', '8298.00', '2', '', '', '2021-01-26 11:07:29', '1');
INSERT INTO `shop_order` VALUES ('156', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '1', '1611630499451690726', '', null, '5299.00', '1', '', '', '2021-01-26 11:08:19', '0');
INSERT INTO `shop_order` VALUES ('157', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '23', '1611632778133558188', '', null, '3999.00', '1', '', '', '2021-01-26 11:46:18', '0');
INSERT INTO `shop_order` VALUES ('158', '6e7dd8d0-f1b4-11ea-84da-07a5d6e2f2fe', '23', '1611642994191449126', '', null, '3999.00', '1', '', '', '2021-01-26 14:36:34', '0');

-- ----------------------------
-- Table structure for specs
-- ----------------------------
DROP TABLE IF EXISTS `specs`;
CREATE TABLE `specs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格id',
  `specsname` varchar(50) NOT NULL COMMENT '规格名称',
  `status` tinyint(1) NOT NULL COMMENT '规格状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品规格表';

-- ----------------------------
-- Records of specs
-- ----------------------------
INSERT INTO `specs` VALUES ('3', '颜色', '1');
INSERT INTO `specs` VALUES ('5', '尺寸', '1');

-- ----------------------------
-- Table structure for specs_attr
-- ----------------------------
DROP TABLE IF EXISTS `specs_attr`;
CREATE TABLE `specs_attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格项编号',
  `specsid` int(11) NOT NULL COMMENT '规格的specsid',
  `specsval` varchar(50) NOT NULL COMMENT '规格值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品规格明细表';

-- ----------------------------
-- Records of specs_attr
-- ----------------------------
INSERT INTO `specs_attr` VALUES ('7', '5', '55英寸');
INSERT INTO `specs_attr` VALUES ('8', '5', '60英寸');
INSERT INTO `specs_attr` VALUES ('13', '3', '白色');
INSERT INTO `specs_attr` VALUES ('14', '3', '黑色');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '住建',
  `uid` varchar(50) NOT NULL COMMENT '管理员编号',
  `roleid` smallint(5) NOT NULL COMMENT '角色编号',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `randstr` char(5) NOT NULL COMMENT '随机加密串',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台管理员用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '7f412140-6b72-11ea-a476-bbdc6fb709e3', '3', 'admin', '904793bd8f8b17435798173c6af24eff', 'LFLK8', '1');
INSERT INTO `user` VALUES ('2', 'ef0d6e20-6b72-11ea-86b6-ff96b988db92', '4', 'kefu', '51a956280a6ecc833943d0db633c3bc8', 'N9vs3', '1');
