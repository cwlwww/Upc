/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : shop_db

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 30/03/2020 18:22:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '轮播图id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '轮播图标题',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '轮播图图片地址',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '轮播图表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (1, '轮播图1', '/uploads/banner/8f581960-7033-11ea-90dd-3b8abd26afb2.jpg', 1);
INSERT INTO `banner` VALUES (2, '轮播图2', '/uploads/banner/972ca570-7033-11ea-90dd-3b8abd26afb2.jpg', 1);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车主键',
  `uid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `goodsid` int(11) NOT NULL COMMENT '商品编号',
  `num` tinyint(3) NOT NULL COMMENT '数量',
  `status` tinyint(1) NOT NULL COMMENT '选中状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uid`(`uid`, `goodsid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, '2be08210-70fa-11ea-9c17-a5b3f9b0d2ba', 1, 3, 1);
INSERT INTO `cart` VALUES (3, '2be08210-70fa-11ea-9c17-a5b3f9b0d2ba', 3, 1, 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `pid` smallint(5) UNSIGNED NOT NULL COMMENT '上级分类编号',
  `catename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类图片',
  `status` tinyint(1) UNSIGNED NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 0, '家用电器', '', 1);
INSERT INTO `category` VALUES (2, 0, '手机通讯', '', 1);
INSERT INTO `category` VALUES (3, 0, '电脑办公', '', 1);
INSERT INTO `category` VALUES (4, 0, '家居', '', 1);
INSERT INTO `category` VALUES (5, 0, '服装', '', 1);
INSERT INTO `category` VALUES (7, 1, '电视', '/uploads/category/fc3abc50-6c2c-11ea-b86c-579aced212c2.jpg', 1);
INSERT INTO `category` VALUES (8, 1, '空调', '/uploads/category/354b31f0-6c2d-11ea-b86c-579aced212c2.jpg', 1);
INSERT INTO `category` VALUES (9, 1, '洗衣机', '/uploads/category/436e9470-6c2d-11ea-b86c-579aced212c2.jpg', 1);
INSERT INTO `category` VALUES (10, 2, '手机', '/uploads/category/fee7e580-6c2d-11ea-b86c-579aced212c2.png', 1);
INSERT INTO `category` VALUES (11, 3, '笔记本', '/uploads/category/ddb0b9f0-6de0-11ea-a8e1-0d680bf54839.jpg', 1);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `first_cateid` smallint(5) UNSIGNED NOT NULL COMMENT '一级分类编号',
  `second_cateid` smallint(6) NOT NULL COMMENT '二级分类编号',
  `goodsname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `market_price` decimal(10, 2) NOT NULL COMMENT '市场价格',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品图片',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品描述',
  `specsid` int(11) NOT NULL COMMENT '规格id',
  `specsattr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则属性值',
  `isnew` tinyint(1) NOT NULL COMMENT '是否新品1是2不是',
  `ishot` tinyint(1) NOT NULL COMMENT '是否热卖1是2不是',
  `status` tinyint(1) NOT NULL COMMENT '状态1启用2禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 2, 10, '小米10', 3999.00, 3999.00, '/uploads/fa5c2790-6c48-11ea-b894-9bd516f4e52e.jpg', '<p>11</p><p>22</p><p>33</p>', 3, '白色,黑色', 0, 1, 1);
INSERT INTO `goods` VALUES (2, 3, 11, '联想小新', 4499.00, 4699.00, '/uploads/2747d670-6de1-11ea-a8e1-0d680bf54839.jpg', '<p><img src=\"https://img30.360buyimg.com/sku/jfs/t1/92075/21/15594/69153/5e7332afE99041ba5/6796969792546bcf.jpg\" style=\"max-width:100%;\"><br></p>', 3, '白色', 1, 0, 1);
INSERT INTO `goods` VALUES (3, 2, 10, '荣耀9X', 1299.00, 1399.00, '/uploads/d6a0eff0-70be-11ea-91a2-9395060d7390.jpg', '', 3, '白色', 1, 2, 1);
INSERT INTO `goods` VALUES (4, 2, 10, '华为matep30', 3999.00, 4999.00, '/uploads/fb704ec0-70be-11ea-91a2-9395060d7390.jpg', '', 3, '黑色', 2, 2, 1);
INSERT INTO `goods` VALUES (5, 3, 11, '华为MateBook', 4299.00, 4597.00, '/uploads/1faae7a0-70bf-11ea-91a2-9395060d7390.jpg', '', 3, '白色', 2, 1, 1);

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户编号',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `randstr` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码随机串',
  `addtime` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '注册时间',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (2, '2be08210-70fa-11ea-9c17-a5b3f9b0d2ba', '18811112222', '小U', '', 'O6ImO', '1585403036849', 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `pid` smallint(6) NOT NULL COMMENT '上级菜单编号',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单图标',
  `type` tinyint(1) NOT NULL COMMENT '菜单类型1目录2菜单',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单地址',
  `status` tinyint(1) NOT NULL COMMENT '菜单状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 0, '系统设置', 'el-icon-setting', 1, '', 1);
INSERT INTO `menu` VALUES (2, 1, '菜单管理', '', 2, '/menu', 1);
INSERT INTO `menu` VALUES (3, 1, '角色管理', '', 2, '/role', 1);
INSERT INTO `menu` VALUES (7, 1, '管理员管理', '', 2, '/user', 1);
INSERT INTO `menu` VALUES (8, 0, '商城管理', 'el-icon-s-goods', 1, '', 1);
INSERT INTO `menu` VALUES (9, 8, '商品分类', '', 2, '/category', 1);
INSERT INTO `menu` VALUES (10, 8, '商品规格', '', 2, '/specs', 1);
INSERT INTO `menu` VALUES (11, 8, '商品管理', '', 2, '/goods', 1);
INSERT INTO `menu` VALUES (12, 8, '会员管理', '', 2, '/member', 1);
INSERT INTO `menu` VALUES (14, 8, '轮播图管理', '', 2, '/banner', 1);
INSERT INTO `menu` VALUES (15, 8, '秒杀活动', '', 2, '/seckill', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `rolename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `menus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单权限 存放的是菜单编号，用逗号隔开',
  `status` tinyint(1) NOT NULL COMMENT '角色状态1正常2禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (3, '系统管理员', '1,2,3,7,8,9,10,11,12,13,14,15', 1);
INSERT INTO `role` VALUES (4, '客服专员', '8,9,10,11,12,13', 1);

-- ----------------------------
-- Table structure for seckill
-- ----------------------------
DROP TABLE IF EXISTS `seckill`;
CREATE TABLE `seckill`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '秒杀表id',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动名称',
  `begintime` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀开始时间',
  `endtime` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀结束时间',
  `first_cateid` smallint(5) NOT NULL COMMENT '商品一级分类编号',
  `second_cateid` smallint(5) NOT NULL COMMENT '商品二级分类编号',
  `goodsid` int(11) NOT NULL COMMENT '商品编号',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '限时秒杀活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seckill
-- ----------------------------
INSERT INTO `seckill` VALUES (6, '活动2', '1585497600000', '1585583999000', 2, 10, 4, 1);

-- ----------------------------
-- Table structure for specs
-- ----------------------------
DROP TABLE IF EXISTS `specs`;
CREATE TABLE `specs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '规格id',
  `specsname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格名称',
  `status` tinyint(1) NOT NULL COMMENT '规格状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品规格表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of specs
-- ----------------------------
INSERT INTO `specs` VALUES (3, '颜色', 1);
INSERT INTO `specs` VALUES (5, '尺寸', 1);

-- ----------------------------
-- Table structure for specs_attr
-- ----------------------------
DROP TABLE IF EXISTS `specs_attr`;
CREATE TABLE `specs_attr`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '规格项编号',
  `specsid` int(11) NOT NULL COMMENT '规格的specsid',
  `specsval` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品规格明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of specs_attr
-- ----------------------------
INSERT INTO `specs_attr` VALUES (7, 5, '55英寸');
INSERT INTO `specs_attr` VALUES (8, 5, '60英寸');
INSERT INTO `specs_attr` VALUES (13, 3, '白色');
INSERT INTO `specs_attr` VALUES (14, 3, '黑色');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '住建',
  `uid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员编号',
  `roleid` smallint(5) NOT NULL COMMENT '角色编号',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `randstr` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '随机加密串',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台管理员用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '7f412140-6b72-11ea-a476-bbdc6fb709e3', 3, 'admin', '904793bd8f8b17435798173c6af24eff', 'LFLK8', 1);
INSERT INTO `user` VALUES (2, 'ef0d6e20-6b72-11ea-86b6-ff96b988db92', 4, 'kefu', '51a956280a6ecc833943d0db633c3bc8', 'N9vs3', 1);

SET FOREIGN_KEY_CHECKS = 1;
