/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : kevin_new

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2015-09-30 19:43:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `kv_admin`
-- ----------------------------
DROP TABLE IF EXISTS `kv_admin`;
CREATE TABLE `kv_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'uid',
  `username` varchar(32) NOT NULL COMMENT '帐号',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `group_id` tinyint(3) NOT NULL DEFAULT '1' COMMENT '分组id',
  `maxmoney` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '管理员组，每天最大金额操作',
  `operatemoney` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '操作金额',
  `operatettime` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作时间',
  `logintime` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `errorcount` smallint(2) DEFAULT '0' COMMENT '登录错误次数',
  `errortime` int(11) DEFAULT '0' COMMENT '登录错误日期',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '状态,Y启用，N禁用',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of kv_admin
-- ----------------------------
INSERT INTO `kv_admin` VALUES ('1', 'admin', '131f1f358cf28e2ed19bf158dfdb15e7', '1', '1', '10000000.00', '120.00', '1442814056', '1443594347', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('5', 'kevin1', '6d2b6ecb82dda37e2660c1c72956845f', '2', '2', '0.00', '0.00', '1434782869', '1439025674', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('6', 'kevin2', '1bb0c90ea5967d9037d6472a5370af23', '3', '2', '0.00', '0.00', '1434782933', '1434782933', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('7', 'kevin3', 'd652b5831cba5961756c51fdec5aec11', '4', '2', '0.00', '0.00', '1434782955', '1434782955', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('8', 'kevin', 'cb38d9f022528ff7b486e4892e743a1c', '1', '3', '10000000.00', '0.00', '0', '1438144970', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('9', 'ceshi', '27fd85cc8a7da1e5ab6a992b9ea931ff', '1', '4', '0.00', '0.00', '0', '0', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('10', 'k1001', '4baac15872c6f2bf20d16bb2fd69b718', '2', '6', '0.00', '0.00', '0', '0', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('11', 'kevin4', '21fe46f6ff15b77c590f81e1e2b5b2d0', '5', '2', '0.00', '0.00', '1438853813', '1438853813', '0', '0', 'Y', 'N');
INSERT INTO `kv_admin` VALUES ('12', 'k1002', '2e1e7c859ddba7f8c5878bf0bfb1320b', '2', '8', '10000.00', '10000.00', '0', '0', '0', '0', 'Y', 'N');

-- ----------------------------
-- Table structure for `kv_admin_group`
-- ----------------------------
DROP TABLE IF EXISTS `kv_admin_group`;
CREATE TABLE `kv_admin_group` (
  `id` mediumint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '组名',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `menus_list` varchar(200) DEFAULT NULL COMMENT '查看列表权限，菜单id,用逗号分割',
  `menus_one` varchar(200) DEFAULT NULL COMMENT '查看单个权限，菜单id,用逗号分割',
  `menus_add` varchar(200) DEFAULT NULL COMMENT '添加权限，菜单id,用逗号分割',
  `menus_edit` varchar(200) DEFAULT NULL COMMENT '编辑权限，菜单id,用逗号分割',
  `menus_del` varchar(200) DEFAULT NULL COMMENT '删除权限，菜单id,用逗号分割',
  `menus_undo` char(1) DEFAULT 'N' COMMENT '冲正负,Y有，N无',
  `menus_exam` char(1) DEFAULT 'N' COMMENT '资金审核,Y有，N无',
  `menus_conf` char(1) DEFAULT 'N' COMMENT '资金确认,Y有，N无',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='管理权限组';

-- ----------------------------
-- Records of kv_admin_group
-- ----------------------------
INSERT INTO `kv_admin_group` VALUES ('1', '总权限组', '1', null, null, null, null, null, 'N', 'N', 'N', 'N');
INSERT INTO `kv_admin_group` VALUES ('2', '总代理', '1', '18,19,58,59,60,71,4,25,64,84,28,51,39,40,73,43,45,46,48,85,62,63,76,79,80,81,82,', '18,19,58,59,60,71,4,25,64,84,28,51,39,40,73,43,45,46,48,85,62,63,76,79,80,81,82,', '18,19,58,59,60,71,4,25,64,84,28,51,39,40,73,43,45,46,48,85,62,63,76,79,80,81,82,', '18,19,58,59,60,71,4,25,64,84,28,51,39,40,73,43,45,46,48,85,62,63,76,79,80,81,82,', '18,19,58,59,60,71,4,25,64,84,28,51,39,40,73,43,45,46,48,85,62,63,76,79,80,81,82,', 'Y', 'Y', 'Y', 'N');
INSERT INTO `kv_admin_group` VALUES ('3', '管理组', '1', '18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,', '18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,39,40,73,43,45,46,47,48,85,62,63,76,', '18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,', '18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,', '18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,', 'Y', 'Y', 'Y', 'N');
INSERT INTO `kv_admin_group` VALUES ('4', '测试组', '1', '45,', '45,', '45,', '45,', '45,', 'N', 'N', 'N', 'Y');
INSERT INTO `kv_admin_group` VALUES ('5', '市场组', '1', '4,25,', null, '4,25,', '4,25,', '4,25,', 'N', 'N', 'N', 'Y');
INSERT INTO `kv_admin_group` VALUES ('6', '管理员组', '2', '18,19,58,59,60,4,25,64,31,43,', '18,19,58,59,60,31,', '18,19,58,59,60,4,25,64,31,43,', '18,19,58,59,60,4,25,64,31,43,', '18,19,58,59,60,4,25,64,31,43,', 'N', 'N', 'N', 'N');
INSERT INTO `kv_admin_group` VALUES ('7', '财务', '2', '28,29,51,', '28,29,51,', '28,29,51,', '28,29,51,', '28,29,51,', 'Y', 'N', 'Y', 'N');
INSERT INTO `kv_admin_group` VALUES ('8', '测试组', '2', '18,4,', '18,4,', '18,4,', '18,4,', '18,4,', 'N', 'N', 'N', 'N');

-- ----------------------------
-- Table structure for `kv_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `kv_admin_log`;
CREATE TABLE `kv_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `content` text NOT NULL COMMENT '操作内容',
  `type` tinyint(2) NOT NULL COMMENT '操作类型',
  `username` varchar(30) DEFAULT NULL COMMENT '操作人',
  `uid` int(11) DEFAULT '0' COMMENT '操作人uid',
  `ip` varchar(40) NOT NULL COMMENT 'ip地址',
  `op_agent_id` mediumint(10) NOT NULL DEFAULT '0' COMMENT '被操作人代理id',
  `addtime` int(11) NOT NULL COMMENT '操作时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=385 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_admin_log
-- ----------------------------
INSERT INTO `kv_admin_log` VALUES ('205', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439342599', 'N');
INSERT INTO `kv_admin_log` VALUES ('206', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1439342815', 'N');
INSERT INTO `kv_admin_log` VALUES ('207', '1', '权限组3修改', '4', 'admin', '1', '127.0.0.1', '1', '1439342856', 'N');
INSERT INTO `kv_admin_log` VALUES ('208', '1', '权限组4删除', '2', 'admin', '1', '127.0.0.1', '1', '1439342867', 'N');
INSERT INTO `kv_admin_log` VALUES ('209', '1', '权限组5删除', '2', 'admin', '1', '127.0.0.1', '1', '1439342874', 'N');
INSERT INTO `kv_admin_log` VALUES ('210', '1', '权限组3修改', '4', 'admin', '1', '127.0.0.1', '1', '1439342890', 'N');
INSERT INTO `kv_admin_log` VALUES ('211', '1', '修改设置type=ip;agent_id=1', '4', 'admin', '1', '127.0.0.1', '1', '1439342946', 'N');
INSERT INTO `kv_admin_log` VALUES ('212', '1', '编辑游戏类型id=7', '3', 'admin', '1', '127.0.0.1', '1', '1439342989', 'N');
INSERT INTO `kv_admin_log` VALUES ('213', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439357651', 'N');
INSERT INTO `kv_admin_log` VALUES ('214', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439360827', 'N');
INSERT INTO `kv_admin_log` VALUES ('215', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439360966', 'N');
INSERT INTO `kv_admin_log` VALUES ('216', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439361060', 'N');
INSERT INTO `kv_admin_log` VALUES ('217', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439361123', 'N');
INSERT INTO `kv_admin_log` VALUES ('218', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439361653', 'N');
INSERT INTO `kv_admin_log` VALUES ('219', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439361766', 'N');
INSERT INTO `kv_admin_log` VALUES ('220', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439361854', 'N');
INSERT INTO `kv_admin_log` VALUES ('221', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439391679', 'N');
INSERT INTO `kv_admin_log` VALUES ('222', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439398032', 'N');
INSERT INTO `kv_admin_log` VALUES ('223', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439398630', 'N');
INSERT INTO `kv_admin_log` VALUES ('224', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439398892', 'N');
INSERT INTO `kv_admin_log` VALUES ('225', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439398978', 'N');
INSERT INTO `kv_admin_log` VALUES ('226', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439429658', 'N');
INSERT INTO `kv_admin_log` VALUES ('227', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439433587', 'N');
INSERT INTO `kv_admin_log` VALUES ('228', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439433952', 'N');
INSERT INTO `kv_admin_log` VALUES ('229', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439433964', 'N');
INSERT INTO `kv_admin_log` VALUES ('230', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439437743', 'N');
INSERT INTO `kv_admin_log` VALUES ('231', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439437994', 'N');
INSERT INTO `kv_admin_log` VALUES ('232', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439529676', 'N');
INSERT INTO `kv_admin_log` VALUES ('233', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439532159', 'N');
INSERT INTO `kv_admin_log` VALUES ('234', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439534019', 'N');
INSERT INTO `kv_admin_log` VALUES ('235', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439534043', 'N');
INSERT INTO `kv_admin_log` VALUES ('236', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439534061', 'N');
INSERT INTO `kv_admin_log` VALUES ('237', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439534074', 'N');
INSERT INTO `kv_admin_log` VALUES ('238', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439534096', 'N');
INSERT INTO `kv_admin_log` VALUES ('239', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439534120', 'N');
INSERT INTO `kv_admin_log` VALUES ('240', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439671524', 'N');
INSERT INTO `kv_admin_log` VALUES ('241', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439772131', 'N');
INSERT INTO `kv_admin_log` VALUES ('242', '1', '修改设置type=ip;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439773789', 'N');
INSERT INTO `kv_admin_log` VALUES ('243', '1', '修改设置type=ip;agent_id=1', '4', 'admin', '1', '127.0.0.1', '1', '1439781096', 'N');
INSERT INTO `kv_admin_log` VALUES ('244', '1', 'admin登录失败', '1', 'admin', '0', '127.0.0.1', '1', '1439786284', 'N');
INSERT INTO `kv_admin_log` VALUES ('245', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439786423', 'N');
INSERT INTO `kv_admin_log` VALUES ('246', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439869690', 'N');
INSERT INTO `kv_admin_log` VALUES ('247', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439871403', 'N');
INSERT INTO `kv_admin_log` VALUES ('248', '1', '编辑代理id=2', '4', 'admin', '1', '127.0.0.1', '1', '1439877837', 'N');
INSERT INTO `kv_admin_log` VALUES ('249', '1', '编辑代理id=2', '4', 'admin', '1', '127.0.0.1', '1', '1439877920', 'N');
INSERT INTO `kv_admin_log` VALUES ('250', '1', '编辑代理id=3', '4', 'admin', '1', '127.0.0.1', '1', '1439877933', 'N');
INSERT INTO `kv_admin_log` VALUES ('251', '1', '删除表agentid=3', '2', 'admin', '1', '127.0.0.1', '1', '1439878400', 'N');
INSERT INTO `kv_admin_log` VALUES ('252', '1', '检查到非法操作数据，表:agent_host;id=5', '6', 'admin', '1', '127.0.0.1', '1', '1439884652', 'N');
INSERT INTO `kv_admin_log` VALUES ('253', '1', '检查到非法操作数据，表:agent_host;id=5', '6', 'admin', '1', '127.0.0.1', '1', '1439884665', 'N');
INSERT INTO `kv_admin_log` VALUES ('254', '1', '检查到非法操作数据，表:agent_host;id=5', '6', 'admin', '1', '127.0.0.1', '1', '1439884742', 'N');
INSERT INTO `kv_admin_log` VALUES ('255', '1', '检查到非法操作数据，表:agent;id=3', '6', 'admin', '1', '127.0.0.1', '1', '1439885073', 'N');
INSERT INTO `kv_admin_log` VALUES ('256', '1', '检查到非法操作数据，表:agent;id=3', '6', 'admin', '1', '127.0.0.1', '1', '1439885076', 'N');
INSERT INTO `kv_admin_log` VALUES ('257', '1', '检查到非法操作数据，表:agent;id=3', '6', 'admin', '1', '127.0.0.1', '1', '1439885119', 'N');
INSERT INTO `kv_admin_log` VALUES ('258', '1', '检查到到数据不存在，表:admin;id=', '7', 'admin', '1', '127.0.0.1', '1', '1439885607', 'N');
INSERT INTO `kv_admin_log` VALUES ('259', '1', '检查到到数据不存在，表:admin;id=', '7', 'admin', '1', '127.0.0.1', '1', '1439885671', 'N');
INSERT INTO `kv_admin_log` VALUES ('260', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439948975', 'N');
INSERT INTO `kv_admin_log` VALUES ('261', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951240', 'N');
INSERT INTO `kv_admin_log` VALUES ('262', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951536', 'N');
INSERT INTO `kv_admin_log` VALUES ('263', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951549', 'N');
INSERT INTO `kv_admin_log` VALUES ('264', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951556', 'N');
INSERT INTO `kv_admin_log` VALUES ('265', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951571', 'N');
INSERT INTO `kv_admin_log` VALUES ('266', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951612', 'N');
INSERT INTO `kv_admin_log` VALUES ('267', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951629', 'N');
INSERT INTO `kv_admin_log` VALUES ('268', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951639', 'N');
INSERT INTO `kv_admin_log` VALUES ('269', '1', '修改设置type=ip;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951815', 'N');
INSERT INTO `kv_admin_log` VALUES ('270', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951857', 'N');
INSERT INTO `kv_admin_log` VALUES ('271', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951902', 'N');
INSERT INTO `kv_admin_log` VALUES ('272', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439951967', 'N');
INSERT INTO `kv_admin_log` VALUES ('273', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439952214', 'N');
INSERT INTO `kv_admin_log` VALUES ('274', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1439952247', 'N');
INSERT INTO `kv_admin_log` VALUES ('275', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1439962208', 'N');
INSERT INTO `kv_admin_log` VALUES ('276', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1440048764', 'N');
INSERT INTO `kv_admin_log` VALUES ('277', '1', '添加信息type(1)', '3', 'admin', '1', '127.0.0.1', '2', '1440056172', 'N');
INSERT INTO `kv_admin_log` VALUES ('278', '1', '添加信息type(1)', '3', 'admin', '1', '127.0.0.1', '2', '1440056209', 'N');
INSERT INTO `kv_admin_log` VALUES ('279', '1', '添加信息type(1)', '3', 'admin', '1', '127.0.0.1', '2', '1440056236', 'N');
INSERT INTO `kv_admin_log` VALUES ('280', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1440056262', 'N');
INSERT INTO `kv_admin_log` VALUES ('281', '1', '添加信息type(2)', '3', 'admin', '1', '127.0.0.1', '2', '1440057193', 'N');
INSERT INTO `kv_admin_log` VALUES ('282', '1', '添加信息type(2)', '3', 'admin', '1', '127.0.0.1', '2', '1440057203', 'N');
INSERT INTO `kv_admin_log` VALUES ('283', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1440136796', 'N');
INSERT INTO `kv_admin_log` VALUES ('284', '1', '修改设置type=web;agent_id=1', '4', 'admin', '1', '127.0.0.1', '1', '1440136875', 'N');
INSERT INTO `kv_admin_log` VALUES ('285', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1440136899', 'N');
INSERT INTO `kv_admin_log` VALUES ('286', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1440136904', 'N');
INSERT INTO `kv_admin_log` VALUES ('287', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1440136929', 'N');
INSERT INTO `kv_admin_log` VALUES ('288', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1440138628', 'N');
INSERT INTO `kv_admin_log` VALUES ('289', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1440391499', 'N');
INSERT INTO `kv_admin_log` VALUES ('290', '1', '非总管理组操作,强制锁定(agent)', '6', 'admin', '1', '127.0.0.1', '2', '1440399604', 'N');
INSERT INTO `kv_admin_log` VALUES ('291', '1', '非总管理组操作,强制锁定(agent)', '6', 'admin', '1', '127.0.0.1', '2', '1440399710', 'N');
INSERT INTO `kv_admin_log` VALUES ('292', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1440480481', 'N');
INSERT INTO `kv_admin_log` VALUES ('293', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441001702', 'N');
INSERT INTO `kv_admin_log` VALUES ('294', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441004643', 'N');
INSERT INTO `kv_admin_log` VALUES ('295', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441006176', 'N');
INSERT INTO `kv_admin_log` VALUES ('296', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441089892', 'N');
INSERT INTO `kv_admin_log` VALUES ('297', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441101238', 'N');
INSERT INTO `kv_admin_log` VALUES ('298', '1', '编辑转账银行id=2', '4', 'admin', '1', '127.0.0.1', '2', '1441103230', 'N');
INSERT INTO `kv_admin_log` VALUES ('299', '1', '编辑转账银行id=2', '4', 'admin', '1', '127.0.0.1', '2', '1441103239', 'N');
INSERT INTO `kv_admin_log` VALUES ('300', '1', '添加转账银行id=3', '3', 'admin', '1', '127.0.0.1', '2', '1441103279', 'N');
INSERT INTO `kv_admin_log` VALUES ('301', '1', '删除表money_bankid=3', '2', 'admin', '1', '127.0.0.1', '2', '1441103312', 'N');
INSERT INTO `kv_admin_log` VALUES ('302', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441106715', 'N');
INSERT INTO `kv_admin_log` VALUES ('303', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441173753', 'N');
INSERT INTO `kv_admin_log` VALUES ('304', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441264215', 'N');
INSERT INTO `kv_admin_log` VALUES ('305', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441267648', 'N');
INSERT INTO `kv_admin_log` VALUES ('306', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441267714', 'N');
INSERT INTO `kv_admin_log` VALUES ('307', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441281483', 'N');
INSERT INTO `kv_admin_log` VALUES ('308', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441341459', 'N');
INSERT INTO `kv_admin_log` VALUES ('309', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441341567', 'N');
INSERT INTO `kv_admin_log` VALUES ('310', '1', '检查到非法操作数据，表:message_notice;id=2', '6', 'admin', '1', '127.0.0.1', '1', '1441344231', 'N');
INSERT INTO `kv_admin_log` VALUES ('311', '1', '检查到非法操作数据，表:message_notice;id=2', '6', 'admin', '1', '127.0.0.1', '1', '1441344236', 'N');
INSERT INTO `kv_admin_log` VALUES ('312', '1', '检查到非法操作数据，表:message_notice;id=2', '6', 'admin', '1', '127.0.0.1', '1', '1441344261', 'N');
INSERT INTO `kv_admin_log` VALUES ('313', '1', '修改设置type=ip;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1441346096', 'N');
INSERT INTO `kv_admin_log` VALUES ('314', '1', '检查到非法操作数据，表:money_type;id=7', '6', 'admin', '1', '127.0.0.1', '1', '1441359048', 'N');
INSERT INTO `kv_admin_log` VALUES ('315', '1', '检查到非法操作数据，表:money_type;id=7', '6', 'admin', '1', '127.0.0.1', '1', '1441359123', 'N');
INSERT INTO `kv_admin_log` VALUES ('316', '1', '编辑资金类型id=7', '4', 'admin', '1', '127.0.0.1', '1', '1441359142', 'N');
INSERT INTO `kv_admin_log` VALUES ('317', '1', '检查到非法操作数据，表:money_type;id=7', '6', 'admin', '1', '127.0.0.1', '1', '1441359164', 'N');
INSERT INTO `kv_admin_log` VALUES ('318', '1', '编辑资金类型id=5', '4', 'admin', '1', '127.0.0.1', '1', '1441359335', 'N');
INSERT INTO `kv_admin_log` VALUES ('319', '1', '编辑资金类型id=3', '4', 'admin', '1', '127.0.0.1', '1', '1441359356', 'N');
INSERT INTO `kv_admin_log` VALUES ('320', '1', '编辑资金类型id=3', '4', 'admin', '1', '127.0.0.1', '1', '1441359389', 'N');
INSERT INTO `kv_admin_log` VALUES ('321', '1', '编辑资金类型id=2', '4', 'admin', '1', '127.0.0.1', '1', '1441359410', 'N');
INSERT INTO `kv_admin_log` VALUES ('322', '1', '编辑资金类型id=1', '4', 'admin', '1', '127.0.0.1', '1', '1441359420', 'N');
INSERT INTO `kv_admin_log` VALUES ('323', '1', '编辑资金类型id=2', '4', 'admin', '1', '127.0.0.1', '1', '1441359434', 'N');
INSERT INTO `kv_admin_log` VALUES ('324', '1', '编辑资金类型id=6', '4', 'admin', '1', '127.0.0.1', '1', '1441359471', 'N');
INSERT INTO `kv_admin_log` VALUES ('325', '1', '添加资金类型id=8', '3', 'admin', '1', '127.0.0.1', '1', '1441359500', 'N');
INSERT INTO `kv_admin_log` VALUES ('326', '1', '编辑资金类型id=6', '4', 'admin', '1', '127.0.0.1', '1', '1441359545', 'N');
INSERT INTO `kv_admin_log` VALUES ('327', '1', '编辑资金类型id=5', '4', 'admin', '1', '127.0.0.1', '1', '1441359939', 'N');
INSERT INTO `kv_admin_log` VALUES ('328', '1', '添加资金类型id=9', '3', 'admin', '1', '127.0.0.1', '1', '1441359953', 'N');
INSERT INTO `kv_admin_log` VALUES ('329', '1', '编辑资金类型id=6', '4', 'admin', '1', '127.0.0.1', '1', '1441360035', 'N');
INSERT INTO `kv_admin_log` VALUES ('330', '1', '权限组2修改', '4', 'admin', '1', '127.0.0.1', '1', '1441364630', 'N');
INSERT INTO `kv_admin_log` VALUES ('331', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441430042', 'N');
INSERT INTO `kv_admin_log` VALUES ('332', '1', '编辑信息设置id(1)', '4', 'admin', '1', '127.0.0.1', '1', '1441430245', 'N');
INSERT INTO `kv_admin_log` VALUES ('333', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441430362', 'N');
INSERT INTO `kv_admin_log` VALUES ('334', '1', '编辑信息设置id(2)', '4', 'admin', '1', '127.0.0.1', '1', '1441430371', 'N');
INSERT INTO `kv_admin_log` VALUES ('335', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441430411', 'N');
INSERT INTO `kv_admin_log` VALUES ('336', '1', '编辑信息设置id(2)', '4', 'admin', '1', '127.0.0.1', '1', '1441430856', 'N');
INSERT INTO `kv_admin_log` VALUES ('337', '1', '编辑信息设置id(3)', '4', 'admin', '1', '127.0.0.1', '1', '1441430908', 'N');
INSERT INTO `kv_admin_log` VALUES ('338', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441430964', 'N');
INSERT INTO `kv_admin_log` VALUES ('339', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441431010', 'N');
INSERT INTO `kv_admin_log` VALUES ('340', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441431029', 'N');
INSERT INTO `kv_admin_log` VALUES ('341', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441431133', 'N');
INSERT INTO `kv_admin_log` VALUES ('342', '1', '编辑信息设置id(7)', '4', 'admin', '1', '127.0.0.1', '1', '1441431146', 'N');
INSERT INTO `kv_admin_log` VALUES ('343', '1', '编辑信息设置id(2)', '4', 'admin', '1', '127.0.0.1', '1', '1441431454', 'N');
INSERT INTO `kv_admin_log` VALUES ('344', '1', '权限组3修改', '4', 'admin', '1', '127.0.0.1', '1', '1441431729', 'N');
INSERT INTO `kv_admin_log` VALUES ('345', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441438962', 'N');
INSERT INTO `kv_admin_log` VALUES ('346', '1', '编辑信息设置id(1)', '4', 'admin', '1', '127.0.0.1', '1', '1441439032', 'N');
INSERT INTO `kv_admin_log` VALUES ('347', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441441558', 'N');
INSERT INTO `kv_admin_log` VALUES ('348', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441441811', 'N');
INSERT INTO `kv_admin_log` VALUES ('349', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441441914', 'N');
INSERT INTO `kv_admin_log` VALUES ('350', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441441990', 'N');
INSERT INTO `kv_admin_log` VALUES ('351', '1', '添加信息设置)', '3', 'admin', '1', '127.0.0.1', '1', '1441442123', 'N');
INSERT INTO `kv_admin_log` VALUES ('352', '1', '添加资金状态id=1', '3', 'admin', '1', '127.0.0.1', '1', '1441522148', 'N');
INSERT INTO `kv_admin_log` VALUES ('353', '1', '添加资金状态id=2', '3', 'admin', '1', '127.0.0.1', '1', '1441522155', 'N');
INSERT INTO `kv_admin_log` VALUES ('354', '1', '添加资金状态id=3', '3', 'admin', '1', '127.0.0.1', '1', '1441522161', 'N');
INSERT INTO `kv_admin_log` VALUES ('355', '1', '添加资金状态id=4', '3', 'admin', '1', '127.0.0.1', '1', '1441522167', 'N');
INSERT INTO `kv_admin_log` VALUES ('356', '1', '添加资金状态id=5', '3', 'admin', '1', '127.0.0.1', '1', '1441522173', 'N');
INSERT INTO `kv_admin_log` VALUES ('357', '1', '编辑资金状态id=2', '4', 'admin', '1', '127.0.0.1', '1', '1441524979', 'N');
INSERT INTO `kv_admin_log` VALUES ('358', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441531070', 'N');
INSERT INTO `kv_admin_log` VALUES ('359', '1', '添加第三方支付id=1', '3', 'admin', '1', '127.0.0.1', '2', '1441694754', 'N');
INSERT INTO `kv_admin_log` VALUES ('360', '1', '添加第三方支付id=2', '3', 'admin', '1', '127.0.0.1', '2', '1441694972', 'N');
INSERT INTO `kv_admin_log` VALUES ('361', '1', '编辑第三方支付id=1', '4', 'admin', '1', '127.0.0.1', '2', '1441695040', 'N');
INSERT INTO `kv_admin_log` VALUES ('362', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441868519', 'N');
INSERT INTO `kv_admin_log` VALUES ('363', '1', '检查到非法操作数据，表:money_third;id=2', '6', 'admin', '1', '127.0.0.1', '3', '1441870912', 'N');
INSERT INTO `kv_admin_log` VALUES ('364', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441872013', 'N');
INSERT INTO `kv_admin_log` VALUES ('365', '1', '添加资金状态id=6', '3', 'admin', '1', '127.0.0.1', '1', '1441874874', 'N');
INSERT INTO `kv_admin_log` VALUES ('366', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441875572', 'N');
INSERT INTO `kv_admin_log` VALUES ('367', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1441940274', 'N');
INSERT INTO `kv_admin_log` VALUES ('368', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1442036260', 'N');
INSERT INTO `kv_admin_log` VALUES ('369', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1442036300', 'N');
INSERT INTO `kv_admin_log` VALUES ('370', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1442056581', 'N');
INSERT INTO `kv_admin_log` VALUES ('371', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1442056593', 'N');
INSERT INTO `kv_admin_log` VALUES ('372', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1442056755', 'N');
INSERT INTO `kv_admin_log` VALUES ('373', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1442056794', 'N');
INSERT INTO `kv_admin_log` VALUES ('374', '1', '修改设置type=web;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1442056822', 'N');
INSERT INTO `kv_admin_log` VALUES ('375', '1', '修改设置type=sale;agent_id=2', '4', 'admin', '1', '127.0.0.1', '2', '1442056837', 'N');
INSERT INTO `kv_admin_log` VALUES ('376', '1', '编辑管理员id=8', '4', 'admin', '1', '127.0.0.1', '1', '1442123694', 'N');
INSERT INTO `kv_admin_log` VALUES ('377', '1', '编辑管理员id=8', '4', 'admin', '1', '127.0.0.1', '1', '1442124009', 'N');
INSERT INTO `kv_admin_log` VALUES ('378', '1', '编辑管理员id=8', '4', 'admin', '1', '127.0.0.1', '1', '1442124083', 'N');
INSERT INTO `kv_admin_log` VALUES ('379', '1', '编辑管理员id=8', '4', 'admin', '1', '127.0.0.1', '1', '1442124107', 'N');
INSERT INTO `kv_admin_log` VALUES ('380', '1', '权限组3修改', '4', 'admin', '1', '127.0.0.1', '1', '1442124227', 'N');
INSERT INTO `kv_admin_log` VALUES ('381', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1442464191', 'N');
INSERT INTO `kv_admin_log` VALUES ('382', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1442558211', 'N');
INSERT INTO `kv_admin_log` VALUES ('383', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1442811846', 'N');
INSERT INTO `kv_admin_log` VALUES ('384', '1', '登录成功', '1', 'admin', '1', '127.0.0.1', '1', '1443594347', 'N');

-- ----------------------------
-- Table structure for `kv_admin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `kv_admin_menu`;
CREATE TABLE `kv_admin_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `url` varchar(100) DEFAULT NULL COMMENT '菜单链接',
  `parent_id` int(10) DEFAULT '0' COMMENT '父类id',
  `sort` smallint(4) DEFAULT '0' COMMENT '从大到小',
  `level` tinyint(1) NOT NULL DEFAULT '1' COMMENT '菜单级别',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT 'Y启用，N关闭',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of kv_admin_menu
-- ----------------------------
INSERT INTO `kv_admin_menu` VALUES ('1', '系统设置', '', '0', '20', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('2', '菜单设置', '/setting-menu.html', '1', '99', '0', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('3', '会员管理', '', '0', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('4', '会员列表', '/user-list.html', '3', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('18', '管理组管理', '/setting-group.html', '1', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('19', '管理员管理', '/setting-manager.html', '1', '96', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('23', '总代管理', '', '0', '93', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('24', '总代列表', '/agent-list.html', '23', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('25', '会员级别', '/user-group.html', '3', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('27', '资金管理', '', '0', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('28', '资金记录', '/money-note.html', '27', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('29', '资金类型', '/money-type.html', '27', '97', '0', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('30', '日志记录', '', '0', '10', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('31', '操作记录', '/log-operate.html', '30', '99', '0', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('38', '推广管理', '', '0', '91', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('39', '推广统计', '', '38', '95', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('40', '来源统计', '', '38', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('42', '活动管理', '', '0', '89', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('43', '优惠活动', '', '42', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('44', '信息管理', '', '0', '87', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('45', '滚动信息发布', '/message-nav.html', '44', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('46', '会员中心信息', '/message-center.html', '44', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('47', '信息类型设置', '/message-type.html', '44', '95', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('48', '站内信心列表', '/message-inside.html', '44', '93', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('50', '资金记录', '/log-money.html', '30', '91', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('51', '收款银行', '/money-bank.html', '27', '95', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('58', 'IP黑白名单', '/setting-ip.html', '1', '93', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('59', 'API设置', '/setting-api.html', '1', '91', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('60', '网站设置', '/setting-web.html', '1', '89', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('61', 'URL管理', '', '0', '30', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('62', 'URL设置', '/url-setting.html', '61', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('63', 'URL列表', '/url-list.html', '61', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('64', '会员银行类别', '/user-banktype.html', '3', '95', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('65', '游戏管理', '', '0', '42', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('66', '游戏类型', '/game-type.html', '65', '99', '0', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('67', '总代设置', '/agent-host.html', '23', '97', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('68', '网站版本', '/agent-version.html', '23', '93', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('70', '服务器设置', '/setting-server.html', '1', '98', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('71', '优惠设置', '/setting-sale.html', '1', '89', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('73', '推广域名', '/extend-host.html', '38', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('74', '浏览记录', '/log-view.html', '30', '96', '0', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('76', '返水设置', '/extend-rebate.html', '77', '99', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('77', '代理管理', '', '0', '92', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('79', '第三方支付', '/money-third.html', '27', '91', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('84', '会员银行卡', '/user-bank.html', '3', '93', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('85', '短信记录', '/message-sms.html', '44', '91', '1', 'Y', 'N');
INSERT INTO `kv_admin_menu` VALUES ('86', '资金状态', '/money-status.html', '27', '93', '0', 'Y', 'N');

-- ----------------------------
-- Table structure for `kv_admin_view`
-- ----------------------------
DROP TABLE IF EXISTS `kv_admin_view`;
CREATE TABLE `kv_admin_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL COMMENT '访问url',
  `param` text NOT NULL COMMENT '参数',
  `sel_agent_id` mediumint(10) NOT NULL COMMENT '被操作代理',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `username` varchar(30) DEFAULT NULL COMMENT '操作人',
  `uid` int(11) DEFAULT '0',
  `ip` varchar(40) NOT NULL COMMENT 'ip地址',
  `addtime` int(11) NOT NULL COMMENT '操作时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5986 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_admin_view
-- ----------------------------
INSERT INTO `kv_admin_view` VALUES ('5617', 'http://admin.game.com/ajax/exam.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441874624', 'N');
INSERT INTO `kv_admin_view` VALUES ('5618', 'http://admin.game.com/ajax/exam.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441874628', 'N');
INSERT INTO `kv_admin_view` VALUES ('5619', 'http://admin.game.com/ajax/exam.html', '{\"post\":{\"type\":\"3\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441874665', 'N');
INSERT INTO `kv_admin_view` VALUES ('5620', 'http://admin.game.com/ajax/exam.html', '{\"post\":{\"type\":\"3\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441874670', 'N');
INSERT INTO `kv_admin_view` VALUES ('5621', 'http://admin.game.com/ajax/exam.html', '{\"post\":{\"type\":\"3\",\"id\":\"2\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441874757', 'N');
INSERT INTO `kv_admin_view` VALUES ('5622', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874851', 'N');
INSERT INTO `kv_admin_view` VALUES ('5623', 'http://admin.game.com/money-status.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874861', 'N');
INSERT INTO `kv_admin_view` VALUES ('5624', 'http://admin.game.com/ajax/money-status.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874862', 'N');
INSERT INTO `kv_admin_view` VALUES ('5625', 'http://admin.game.com/ajax/money-status.html', '{\"post\":{\"action\":\"one\",\"id\":\"5\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874866', 'N');
INSERT INTO `kv_admin_view` VALUES ('5626', 'http://admin.game.com/ajax/money-status.html', '{\"post\":{\"action\":\"save\",\"id\":\"0\",\"name\":\"\\u786e\\u8ba4\\u4e2d\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874874', 'N');
INSERT INTO `kv_admin_view` VALUES ('5627', 'http://admin.game.com/ajax/money-status.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874875', 'N');
INSERT INTO `kv_admin_view` VALUES ('5628', 'http://admin.game.com/ajax/money-status.html', '{\"post\":{\"action\":\"one\",\"id\":\"6\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441874881', 'N');
INSERT INTO `kv_admin_view` VALUES ('5629', 'http://admin.game.com/ajax/logout.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441875557', 'N');
INSERT INTO `kv_admin_view` VALUES ('5630', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441875574', 'N');
INSERT INTO `kv_admin_view` VALUES ('5631', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441884580', 'N');
INSERT INTO `kv_admin_view` VALUES ('5632', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441884587', 'N');
INSERT INTO `kv_admin_view` VALUES ('5633', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1441884587', 'N');
INSERT INTO `kv_admin_view` VALUES ('5634', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441884587', 'N');
INSERT INTO `kv_admin_view` VALUES ('5635', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441884591', 'N');
INSERT INTO `kv_admin_view` VALUES ('5636', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441885034', 'N');
INSERT INTO `kv_admin_view` VALUES ('5637', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441885036', 'N');
INSERT INTO `kv_admin_view` VALUES ('5638', 'http://admin.game.com/ajax/opmoney.html?action=exam', '{\"post\":[],\"get\":{\"action\":\"exam\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1441885398', 'N');
INSERT INTO `kv_admin_view` VALUES ('5639', 'http://admin.game.com/ajax/opmoney.html?action=exam', '{\"post\":[],\"get\":{\"action\":\"exam\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1441885406', 'N');
INSERT INTO `kv_admin_view` VALUES ('5640', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441885432', 'N');
INSERT INTO `kv_admin_view` VALUES ('5641', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441885489', 'N');
INSERT INTO `kv_admin_view` VALUES ('5642', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441885492', 'N');
INSERT INTO `kv_admin_view` VALUES ('5643', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1441940276', 'N');
INSERT INTO `kv_admin_view` VALUES ('5644', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1441943122', 'N');
INSERT INTO `kv_admin_view` VALUES ('5645', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441943126', 'N');
INSERT INTO `kv_admin_view` VALUES ('5646', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441943128', 'N');
INSERT INTO `kv_admin_view` VALUES ('5647', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441943136', 'N');
INSERT INTO `kv_admin_view` VALUES ('5648', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441943209', 'N');
INSERT INTO `kv_admin_view` VALUES ('5649', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441943307', 'N');
INSERT INTO `kv_admin_view` VALUES ('5650', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441944456', 'N');
INSERT INTO `kv_admin_view` VALUES ('5651', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441944459', 'N');
INSERT INTO `kv_admin_view` VALUES ('5652', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441944487', 'N');
INSERT INTO `kv_admin_view` VALUES ('5653', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441944490', 'N');
INSERT INTO `kv_admin_view` VALUES ('5654', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441946405', 'N');
INSERT INTO `kv_admin_view` VALUES ('5655', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441946408', 'N');
INSERT INTO `kv_admin_view` VALUES ('5656', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441946493', 'N');
INSERT INTO `kv_admin_view` VALUES ('5657', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441946495', 'N');
INSERT INTO `kv_admin_view` VALUES ('5658', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951699', 'N');
INSERT INTO `kv_admin_view` VALUES ('5659', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951702', 'N');
INSERT INTO `kv_admin_view` VALUES ('5660', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951729', 'N');
INSERT INTO `kv_admin_view` VALUES ('5661', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951731', 'N');
INSERT INTO `kv_admin_view` VALUES ('5662', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951790', 'N');
INSERT INTO `kv_admin_view` VALUES ('5663', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951793', 'N');
INSERT INTO `kv_admin_view` VALUES ('5664', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951852', 'N');
INSERT INTO `kv_admin_view` VALUES ('5665', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951854', 'N');
INSERT INTO `kv_admin_view` VALUES ('5666', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951956', 'N');
INSERT INTO `kv_admin_view` VALUES ('5667', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1441951959', 'N');
INSERT INTO `kv_admin_view` VALUES ('5668', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442036262', 'N');
INSERT INTO `kv_admin_view` VALUES ('5669', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442036302', 'N');
INSERT INTO `kv_admin_view` VALUES ('5670', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442036312', 'N');
INSERT INTO `kv_admin_view` VALUES ('5671', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036320', 'N');
INSERT INTO `kv_admin_view` VALUES ('5672', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036322', 'N');
INSERT INTO `kv_admin_view` VALUES ('5673', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036424', 'N');
INSERT INTO `kv_admin_view` VALUES ('5674', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036426', 'N');
INSERT INTO `kv_admin_view` VALUES ('5675', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036456', 'N');
INSERT INTO `kv_admin_view` VALUES ('5676', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036458', 'N');
INSERT INTO `kv_admin_view` VALUES ('5677', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036680', 'N');
INSERT INTO `kv_admin_view` VALUES ('5678', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442036682', 'N');
INSERT INTO `kv_admin_view` VALUES ('5679', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037024', 'N');
INSERT INTO `kv_admin_view` VALUES ('5680', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037026', 'N');
INSERT INTO `kv_admin_view` VALUES ('5681', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037066', 'N');
INSERT INTO `kv_admin_view` VALUES ('5682', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037068', 'N');
INSERT INTO `kv_admin_view` VALUES ('5683', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037074', 'N');
INSERT INTO `kv_admin_view` VALUES ('5684', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037079', 'N');
INSERT INTO `kv_admin_view` VALUES ('5685', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037082', 'N');
INSERT INTO `kv_admin_view` VALUES ('5686', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037093', 'N');
INSERT INTO `kv_admin_view` VALUES ('5687', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037119', 'N');
INSERT INTO `kv_admin_view` VALUES ('5688', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037121', 'N');
INSERT INTO `kv_admin_view` VALUES ('5689', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037159', 'N');
INSERT INTO `kv_admin_view` VALUES ('5690', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037161', 'N');
INSERT INTO `kv_admin_view` VALUES ('5691', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037180', 'N');
INSERT INTO `kv_admin_view` VALUES ('5692', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037182', 'N');
INSERT INTO `kv_admin_view` VALUES ('5693', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037312', 'N');
INSERT INTO `kv_admin_view` VALUES ('5694', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037319', 'N');
INSERT INTO `kv_admin_view` VALUES ('5695', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037321', 'N');
INSERT INTO `kv_admin_view` VALUES ('5696', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037324', 'N');
INSERT INTO `kv_admin_view` VALUES ('5697', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037334', 'N');
INSERT INTO `kv_admin_view` VALUES ('5698', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037344', 'N');
INSERT INTO `kv_admin_view` VALUES ('5699', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037355', 'N');
INSERT INTO `kv_admin_view` VALUES ('5700', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037364', 'N');
INSERT INTO `kv_admin_view` VALUES ('5701', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037520', 'N');
INSERT INTO `kv_admin_view` VALUES ('5702', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037587', 'N');
INSERT INTO `kv_admin_view` VALUES ('5703', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037590', 'N');
INSERT INTO `kv_admin_view` VALUES ('5704', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037616', 'N');
INSERT INTO `kv_admin_view` VALUES ('5705', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037618', 'N');
INSERT INTO `kv_admin_view` VALUES ('5706', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037682', 'N');
INSERT INTO `kv_admin_view` VALUES ('5707', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442037684', 'N');
INSERT INTO `kv_admin_view` VALUES ('5708', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442041533', 'N');
INSERT INTO `kv_admin_view` VALUES ('5709', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442041552', 'N');
INSERT INTO `kv_admin_view` VALUES ('5710', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442041680', 'N');
INSERT INTO `kv_admin_view` VALUES ('5711', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442041882', 'N');
INSERT INTO `kv_admin_view` VALUES ('5712', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043214', 'N');
INSERT INTO `kv_admin_view` VALUES ('5713', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043216', 'N');
INSERT INTO `kv_admin_view` VALUES ('5714', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043222', 'N');
INSERT INTO `kv_admin_view` VALUES ('5715', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043224', 'N');
INSERT INTO `kv_admin_view` VALUES ('5716', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043275', 'N');
INSERT INTO `kv_admin_view` VALUES ('5717', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043277', 'N');
INSERT INTO `kv_admin_view` VALUES ('5718', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043360', 'N');
INSERT INTO `kv_admin_view` VALUES ('5719', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043362', 'N');
INSERT INTO `kv_admin_view` VALUES ('5720', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043380', 'N');
INSERT INTO `kv_admin_view` VALUES ('5721', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043382', 'N');
INSERT INTO `kv_admin_view` VALUES ('5722', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043434', 'N');
INSERT INTO `kv_admin_view` VALUES ('5723', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043436', 'N');
INSERT INTO `kv_admin_view` VALUES ('5724', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043442', 'N');
INSERT INTO `kv_admin_view` VALUES ('5725', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043443', 'N');
INSERT INTO `kv_admin_view` VALUES ('5726', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043477', 'N');
INSERT INTO `kv_admin_view` VALUES ('5727', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043482', 'N');
INSERT INTO `kv_admin_view` VALUES ('5728', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043503', 'N');
INSERT INTO `kv_admin_view` VALUES ('5729', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043507', 'N');
INSERT INTO `kv_admin_view` VALUES ('5730', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043611', 'N');
INSERT INTO `kv_admin_view` VALUES ('5731', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043613', 'N');
INSERT INTO `kv_admin_view` VALUES ('5732', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043618', 'N');
INSERT INTO `kv_admin_view` VALUES ('5733', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043622', 'N');
INSERT INTO `kv_admin_view` VALUES ('5734', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"5\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043635', 'N');
INSERT INTO `kv_admin_view` VALUES ('5735', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"5\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043656', 'N');
INSERT INTO `kv_admin_view` VALUES ('5736', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"5\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442043675', 'N');
INSERT INTO `kv_admin_view` VALUES ('5737', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"1\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044273', 'N');
INSERT INTO `kv_admin_view` VALUES ('5738', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044274', 'N');
INSERT INTO `kv_admin_view` VALUES ('5739', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"1\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044277', 'N');
INSERT INTO `kv_admin_view` VALUES ('5740', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044279', 'N');
INSERT INTO `kv_admin_view` VALUES ('5741', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"1\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044291', 'N');
INSERT INTO `kv_admin_view` VALUES ('5742', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"1\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044298', 'N');
INSERT INTO `kv_admin_view` VALUES ('5743', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"3\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044302', 'N');
INSERT INTO `kv_admin_view` VALUES ('5744', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"3\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044306', 'N');
INSERT INTO `kv_admin_view` VALUES ('5745', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"3\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044311', 'N');
INSERT INTO `kv_admin_view` VALUES ('5746', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"3\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044316', 'N');
INSERT INTO `kv_admin_view` VALUES ('5747', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"1\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044321', 'N');
INSERT INTO `kv_admin_view` VALUES ('5748', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"1\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044325', 'N');
INSERT INTO `kv_admin_view` VALUES ('5749', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044358', 'N');
INSERT INTO `kv_admin_view` VALUES ('5750', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044360', 'N');
INSERT INTO `kv_admin_view` VALUES ('5751', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044379', 'N');
INSERT INTO `kv_admin_view` VALUES ('5752', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044381', 'N');
INSERT INTO `kv_admin_view` VALUES ('5753', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044384', 'N');
INSERT INTO `kv_admin_view` VALUES ('5754', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044385', 'N');
INSERT INTO `kv_admin_view` VALUES ('5755', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"6\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044391', 'N');
INSERT INTO `kv_admin_view` VALUES ('5756', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044392', 'N');
INSERT INTO `kv_admin_view` VALUES ('5757', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044432', 'N');
INSERT INTO `kv_admin_view` VALUES ('5758', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044434', 'N');
INSERT INTO `kv_admin_view` VALUES ('5759', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044551', 'N');
INSERT INTO `kv_admin_view` VALUES ('5760', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442044554', 'N');
INSERT INTO `kv_admin_view` VALUES ('5761', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442056166', 'N');
INSERT INTO `kv_admin_view` VALUES ('5762', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056176', 'N');
INSERT INTO `kv_admin_view` VALUES ('5763', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056177', 'N');
INSERT INTO `kv_admin_view` VALUES ('5764', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056418', 'N');
INSERT INTO `kv_admin_view` VALUES ('5765', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056421', 'N');
INSERT INTO `kv_admin_view` VALUES ('5766', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056434', 'N');
INSERT INTO `kv_admin_view` VALUES ('5767', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056438', 'N');
INSERT INTO `kv_admin_view` VALUES ('5768', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056554', 'N');
INSERT INTO `kv_admin_view` VALUES ('5769', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056555', 'N');
INSERT INTO `kv_admin_view` VALUES ('5770', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"save\",\"sale_first_money\":\"8888\",\"sale_first\":\"30\",\"sale_times\":\"18\",\"sale_transfer_money\":\"50\",\"sale_transfer\":\"1\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056580', 'N');
INSERT INTO `kv_admin_view` VALUES ('5771', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056582', 'N');
INSERT INTO `kv_admin_view` VALUES ('5772', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"save\",\"sale_first_money\":\"8888\",\"sale_first\":\"30\",\"sale_times\":\"18\",\"sale_transfer_money\":\"50\",\"sale_transfer\":\"2\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056593', 'N');
INSERT INTO `kv_admin_view` VALUES ('5773', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056594', 'N');
INSERT INTO `kv_admin_view` VALUES ('5774', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056601', 'N');
INSERT INTO `kv_admin_view` VALUES ('5775', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056602', 'N');
INSERT INTO `kv_admin_view` VALUES ('5776', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056661', 'N');
INSERT INTO `kv_admin_view` VALUES ('5777', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056666', 'N');
INSERT INTO `kv_admin_view` VALUES ('5778', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"save\",\"sale_first_money\":\"8888\",\"sale_first\":\"30\",\"sale_times\":\"18\",\"sale_transfer_money\":\"50\",\"sale_transfer\":\"2\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056755', 'N');
INSERT INTO `kv_admin_view` VALUES ('5779', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056756', 'N');
INSERT INTO `kv_admin_view` VALUES ('5780', 'http://admin.game.com/setting-sale.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056759', 'N');
INSERT INTO `kv_admin_view` VALUES ('5781', 'http://admin.game.com/ajax/setting-sale.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056761', 'N');
INSERT INTO `kv_admin_view` VALUES ('5782', 'http://admin.game.com/setting-web.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056765', 'N');
INSERT INTO `kv_admin_view` VALUES ('5783', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056766', 'N');
INSERT INTO `kv_admin_view` VALUES ('5784', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"save\",\"web_setting_status\":\"1\",\"web_setting_other_title\":\"\",\"web_setting_keywords\":\"\",\"undefined\":\"\",\"web_setting_description\":\"\",\"web_user_register\":\"\",\"web_user_activate\":\"\",\"web_user_phone\":\"\",\"web_user_phone_only\":\"\",\"web_user_ip_time\":\"\",\"web_user_ip_total\":\"\",\"web_user_pc_time\":\"\",\"web_user_pc_total\":\"\",\"web_extend_status\":\"\",\"web_extend_url1\":\"\",\"web_extend_url2\":\"\",\"web_extend_url3\":\"\",\"web_custom_online\":\"\",\"web_custom_phone\":\"\",\"web_custom_email\":\"\",\"web_custom_qq1\":\"\",\"web_custom_qq2\":\"\",\"web_custom_qq3\":\"\",\"web_sms_register\":\"\",\"web_sms_deposit\":\"\",\"web_sms_draw\":\"\",\"web_sms_bonus\":\"\",\"web_sms_sale\":\"\",\"web_sms_url\":\"\",\"web_sms_username\":\"\",\"web_sms_password\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056793', 'N');
INSERT INTO `kv_admin_view` VALUES ('5785', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"save\",\"web_setting_status\":\"1\",\"web_setting_other_title\":\"\",\"web_setting_keywords\":\"\",\"undefined\":\"\",\"web_setting_description\":\"\",\"web_user_register\":\"\",\"web_user_activate\":\"\",\"web_user_phone\":\"\",\"web_user_phone_only\":\"\",\"web_user_ip_time\":\"\",\"web_user_ip_total\":\"\",\"web_user_pc_time\":\"\",\"web_user_pc_total\":\"\",\"web_extend_status\":\"\",\"web_extend_url1\":\"\",\"web_extend_url2\":\"\",\"web_extend_url3\":\"\",\"web_custom_online\":\"\",\"web_custom_phone\":\"\",\"web_custom_email\":\"\",\"web_custom_qq1\":\"\",\"web_custom_qq2\":\"\",\"web_custom_qq3\":\"\",\"web_sms_register\":\"\",\"web_sms_deposit\":\"\",\"web_sms_draw\":\"\",\"web_sms_bonus\":\"\",\"web_sms_sale\":\"\",\"web_sms_url\":\"\",\"web_sms_username\":\"\",\"web_sms_password\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056822', 'N');
INSERT INTO `kv_admin_view` VALUES ('5786', 'http://admin.game.com/ajax/setting-web.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056823', 'N');
INSERT INTO `kv_admin_view` VALUES ('5787', 'http://admin.game.com/ajax/setting-sale.html', '{\"post\":{\"action\":\"save\",\"sale_first_money\":\"8888\",\"sale_first\":\"30\",\"sale_times\":\"18\",\"sale_transfer_money\":\"50\",\"sale_transfer\":\"2\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056837', 'N');
INSERT INTO `kv_admin_view` VALUES ('5788', 'http://admin.game.com/ajax/setting-sale.html', '{\"post\":{\"action\":\"one\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442056838', 'N');
INSERT INTO `kv_admin_view` VALUES ('5789', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442121726', 'N');
INSERT INTO `kv_admin_view` VALUES ('5790', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442121729', 'N');
INSERT INTO `kv_admin_view` VALUES ('5791', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442123515', 'N');
INSERT INTO `kv_admin_view` VALUES ('5792', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442123518', 'N');
INSERT INTO `kv_admin_view` VALUES ('5793', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442123544', 'N');
INSERT INTO `kv_admin_view` VALUES ('5794', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442123547', 'N');
INSERT INTO `kv_admin_view` VALUES ('5795', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442123560', 'N');
INSERT INTO `kv_admin_view` VALUES ('5796', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123573', 'N');
INSERT INTO `kv_admin_view` VALUES ('5797', 'http://admin.game.com/setting-group.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123581', 'N');
INSERT INTO `kv_admin_view` VALUES ('5798', 'http://admin.game.com/ajax/setting-group.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123582', 'N');
INSERT INTO `kv_admin_view` VALUES ('5799', 'http://admin.game.com/ajax/setting-group.html', '{\"post\":{\"action\":\"html\",\"id\":\"3\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123585', 'N');
INSERT INTO `kv_admin_view` VALUES ('5800', 'http://admin.game.com/setting-manager.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123588', 'N');
INSERT INTO `kv_admin_view` VALUES ('5801', 'http://admin.game.com/ajax/setting-manager.html?action=group&sel_agent_id=0', '{\"post\":[],\"get\":{\"action\":\"group\",\"sel_agent_id\":\"0\"}}', '1', '1', 'admin', '1', '127.0.0.1', '1442123589', 'N');
INSERT INTO `kv_admin_view` VALUES ('5802', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123589', 'N');
INSERT INTO `kv_admin_view` VALUES ('5803', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"one\",\"id\":\"8\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123591', 'N');
INSERT INTO `kv_admin_view` VALUES ('5804', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"edit_username\":\"kevin\",\"edit_password\":\"\",\"edit_cpassword\":\"\",\"edit_group_id\":\"3\",\"edit_maxmoney\":\"10000000.00\",\"edit_operatemoney\":\"0.00\",\"edit_status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123596', 'N');
INSERT INTO `kv_admin_view` VALUES ('5805', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"edit_username\":\"kevin\",\"edit_password\":\"\",\"edit_cpassword\":\"\",\"edit_group_id\":\"3\",\"edit_maxmoney\":\"10000000.00\",\"edit_operatemoney\":\"0.00\",\"edit_status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123600', 'N');
INSERT INTO `kv_admin_view` VALUES ('5806', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"edit_username\":\"kevin\",\"edit_password\":\"\",\"edit_cpassword\":\"\",\"edit_group_id\":\"3\",\"edit_maxmoney\":\"10000000.00\",\"edit_operatemoney\":\"0.00\",\"edit_status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123624', 'N');
INSERT INTO `kv_admin_view` VALUES ('5807', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"edit_username\":\"kevin\",\"edit_password\":\"\",\"edit_cpassword\":\"\",\"edit_group_id\":\"3\",\"edit_maxmoney\":\"10000000.00\",\"edit_operatemoney\":\"0.00\",\"edit_status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123694', 'N');
INSERT INTO `kv_admin_view` VALUES ('5808', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123695', 'N');
INSERT INTO `kv_admin_view` VALUES ('5809', 'http://admin.game.com/setting-manager.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123703', 'N');
INSERT INTO `kv_admin_view` VALUES ('5810', 'http://admin.game.com/ajax/setting-manager.html?action=group&sel_agent_id=0', '{\"post\":[],\"get\":{\"action\":\"group\",\"sel_agent_id\":\"0\"}}', '1', '1', 'admin', '1', '127.0.0.1', '1442123704', 'N');
INSERT INTO `kv_admin_view` VALUES ('5811', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123704', 'N');
INSERT INTO `kv_admin_view` VALUES ('5812', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123785', 'N');
INSERT INTO `kv_admin_view` VALUES ('5813', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"one\",\"id\":\"8\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123799', 'N');
INSERT INTO `kv_admin_view` VALUES ('5814', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123856', 'N');
INSERT INTO `kv_admin_view` VALUES ('5815', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123950', 'N');
INSERT INTO `kv_admin_view` VALUES ('5816', 'http://admin.game.com/setting-manager.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123980', 'N');
INSERT INTO `kv_admin_view` VALUES ('5817', 'http://admin.game.com/ajax/setting-manager.html?action=group&sel_agent_id=0', '{\"post\":[],\"get\":{\"action\":\"group\",\"sel_agent_id\":\"0\"}}', '1', '1', 'admin', '1', '127.0.0.1', '1442123981', 'N');
INSERT INTO `kv_admin_view` VALUES ('5818', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123981', 'N');
INSERT INTO `kv_admin_view` VALUES ('5819', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442123995', 'N');
INSERT INTO `kv_admin_view` VALUES ('5820', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"one\",\"id\":\"8\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124001', 'N');
INSERT INTO `kv_admin_view` VALUES ('5821', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"edit_username\":\"kevin\",\"edit_password\":\"\",\"edit_cpassword\":\"\",\"edit_group_id\":\"3\",\"edit_maxmoney\":\"100000.00\",\"edit_operatemoney\":\"0.00\",\"edit_status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124009', 'N');
INSERT INTO `kv_admin_view` VALUES ('5822', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124010', 'N');
INSERT INTO `kv_admin_view` VALUES ('5823', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124069', 'N');
INSERT INTO `kv_admin_view` VALUES ('5824', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"one\",\"id\":\"8\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124071', 'N');
INSERT INTO `kv_admin_view` VALUES ('5825', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"edit_username\":\"kevin\",\"edit_password\":\"\",\"edit_cpassword\":\"\",\"edit_group_id\":\"3\",\"edit_maxmoney\":\"1000000.00\",\"edit_operatemoney\":\"0.00\",\"edit_status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124083', 'N');
INSERT INTO `kv_admin_view` VALUES ('5826', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124083', 'N');
INSERT INTO `kv_admin_view` VALUES ('5827', 'http://admin.game.com/setting-manager.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124090', 'N');
INSERT INTO `kv_admin_view` VALUES ('5828', 'http://admin.game.com/ajax/setting-manager.html?action=group&sel_agent_id=0', '{\"post\":[],\"get\":{\"action\":\"group\",\"sel_agent_id\":\"0\"}}', '1', '1', 'admin', '1', '127.0.0.1', '1442124091', 'N');
INSERT INTO `kv_admin_view` VALUES ('5829', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124091', 'N');
INSERT INTO `kv_admin_view` VALUES ('5830', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124100', 'N');
INSERT INTO `kv_admin_view` VALUES ('5831', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"one\",\"id\":\"8\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124102', 'N');
INSERT INTO `kv_admin_view` VALUES ('5832', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"save\",\"id\":\"8\",\"username\":\"kevin\",\"password\":\"\",\"cpassword\":\"\",\"group_id\":\"3\",\"maxmoney\":\"10000000.00\",\"operatemoney\":\"0.00\",\"status\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124107', 'N');
INSERT INTO `kv_admin_view` VALUES ('5833', 'http://admin.game.com/ajax/setting-manager.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124108', 'N');
INSERT INTO `kv_admin_view` VALUES ('5834', 'http://admin.game.com/ajax/setting-group.html', '{\"post\":{\"action\":\"html\",\"id\":\"3\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124220', 'N');
INSERT INTO `kv_admin_view` VALUES ('5835', 'http://admin.game.com/ajax/setting-group.html', '{\"post\":{\"action\":\"save\",\"id\":\"3\",\"name\":\"\\u7ba1\\u7406\\u7ec4\",\"menus_list\":\"18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,\",\"menus_one\":\"18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,39,40,73,43,45,46,47,48,85,62,63,76,\",\"menus_add\":\"18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,\",\"menus_edit\":\"18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,\",\"menus_del\":\"18,19,58,59,60,70,71,4,25,64,84,24,67,68,28,51,79,50,39,40,73,43,45,46,47,48,85,62,63,76,\",\"menus_undo\":\"Y\",\"menus_exam\":\"Y\",\"menus_conf\":\"Y\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124227', 'N');
INSERT INTO `kv_admin_view` VALUES ('5836', 'http://admin.game.com/ajax/setting-group.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442124228', 'N');
INSERT INTO `kv_admin_view` VALUES ('5837', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442124274', 'N');
INSERT INTO `kv_admin_view` VALUES ('5838', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124276', 'N');
INSERT INTO `kv_admin_view` VALUES ('5839', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124277', 'N');
INSERT INTO `kv_admin_view` VALUES ('5840', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124317', 'N');
INSERT INTO `kv_admin_view` VALUES ('5841', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124401', 'N');
INSERT INTO `kv_admin_view` VALUES ('5842', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124402', 'N');
INSERT INTO `kv_admin_view` VALUES ('5843', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124437', 'N');
INSERT INTO `kv_admin_view` VALUES ('5844', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124478', 'N');
INSERT INTO `kv_admin_view` VALUES ('5845', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"7\",\"note\":\"\",\"note_other\":\"\\u7535\\u8bdd\\u6ca1\\u6253\\u901a\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124515', 'N');
INSERT INTO `kv_admin_view` VALUES ('5846', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124516', 'N');
INSERT INTO `kv_admin_view` VALUES ('5847', 'http://admin.game.com/user-list.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124559', 'N');
INSERT INTO `kv_admin_view` VALUES ('5848', 'http://admin.game.com/ajax/user-list.html?action=group', '{\"post\":[],\"get\":{\"action\":\"group\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442124560', 'N');
INSERT INTO `kv_admin_view` VALUES ('5849', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442124560', 'N');
INSERT INTO `kv_admin_view` VALUES ('5850', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442125189', 'N');
INSERT INTO `kv_admin_view` VALUES ('5851', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442125198', 'N');
INSERT INTO `kv_admin_view` VALUES ('5852', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442125200', 'N');
INSERT INTO `kv_admin_view` VALUES ('5853', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442125213', 'N');
INSERT INTO `kv_admin_view` VALUES ('5854', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442125222', 'N');
INSERT INTO `kv_admin_view` VALUES ('5855', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442125237', 'N');
INSERT INTO `kv_admin_view` VALUES ('5856', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127472', 'N');
INSERT INTO `kv_admin_view` VALUES ('5857', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127600', 'N');
INSERT INTO `kv_admin_view` VALUES ('5858', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"6\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127606', 'N');
INSERT INTO `kv_admin_view` VALUES ('5859', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127607', 'N');
INSERT INTO `kv_admin_view` VALUES ('5860', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"6\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127615', 'N');
INSERT INTO `kv_admin_view` VALUES ('5861', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127617', 'N');
INSERT INTO `kv_admin_view` VALUES ('5862', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127695', 'N');
INSERT INTO `kv_admin_view` VALUES ('5863', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127698', 'N');
INSERT INTO `kv_admin_view` VALUES ('5864', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127745', 'N');
INSERT INTO `kv_admin_view` VALUES ('5865', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127747', 'N');
INSERT INTO `kv_admin_view` VALUES ('5866', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"9\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127754', 'N');
INSERT INTO `kv_admin_view` VALUES ('5867', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127755', 'N');
INSERT INTO `kv_admin_view` VALUES ('5868', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127769', 'N');
INSERT INTO `kv_admin_view` VALUES ('5869', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"4\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127852', 'N');
INSERT INTO `kv_admin_view` VALUES ('5870', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"5\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127858', 'N');
INSERT INTO `kv_admin_view` VALUES ('5871', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"4\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127863', 'N');
INSERT INTO `kv_admin_view` VALUES ('5872', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"1\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127867', 'N');
INSERT INTO `kv_admin_view` VALUES ('5873', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"4\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127868', 'N');
INSERT INTO `kv_admin_view` VALUES ('5874', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"0\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127872', 'N');
INSERT INTO `kv_admin_view` VALUES ('5875', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"1\",\"note\":\"\\u7535\\u8bdd\\u65e0\\u6cd5\\u6253\\u901a\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127888', 'N');
INSERT INTO `kv_admin_view` VALUES ('5876', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"0\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127889', 'N');
INSERT INTO `kv_admin_view` VALUES ('5877', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127917', 'N');
INSERT INTO `kv_admin_view` VALUES ('5878', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442127920', 'N');
INSERT INTO `kv_admin_view` VALUES ('5879', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"10\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442128133', 'N');
INSERT INTO `kv_admin_view` VALUES ('5880', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"4\",\"id\":\"10\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442128138', 'N');
INSERT INTO `kv_admin_view` VALUES ('5881', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"10\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442128143', 'N');
INSERT INTO `kv_admin_view` VALUES ('5882', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"10\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442128147', 'N');
INSERT INTO `kv_admin_view` VALUES ('5883', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"4\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442128151', 'N');
INSERT INTO `kv_admin_view` VALUES ('5884', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"4\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442128155', 'N');
INSERT INTO `kv_admin_view` VALUES ('5885', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442130760', 'N');
INSERT INTO `kv_admin_view` VALUES ('5886', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442130762', 'N');
INSERT INTO `kv_admin_view` VALUES ('5887', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"0\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442139393', 'N');
INSERT INTO `kv_admin_view` VALUES ('5888', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"0\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442145340', 'N');
INSERT INTO `kv_admin_view` VALUES ('5889', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442145360', 'N');
INSERT INTO `kv_admin_view` VALUES ('5890', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442145362', 'N');
INSERT INTO `kv_admin_view` VALUES ('5891', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442464193', 'N');
INSERT INTO `kv_admin_view` VALUES ('5892', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442558213', 'N');
INSERT INTO `kv_admin_view` VALUES ('5893', 'http://admin.game.com/user-list.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442558386', 'N');
INSERT INTO `kv_admin_view` VALUES ('5894', 'http://admin.game.com/ajax/user-list.html?action=group', '{\"post\":[],\"get\":{\"action\":\"group\"}}', '1', '1', 'admin', '1', '127.0.0.1', '1442558387', 'N');
INSERT INTO `kv_admin_view` VALUES ('5895', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442558387', 'N');
INSERT INTO `kv_admin_view` VALUES ('5896', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442558389', 'N');
INSERT INTO `kv_admin_view` VALUES ('5897', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442558447', 'N');
INSERT INTO `kv_admin_view` VALUES ('5898', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558654', 'N');
INSERT INTO `kv_admin_view` VALUES ('5899', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558657', 'N');
INSERT INTO `kv_admin_view` VALUES ('5900', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558743', 'N');
INSERT INTO `kv_admin_view` VALUES ('5901', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558745', 'N');
INSERT INTO `kv_admin_view` VALUES ('5902', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558786', 'N');
INSERT INTO `kv_admin_view` VALUES ('5903', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558788', 'N');
INSERT INTO `kv_admin_view` VALUES ('5904', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442558793', 'N');
INSERT INTO `kv_admin_view` VALUES ('5905', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442558794', 'N');
INSERT INTO `kv_admin_view` VALUES ('5906', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442558796', 'N');
INSERT INTO `kv_admin_view` VALUES ('5907', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442558800', 'N');
INSERT INTO `kv_admin_view` VALUES ('5908', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558804', 'N');
INSERT INTO `kv_admin_view` VALUES ('5909', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558806', 'N');
INSERT INTO `kv_admin_view` VALUES ('5910', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558847', 'N');
INSERT INTO `kv_admin_view` VALUES ('5911', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558850', 'N');
INSERT INTO `kv_admin_view` VALUES ('5912', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"exam\",\"type\":\"3\",\"id\":\"1\",\"note\":\"\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558869', 'N');
INSERT INTO `kv_admin_view` VALUES ('5913', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"1\",\"id\":\"9\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558875', 'N');
INSERT INTO `kv_admin_view` VALUES ('5914', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"conf\",\"type\":\"2\",\"id\":\"10\",\"note\":\"\\u91d1\\u989d\\u4e0d\\u6b63\\u786e\",\"note_other\":\"\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558884', 'N');
INSERT INTO `kv_admin_view` VALUES ('5915', 'http://admin.game.com/user-list.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558934', 'N');
INSERT INTO `kv_admin_view` VALUES ('5916', 'http://admin.game.com/ajax/user-list.html?action=group', '{\"post\":[],\"get\":{\"action\":\"group\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442558935', 'N');
INSERT INTO `kv_admin_view` VALUES ('5917', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442558935', 'N');
INSERT INTO `kv_admin_view` VALUES ('5918', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442559171', 'N');
INSERT INTO `kv_admin_view` VALUES ('5919', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442559173', 'N');
INSERT INTO `kv_admin_view` VALUES ('5920', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"11\",\"note\":\"11\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442559180', 'N');
INSERT INTO `kv_admin_view` VALUES ('5921', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"11\",\"note\":\"11\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442559538', 'N');
INSERT INTO `kv_admin_view` VALUES ('5922', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"11\",\"note\":\"11\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442559564', 'N');
INSERT INTO `kv_admin_view` VALUES ('5923', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1442811848', 'N');
INSERT INTO `kv_admin_view` VALUES ('5924', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442813585', 'N');
INSERT INTO `kv_admin_view` VALUES ('5925', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813591', 'N');
INSERT INTO `kv_admin_view` VALUES ('5926', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813593', 'N');
INSERT INTO `kv_admin_view` VALUES ('5927', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813594', 'N');
INSERT INTO `kv_admin_view` VALUES ('5928', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813818', 'N');
INSERT INTO `kv_admin_view` VALUES ('5929', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813827', 'N');
INSERT INTO `kv_admin_view` VALUES ('5930', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813827', 'N');
INSERT INTO `kv_admin_view` VALUES ('5931', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813830', 'N');
INSERT INTO `kv_admin_view` VALUES ('5932', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813847', 'N');
INSERT INTO `kv_admin_view` VALUES ('5933', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813851', 'N');
INSERT INTO `kv_admin_view` VALUES ('5934', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"100\",\"note\":\"\\u7ea2\\u5229\\u6dfb\\u52a0\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813870', 'N');
INSERT INTO `kv_admin_view` VALUES ('5935', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813872', 'N');
INSERT INTO `kv_admin_view` VALUES ('5936', 'http://admin.game.com/user-list.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813899', 'N');
INSERT INTO `kv_admin_view` VALUES ('5937', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813900', 'N');
INSERT INTO `kv_admin_view` VALUES ('5938', 'http://admin.game.com/ajax/user-list.html?action=group', '{\"post\":[],\"get\":{\"action\":\"group\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442813900', 'N');
INSERT INTO `kv_admin_view` VALUES ('5939', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813968', 'N');
INSERT INTO `kv_admin_view` VALUES ('5940', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442813971', 'N');
INSERT INTO `kv_admin_view` VALUES ('5941', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"10\",\"note\":\"\\u6d4b\\u8bd5\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814010', 'N');
INSERT INTO `kv_admin_view` VALUES ('5942', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814011', 'N');
INSERT INTO `kv_admin_view` VALUES ('5943', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814018', 'N');
INSERT INTO `kv_admin_view` VALUES ('5944', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"-10\",\"note\":\"\\u7ee7\\u7eed\\u6d4b\\u8bd5\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814055', 'N');
INSERT INTO `kv_admin_view` VALUES ('5945', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814056', 'N');
INSERT INTO `kv_admin_view` VALUES ('5946', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814062', 'N');
INSERT INTO `kv_admin_view` VALUES ('5947', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"-10000\",\"note\":\"\\u6d4b\\u8bd5\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814076', 'N');
INSERT INTO `kv_admin_view` VALUES ('5948', 'http://admin.game.com/ajax/opmoney.html', '{\"post\":{\"action\":\"undo\",\"uid\":\"9\",\"money\":\"-10000\",\"note\":\"\\u6d4b\\u8bd5\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814079', 'N');
INSERT INTO `kv_admin_view` VALUES ('5949', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814083', 'N');
INSERT INTO `kv_admin_view` VALUES ('5950', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814085', 'N');
INSERT INTO `kv_admin_view` VALUES ('5951', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814101', 'N');
INSERT INTO `kv_admin_view` VALUES ('5952', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814103', 'N');
INSERT INTO `kv_admin_view` VALUES ('5953', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"3\",\"status\":\"0\",\"operator\":\"\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814116', 'N');
INSERT INTO `kv_admin_view` VALUES ('5954', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"3\",\"status\":\"0\",\"operator\":\"kevin\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814197', 'N');
INSERT INTO `kv_admin_view` VALUES ('5955', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"0\",\"operator\":\"kevin\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814200', 'N');
INSERT INTO `kv_admin_view` VALUES ('5956', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"username\":\"\",\"begin\":\"\",\"end\":\"\",\"groupid\":\"0\",\"type\":\"0\",\"status\":\"0\",\"operator\":\"admin\",\"min_money\":\"\",\"max_money\":\"\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442814204', 'N');
INSERT INTO `kv_admin_view` VALUES ('5957', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442816275', 'N');
INSERT INTO `kv_admin_view` VALUES ('5958', 'http://admin.game.com/user-group.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816279', 'N');
INSERT INTO `kv_admin_view` VALUES ('5959', 'http://admin.game.com/ajax/user-group.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816280', 'N');
INSERT INTO `kv_admin_view` VALUES ('5960', 'http://admin.game.com/user-banktype.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816283', 'N');
INSERT INTO `kv_admin_view` VALUES ('5961', 'http://admin.game.com/ajax/user-banktype.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816284', 'N');
INSERT INTO `kv_admin_view` VALUES ('5962', 'http://admin.game.com/user-bank.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816303', 'N');
INSERT INTO `kv_admin_view` VALUES ('5963', 'http://admin.game.com/ajax/user-bank.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816304', 'N');
INSERT INTO `kv_admin_view` VALUES ('5964', 'http://admin.game.com/ajax/user-bank.html?action=type', '{\"post\":[],\"get\":{\"action\":\"type\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442816304', 'N');
INSERT INTO `kv_admin_view` VALUES ('5965', 'http://admin.game.com/money-note.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816307', 'N');
INSERT INTO `kv_admin_view` VALUES ('5966', 'http://admin.game.com/ajax/money-note.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816309', 'N');
INSERT INTO `kv_admin_view` VALUES ('5967', 'http://admin.game.com/money-bank.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816312', 'N');
INSERT INTO `kv_admin_view` VALUES ('5968', 'http://admin.game.com/ajax/money-bank.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816314', 'N');
INSERT INTO `kv_admin_view` VALUES ('5969', 'http://admin.game.com/ajax/money-bank.html?action=group', '{\"post\":[],\"get\":{\"action\":\"group\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442816314', 'N');
INSERT INTO `kv_admin_view` VALUES ('5970', 'http://admin.game.com/money-third.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816316', 'N');
INSERT INTO `kv_admin_view` VALUES ('5971', 'http://admin.game.com/ajax/money-third.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816317', 'N');
INSERT INTO `kv_admin_view` VALUES ('5972', 'http://admin.game.com/extend-rebate.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816333', 'N');
INSERT INTO `kv_admin_view` VALUES ('5973', 'http://admin.game.com/extend-rebate.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442816337', 'N');
INSERT INTO `kv_admin_view` VALUES ('5974', 'http://admin.game.com/user-list.html', '{\"post\":[],\"get\":[]}', '2', '1', 'admin', '1', '127.0.0.1', '1442822454', 'N');
INSERT INTO `kv_admin_view` VALUES ('5975', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442823640', 'N');
INSERT INTO `kv_admin_view` VALUES ('5976', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442823663', 'N');
INSERT INTO `kv_admin_view` VALUES ('5977', 'http://admin.game.com/?op_agent_id=2', '{\"post\":[],\"get\":{\"op_agent_id\":\"2\"}}', '2', '1', 'admin', '1', '127.0.0.1', '1442823672', 'N');
INSERT INTO `kv_admin_view` VALUES ('5978', 'http://admin.game.com/', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443594349', 'N');
INSERT INTO `kv_admin_view` VALUES ('5979', 'http://admin.game.com/user-list.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443595053', 'N');
INSERT INTO `kv_admin_view` VALUES ('5980', 'http://admin.game.com/ajax/user-list.html?action=group', '{\"post\":[],\"get\":{\"action\":\"group\"}}', '1', '1', 'admin', '1', '127.0.0.1', '1443595055', 'N');
INSERT INTO `kv_admin_view` VALUES ('5981', 'http://admin.game.com/ajax/user-list.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443595055', 'N');
INSERT INTO `kv_admin_view` VALUES ('5982', 'http://admin.game.com/user-group.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443595060', 'N');
INSERT INTO `kv_admin_view` VALUES ('5983', 'http://admin.game.com/ajax/user-group.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443595062', 'N');
INSERT INTO `kv_admin_view` VALUES ('5984', 'http://admin.game.com/user-group.html', '{\"post\":[],\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443601992', 'N');
INSERT INTO `kv_admin_view` VALUES ('5985', 'http://admin.game.com/ajax/user-group.html', '{\"post\":{\"action\":\"all\",\"page\":\"1\",\"rows\":\"20\"},\"get\":[]}', '1', '1', 'admin', '1', '127.0.0.1', '1443601994', 'N');

-- ----------------------------
-- Table structure for `kv_agent`
-- ----------------------------
DROP TABLE IF EXISTS `kv_agent`;
CREATE TABLE `kv_agent` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '代理uid,对应登录id',
  `username` varchar(32) NOT NULL COMMENT '代理帐号,对应登录帐号',
  `code` varchar(3) NOT NULL COMMENT '代理编码，用于注册前缀',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(30) DEFAULT NULL COMMENT '手机',
  `game_type` varchar(120) DEFAULT NULL COMMENT '开启的游戏用,分割',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '状态,Y启用，N禁用',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_agent
-- ----------------------------
INSERT INTO `kv_agent` VALUES ('1', '1', 'admin', '', null, null, null, 'Y', '0', 'N');
INSERT INTO `kv_agent` VALUES ('2', '5', 'kevin1', 'kv1', '123@163.com', '13410001000', 'HQ,AG,BBIN,HG,', 'Y', '1434782869', 'N');
INSERT INTO `kv_agent` VALUES ('3', '6', 'kevin2', 'kv2', '1234@163.com', '13410001002', 'HQ,AG,', 'Y', '1434782933', 'N');
INSERT INTO `kv_agent` VALUES ('4', '7', 'kevin3', 'kv3', '123@163.com', '13410001000', 'HQ,AG,', 'Y', '1434782955', 'N');
INSERT INTO `kv_agent` VALUES ('5', '11', 'kevin4', 'kv4', '1234@163.com', '13410001004', 'AG,PT,', 'Y', '1438853813', 'N');

-- ----------------------------
-- Table structure for `kv_agent_extend`
-- ----------------------------
DROP TABLE IF EXISTS `kv_agent_extend`;
CREATE TABLE `kv_agent_extend` (
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `game_type` varchar(20) NOT NULL COMMENT '游戏类型',
  `max` float(4,2) NOT NULL COMMENT '最大返水',
  `min` float(4,2) NOT NULL COMMENT '最小返水',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，此无效。',
  PRIMARY KEY (`agent_id`,`game_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理返水设置';

-- ----------------------------
-- Records of kv_agent_extend
-- ----------------------------
INSERT INTO `kv_agent_extend` VALUES ('2', 'AG', '5.00', '0.00', 'N');
INSERT INTO `kv_agent_extend` VALUES ('2', 'BBIN', '5.00', '0.00', 'N');
INSERT INTO `kv_agent_extend` VALUES ('2', 'HG', '5.00', '0.00', 'N');
INSERT INTO `kv_agent_extend` VALUES ('2', 'HQ', '5.00', '0.00', 'N');

-- ----------------------------
-- Table structure for `kv_agent_host`
-- ----------------------------
DROP TABLE IF EXISTS `kv_agent_host`;
CREATE TABLE `kv_agent_host` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `web_host` varchar(100) NOT NULL COMMENT '网站域名',
  `title` varchar(100) NOT NULL COMMENT '网站名称',
  `logo` varchar(100) DEFAULT NULL COMMENT '网站logo地址',
  `version_id` mediumint(6) NOT NULL COMMENT '模版文件编号',
  `isadmin` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是后台管理域名',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_agent_host
-- ----------------------------
INSERT INTO `kv_agent_host` VALUES ('1', '1', 'admin.game.com', 'Game', '', '1', 'Y', '0', 'N');
INSERT INTO `kv_agent_host` VALUES ('2', '2', 'admin.k1000.com', 'k1000', '/data/logo/20150624/094200_8128.png', '1', 'Y', '1435111829', 'N');
INSERT INTO `kv_agent_host` VALUES ('3', '2', 'www.k1000.com', 'k1000', '/data/logo/20150624/094200_8128.png', '2', 'N', '1435111834', 'N');
INSERT INTO `kv_agent_host` VALUES ('4', '3', 'admin.k2000.com', 'k2000', '/data/logo/20150722/124423_8801.png', '1', 'Y', '1437540268', 'N');
INSERT INTO `kv_agent_host` VALUES ('5', '3', 'www.k2000.com', 'k2000', '/data/logo/20150722/124502_5451.png', '4', 'N', '1437540309', 'N');
INSERT INTO `kv_agent_host` VALUES ('6', '4', 'admin.k3000.com', 'k3000', '/data/logo/20150722/125012_6559.png', '1', 'Y', '1437540625', 'N');
INSERT INTO `kv_agent_host` VALUES ('7', '4', 'www.k3000.com', 'k3000', '/data/logo/20150722/125041_6374.png', '4', 'N', '1437540645', 'N');
INSERT INTO `kv_agent_host` VALUES ('8', '1', 'admin.game.www', 'Game', null, '1', 'Y', '0', 'N');

-- ----------------------------
-- Table structure for `kv_agent_host_more`
-- ----------------------------
DROP TABLE IF EXISTS `kv_agent_host_more`;
CREATE TABLE `kv_agent_host_more` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `web_host` varchar(100) NOT NULL COMMENT '网站域名',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '状态，Y启用，N禁用',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='网站域名分站';

-- ----------------------------
-- Records of kv_agent_host_more
-- ----------------------------
INSERT INTO `kv_agent_host_more` VALUES ('11', '2', 'w11.k1000.com', 'Y', '1439281286', 'N');
INSERT INTO `kv_agent_host_more` VALUES ('12', '2', 'w22.k1000.com', 'Y', '1439964032', 'N');

-- ----------------------------
-- Table structure for `kv_agent_version`
-- ----------------------------
DROP TABLE IF EXISTS `kv_agent_version`;
CREATE TABLE `kv_agent_version` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `version` varchar(30) NOT NULL COMMENT '网站版本',
  `isadmin` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是后台页面',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_agent_version
-- ----------------------------
INSERT INTO `kv_agent_version` VALUES ('1', '20150712.01', 'Y', 'N');
INSERT INTO `kv_agent_version` VALUES ('2', '20150812.01', 'N', 'N');
INSERT INTO `kv_agent_version` VALUES ('3', '20150810.01', 'N', 'N');
INSERT INTO `kv_agent_version` VALUES ('4', '20150810.02', 'N', 'N');

-- ----------------------------
-- Table structure for `kv_game_type`
-- ----------------------------
DROP TABLE IF EXISTS `kv_game_type`;
CREATE TABLE `kv_game_type` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT COMMENT '游戏id',
  `name` varchar(50) NOT NULL COMMENT '游戏名称',
  `code` varchar(10) NOT NULL COMMENT '游戏识别码',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '状态,Y启用，N禁用',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='游戏类型';

-- ----------------------------
-- Records of kv_game_type
-- ----------------------------
INSERT INTO `kv_game_type` VALUES ('1', '环球', 'HQ', 'Y', 'N');
INSERT INTO `kv_game_type` VALUES ('2', 'AG', 'AG', 'Y', 'N');
INSERT INTO `kv_game_type` VALUES ('3', '波音', 'BBIN', 'Y', 'N');
INSERT INTO `kv_game_type` VALUES ('4', '沙巴', 'SB', 'Y', 'N');
INSERT INTO `kv_game_type` VALUES ('5', 'HG', 'HG', 'Y', 'N');
INSERT INTO `kv_game_type` VALUES ('6', 'PT小游戏', 'PT', 'Y', 'N');
INSERT INTO `kv_game_type` VALUES ('7', '祥瑞彩', 'XR', 'Y', 'N');

-- ----------------------------
-- Table structure for `kv_message_notice`
-- ----------------------------
DROP TABLE IF EXISTS `kv_message_notice`;
CREATE TABLE `kv_message_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `type` tinyint(3) NOT NULL COMMENT '类型',
  `username` varchar(40) NOT NULL COMMENT '操作人',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='信息表';

-- ----------------------------
-- Records of kv_message_notice
-- ----------------------------
INSERT INTO `kv_message_notice` VALUES ('1', '2', null, '测试滚动信息1', '1', 'admin', '1440056172', 'N');
INSERT INTO `kv_message_notice` VALUES ('2', '2', null, '测试滚动信息2', '1', 'admin', '1440056209', 'N');
INSERT INTO `kv_message_notice` VALUES ('3', '2', null, '测试滚动信息3', '1', 'admin', '1440056236', 'N');
INSERT INTO `kv_message_notice` VALUES ('4', '2', null, '这是一个个人中心测试公告1', '2', 'admin', '1440057193', 'N');
INSERT INTO `kv_message_notice` VALUES ('5', '2', null, '这是一个个人中心测试公告2', '2', 'admin', '1440057203', 'N');

-- ----------------------------
-- Table structure for `kv_message_type`
-- ----------------------------
DROP TABLE IF EXISTS `kv_message_type`;
CREATE TABLE `kv_message_type` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '说明',
  `content` text NOT NULL COMMENT '信息内容',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y是，否N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='信息设置';

-- ----------------------------
-- Records of kv_message_type
-- ----------------------------
INSERT INTO `kv_message_type` VALUES ('1', '短信验证', '尊敬的会员，您的验证码是：[code]，请不要把验证码泄露给其他人。如非本人操作，请忽略此信息，由此带来的不便请您谅解。', '1441430042', 'N');
INSERT INTO `kv_message_type` VALUES ('2', '存款到账', '尊敬的会员，您于[date]采用[pay]提交的存款申请，金额[money]元，已经成功为您充值到您的账户中。', '1441430362', 'N');
INSERT INTO `kv_message_type` VALUES ('3', '存款拒绝', '尊敬的会员，您于[date]提交的存款单，金额[money]元，被拒绝，原因为：[reson]，有任何疑问请随时致电或联系在线客服。', '1441438962', 'N');
INSERT INTO `kv_message_type` VALUES ('4', '取款到账', '尊敬的会员，您于[date]提交的取款单，金额[money]元，已经为您办理完毕，请您注意查收。', '1441430411', 'N');
INSERT INTO `kv_message_type` VALUES ('5', '取款拒绝', '尊敬的会员，您于[date]提交的取款单，金额[money]元，被拒绝，原因为：[reson]，有任何疑问请随时致电或联系在线客服。', '1441430964', 'N');
INSERT INTO `kv_message_type` VALUES ('6', '登录密码更改', '尊敬的会员，您于[date]更改了您的登录密码，如果不是您本人操作，请及时联系我们，以确保您的账号安全。', '1441431010', 'N');
INSERT INTO `kv_message_type` VALUES ('7', '取款密码更改', '尊敬的会员，您于[date]更改了您的取款密码，如果不是您本人操作，请及时联系我们，以确保您的账号安全。', '1441431029', 'N');
INSERT INTO `kv_message_type` VALUES ('8', '登录密码找回', '尊敬的会员，您的临时密码为[password]，请登录后更改您的新密码。如非本人操作，请忽略此信息，由此带来的不便请您谅解。', '1441431133', 'N');
INSERT INTO `kv_message_type` VALUES ('9', '银行转账手续费', '尊敬的会员，您的账户于[date]获得银行转账手续费，金额[money]元，有任何疑问请随时致电或联系在线客服。', '1441441557', 'N');
INSERT INTO `kv_message_type` VALUES ('10', '冲正负', '尊敬的会员，您的账户于[date]冲正负，金额[money]元，原因为：[reson]，有任何疑问请随时致电或联系在线客服。', '1441441811', 'N');
INSERT INTO `kv_message_type` VALUES ('11', '首存红利', '尊敬的会员，我们已经为您发放[money]元首存红利到您的帐户中。', '1441441914', 'N');
INSERT INTO `kv_message_type` VALUES ('12', '会员升级', '尊敬的会员，恭喜您升级到[vip]，感谢您的支持！', '1441441989', 'N');
INSERT INTO `kv_message_type` VALUES ('13', '洗码发放', '尊敬的会员，您获得礼金，金额为【cash】元。祝您游戏愉快。', '1441442123', 'N');

-- ----------------------------
-- Table structure for `kv_money_bank`
-- ----------------------------
DROP TABLE IF EXISTS `kv_money_bank`;
CREATE TABLE `kv_money_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '银行id',
  `agent_id` int(10) NOT NULL COMMENT '代理id',
  `name` varchar(50) NOT NULL COMMENT '银行名称',
  `intro` varchar(50) DEFAULT NULL COMMENT '说明',
  `card` varchar(50) NOT NULL COMMENT '卡号',
  `truname` varchar(30) NOT NULL COMMENT '银行卡姓名',
  `address` varchar(100) NOT NULL COMMENT '开户行地址',
  `group_id` tinyint(2) DEFAULT '0' COMMENT '会员级别',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '是否启用Y启用,N禁用',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y是，N否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='银行列表';

-- ----------------------------
-- Records of kv_money_bank
-- ----------------------------
INSERT INTO `kv_money_bank` VALUES ('1', '2', '工商银行', '实时到账', '420020020036134', '张三', '北京朝阳支行', '1', 'Y', 'N');
INSERT INTO `kv_money_bank` VALUES ('2', '2', '招商银行', '30分钟到账', '420020020036131', '李四', '上海虹口支行', '1', 'Y', 'N');
INSERT INTO `kv_money_bank` VALUES ('3', '2', '工商银行', '实时到帐', '420020020036133', '王五', '北京朝阳支行', '2', 'Y', 'N');

-- ----------------------------
-- Table structure for `kv_money_log`
-- ----------------------------
DROP TABLE IF EXISTS `kv_money_log`;
CREATE TABLE `kv_money_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(32) NOT NULL COMMENT '订单编号',
  `agent_id` int(11) NOT NULL COMMENT '代理id',
  `money` float(10,2) NOT NULL COMMENT '金额',
  `type` varchar(50) NOT NULL COMMENT '操作类型',
  `uid` mediumint(10) DEFAULT NULL COMMENT '用户id',
  `opuid` mediumint(10) NOT NULL COMMENT '操作人id',
  `addtime` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_money_log
-- ----------------------------
INSERT INTO `kv_money_log` VALUES ('6', 'bankbndmuh5k89bidtl7', '2', '123.00', '审核通过', '9', '1', '1442127606');
INSERT INTO `kv_money_log` VALUES ('7', 'bankbndmuh5k89bidtl7', '2', '123.00', '资金确认', '9', '1', '1442127615');
INSERT INTO `kv_money_log` VALUES ('8', 'firstbonusda166912sg', '2', '36.90', '资金确认', '9', '1', '1442127754');
INSERT INTO `kv_money_log` VALUES ('9', 'mp7cel8dcn0206ewv856', '2', '190.00', '审核通过', '9', '1', '1442127867');
INSERT INTO `kv_money_log` VALUES ('10', 'mp7cel8dcn0206ewv856', '2', '190.00', '资金拒绝', '9', '1', '1442127888');
INSERT INTO `kv_money_log` VALUES ('11', 'undo7e9a6c4mf1158gz9', '2', '100.00', '冲正负', '9', '1', '1442813870');
INSERT INTO `kv_money_log` VALUES ('12', 'undob885234kfc180xb9', '2', '10.00', '冲正负', '9', '1', '1442814010');
INSERT INTO `kv_money_log` VALUES ('13', 'undoxvb6b538459hdd16', '2', '-10.00', '冲正负', '9', '1', '1442814056');

-- ----------------------------
-- Table structure for `kv_money_note`
-- ----------------------------
DROP TABLE IF EXISTS `kv_money_note`;
CREATE TABLE `kv_money_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `orderid` varchar(32) NOT NULL COMMENT '订单编号',
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '资金金额',
  `money_type` smallint(4) NOT NULL COMMENT '资金类型,见表money_type',
  `bank` varchar(50) DEFAULT NULL COMMENT '收款银行',
  `note` text COMMENT '内容',
  `paymd5` varchar(32) DEFAULT NULL COMMENT '支付md5',
  `status` tinyint(2) NOT NULL DEFAULT '3' COMMENT '资金状态1完成，2拒绝，3处理中，4审核',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `opnote` text COMMENT '操作详细记录',
  `del` char(1) DEFAULT 'N' COMMENT '是否已删除，Y是，N否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='资金记录';

-- ----------------------------
-- Records of kv_money_note
-- ----------------------------
INSERT INTO `kv_money_note` VALUES ('1', '2', 'mp7cel8dcn0206ewv856', '9', '190.00', '2', '工商银行(420020020036134)', '工商银行,北京朝阳支行,网银转账,张三,1234<br/>这是一个测试', null, '2', '1441608479', '2015-09-13 15:04:27 admin 通过审核<br/>2015-09-13 15:04:48 admin 资金拒绝<br/>原因:电话无法打通,', 'N');
INSERT INTO `kv_money_note` VALUES ('2', '2', 'yee49885wf694ac460t3', '9', '100.00', '7', '易宝支付-ABC', '在线支付-ABC', 'a750a29fa9b35847a65847768ef871dc', '3', '1441615337', null, 'N');
INSERT INTO `kv_money_note` VALUES ('3', '2', 'yeebz51zade82077rdfm', '9', '100.00', '7', '易宝支付-ABC', '在线支付-ABC', '82f0ba2ead6026a31a7ed417fc53007f', '3', '1441615342', null, 'N');
INSERT INTO `kv_money_note` VALUES ('4', '2', 'yeeg56122edfy5ch50e1', '9', '100.00', '7', '易宝支付-ABC', '在线支付-ABC', '810971dce6ff82501466bdc8985e2ec8', '3', '1441615348', null, 'N');
INSERT INTO `kv_money_note` VALUES ('5', '2', 'yeecuf0zll1qd1d1v6e0', '9', '100.00', '7', '易宝支付', '在线支付-ABC', '749cacb9f3169ed95a5f30860dcb0859', '3', '1441871579', null, 'N');
INSERT INTO `kv_money_note` VALUES ('6', '2', 'bankbndmuh5k89bidtl7', '9', '123.00', '2', '工商银行(420020020036134)', '工商银行,北京朝阳支行,柜台转账<br/>测试,1234<br/>', '', '1', '1441871609', '2015-09-13 15:00:06 admin 通过审核<br/>2015-09-13 15:00:15 admin 资金接受', 'N');
INSERT INTO `kv_money_note` VALUES ('9', '2', 'firstbonusda166912sg', '9', '36.90', '5', '首存红利', '首存18倍流水', null, '1', '1442127616', '2015-09-13 15:02:34 admin 资金接受', 'N');
INSERT INTO `kv_money_note` VALUES ('10', '2', 'bankbonusyf1rg5b80c1', '9', '2.46', '6', '转账手续费', '转账手续费', null, '1', '1442127616', '2015-09-13 15:00:16 银行转账手续费，系统添加', 'N');
INSERT INTO `kv_money_note` VALUES ('12', '2', 'undob885234kfc180xb9', '9', '10.00', '3', '冲正负', '冲正负', null, '1', '1442814010', 'admin操作冲正负,<br/>说明:测试', 'N');
INSERT INTO `kv_money_note` VALUES ('13', '2', 'undoxvb6b538459hdd16', '9', '-10.00', '3', '冲正负', '冲正负', null, '1', '1442814056', 'admin操作冲正负,<br/>说明:继续测试', 'N');

-- ----------------------------
-- Table structure for `kv_money_status`
-- ----------------------------
DROP TABLE IF EXISTS `kv_money_status`;
CREATE TABLE `kv_money_status` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '资金状态',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y是，N否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='资金状态';

-- ----------------------------
-- Records of kv_money_status
-- ----------------------------
INSERT INTO `kv_money_status` VALUES ('1', '已完成', 'N');
INSERT INTO `kv_money_status` VALUES ('2', '已拒绝', 'N');
INSERT INTO `kv_money_status` VALUES ('3', '处理中', 'N');
INSERT INTO `kv_money_status` VALUES ('4', '审核中', 'N');
INSERT INTO `kv_money_status` VALUES ('5', '确认中', 'N');
INSERT INTO `kv_money_status` VALUES ('6', '已过期', 'N');

-- ----------------------------
-- Table structure for `kv_money_third`
-- ----------------------------
DROP TABLE IF EXISTS `kv_money_third`;
CREATE TABLE `kv_money_third` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `type` smallint(2) NOT NULL COMMENT '支付类型',
  `username` varchar(100) NOT NULL COMMENT '帐号',
  `code` varchar(100) NOT NULL COMMENT '商户号',
  `pass` varchar(100) NOT NULL COMMENT '密码',
  `skey` text NOT NULL COMMENT '密钥',
  `money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '总金额',
  `url` varchar(100) NOT NULL COMMENT '绑定的支付域名',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '状态,Y启用，N禁用',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_money_third
-- ----------------------------
INSERT INTO `kv_money_third` VALUES ('1', '2', '1', 'test1@gmail.com', '10001000100', '99999999', '2tfqtctkjocu6h55zx9i7bgdp71qviurvf2p1jm0jmewt5v2o259b6azko7k', '0.00', 'pay1.pay1000.com', 'Y', 'N');
INSERT INTO `kv_money_third` VALUES ('2', '2', '1', 'test2@gmail.com', '10001000101', '88888888', '2tfqtctkjocu6h55zx9i7bgdp71qviurvf2p1jm0jmewt5v2o259b6azko7k', '0.00', 'pay2.pay1000.com', 'Y', 'N');

-- ----------------------------
-- Table structure for `kv_money_type`
-- ----------------------------
DROP TABLE IF EXISTS `kv_money_type`;
CREATE TABLE `kv_money_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '资金类型',
  `isbonus` char(1) NOT NULL DEFAULT 'Y' COMMENT '是否有红利反水Y是，N否',
  `isexam` char(1) NOT NULL DEFAULT 'N' COMMENT '是否需要审核,N不需要，Y需要',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y是，否N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='资金类型表';

-- ----------------------------
-- Records of kv_money_type
-- ----------------------------
INSERT INTO `kv_money_type` VALUES ('1', '取款', 'N', 'Y', 'N');
INSERT INTO `kv_money_type` VALUES ('2', '银行转账', 'Y', 'Y', 'N');
INSERT INTO `kv_money_type` VALUES ('3', '冲正负', 'N', 'Y', 'N');
INSERT INTO `kv_money_type` VALUES ('4', '首存', 'N', 'Y', 'N');
INSERT INTO `kv_money_type` VALUES ('5', '首存红利', 'N', 'Y', 'N');
INSERT INTO `kv_money_type` VALUES ('6', '银行转账手续费', 'Y', 'Y', 'N');
INSERT INTO `kv_money_type` VALUES ('7', '易宝支付', 'Y', 'N', 'N');
INSERT INTO `kv_money_type` VALUES ('8', '宝付支付', 'Y', 'N', 'N');

-- ----------------------------
-- Table structure for `kv_only_no`
-- ----------------------------
DROP TABLE IF EXISTS `kv_only_no`;
CREATE TABLE `kv_only_no` (
  `no` varchar(50) NOT NULL,
  `del` char(1) DEFAULT 'N',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_only_no
-- ----------------------------
INSERT INTO `kv_only_no` VALUES ('bankbndmuh5k89bidtl7', 'N');
INSERT INTO `kv_only_no` VALUES ('mp7cel8dcn0206ewv856', 'N');
INSERT INTO `kv_only_no` VALUES ('yee49885wf694ac460t3', 'N');
INSERT INTO `kv_only_no` VALUES ('yeebz51zade82077rdfm', 'N');
INSERT INTO `kv_only_no` VALUES ('yeecuf0zll1qd1d1v6e0', 'N');
INSERT INTO `kv_only_no` VALUES ('yeeg56122edfy5ch50e1', 'N');

-- ----------------------------
-- Table structure for `kv_session`
-- ----------------------------
DROP TABLE IF EXISTS `kv_session`;
CREATE TABLE `kv_session` (
  `token` varchar(40) NOT NULL,
  `session` text NOT NULL COMMENT 'session',
  `ip` varchar(30) NOT NULL COMMENT 'ip',
  `isadmin` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是后台session, N不是，Y是，默认N',
  `host` varchar(200) NOT NULL COMMENT '域名',
  `updatetime` int(11) NOT NULL COMMENT '最后修改时间',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_session
-- ----------------------------
INSERT INTO `kv_session` VALUES ('a14f184c850cf3265a71702a4b842883', '{\"user\":{\"id\":\"1\",\"username\":\"admin\",\"agent_id\":\"1\",\"group_id\":\"1\",\"maxmoney\":\"10000000.00\",\"operatemoney\":\"120.00\",\"operatettime\":\"1442814056\",\"logintime\":\"1442811846\",\"errorcount\":\"0\",\"errortime\":\"0\",\"status\":\"Y\",\"del\":\"N\"},\"agent\":{\"id\":\"1\",\"uid\":\"1\",\"username\":\"admin\",\"code\":\"\",\"email\":null,\"phone\":null,\"game_type\":null,\"status\":\"Y\",\"addtime\":\"0\",\"del\":\"N\",\"agent_group_id\":\"1\"}}', '127.0.0.1', 'Y', 'admin.game.com', '1443601992', '1443594347', 'N');

-- ----------------------------
-- Table structure for `kv_setting`
-- ----------------------------
DROP TABLE IF EXISTS `kv_setting`;
CREATE TABLE `kv_setting` (
  `skey` varchar(50) NOT NULL COMMENT 'key值',
  `svalue` text NOT NULL COMMENT 'value值',
  `type` varchar(20) NOT NULL COMMENT '类型',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `del` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`skey`,`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of kv_setting
-- ----------------------------
INSERT INTO `kv_setting` VALUES ('api_ag_agent', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_ag_key', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_ag_pass', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_ag_status', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_ag_test', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_ag_url', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_bbin_agent', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_bbin_key', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_bbin_pass', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_bbin_status', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_bbin_test', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_bbin_url', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hg_agent', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hg_key', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hg_pass', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hg_status', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hg_test', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hg_url', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hq_agent', 'abnc', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hq_key', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hq_pass', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hq_status', '1', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hq_test', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('api_hq_url', '', 'api', '2', 'N');
INSERT INTO `kv_setting` VALUES ('ip_admin_whitelist', '127.0.0.1,192.168.66.*,180.232.108.150,121.127.13.226,', 'ip', '1', 'N');
INSERT INTO `kv_setting` VALUES ('ip_admin_whitelist', '127.0.0.*,192.168.*,', 'ip', '2', 'N');
INSERT INTO `kv_setting` VALUES ('ip_web_blacklist', '', 'ip', '1', 'N');
INSERT INTO `kv_setting` VALUES ('ip_web_blacklist', '', 'ip', '2', 'N');
INSERT INTO `kv_setting` VALUES ('ip_web_whitelist', '', 'ip', '1', 'N');
INSERT INTO `kv_setting` VALUES ('ip_web_whitelist', '127.0.0.*,192.168.*,', 'ip', '2', 'N');
INSERT INTO `kv_setting` VALUES ('sale_first', '30', 'sale', '2', 'N');
INSERT INTO `kv_setting` VALUES ('sale_first_money', '8888', 'sale', '2', 'N');
INSERT INTO `kv_setting` VALUES ('sale_times', '18', 'sale', '2', 'N');
INSERT INTO `kv_setting` VALUES ('sale_transfer', '2', 'sale', '2', 'N');
INSERT INTO `kv_setting` VALUES ('sale_transfer_money', '50', 'sale', '2', 'N');
INSERT INTO `kv_setting` VALUES ('server_logo_url', '/', 'server', '0', 'N');
INSERT INTO `kv_setting` VALUES ('server_third_url', '/public/third/', 'server', '0', 'N');
INSERT INTO `kv_setting` VALUES ('web_backup_url1', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_backup_url2', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_backup_url3', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_backup_url4', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_backup_url5', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_backup_url6', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_email', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_email', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_email', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_online', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_online', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_online', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_phone', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_phone', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_phone', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq1', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq1', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq1', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq2', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq2', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq2', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq3', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq3', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_custom_qq3', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_status', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_status', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_status', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url1', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url1', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url1', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url2', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url2', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url2', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url3', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url3', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_extend_url3', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_description', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_description', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_keywords', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_keywords', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_other_title', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_other_title', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_status', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_setting_status', '1', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_bonus', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_bonus', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_bonus', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_deposit', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_deposit', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_deposit', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_draw', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_draw', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_draw', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_password', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_password', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_password', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_register', '0', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_register', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_register', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_sale', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_sale', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_sale', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_url', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_url', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_url', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_username', '', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_username', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_sms_username', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_status', '2', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_activate', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_activate', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_activate', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_ip_time', '99999', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_ip_time', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_ip_time', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_ip_total', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_ip_total', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_ip_total', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_pc_time', '99999', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_pc_time', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_pc_time', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_pc_total', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_pc_total', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_pc_total', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_phone', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_phone', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_phone', '', 'web', '3', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_phone_only', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_phone_only', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_register', '1', 'web', '1', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_register', '', 'web', '2', 'N');
INSERT INTO `kv_setting` VALUES ('web_user_register', '', 'web', '3', 'N');

-- ----------------------------
-- Table structure for `kv_users`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users`;
CREATE TABLE `kv_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '登录帐号',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `money` float(10,2) DEFAULT '0.00' COMMENT '账户余额',
  `group_id` tinyint(2) DEFAULT '0' COMMENT '用户级别',
  `transpassword` varchar(32) DEFAULT NULL COMMENT '取款密码',
  `parentid` int(11) DEFAULT '0' COMMENT '直属父类',
  `parenttree` varchar(300) DEFAULT ',' COMMENT '上级所有父类树，使用逗号分割(,1,2,3,....,n,)',
  `subordinatecount` mediumint(8) DEFAULT '0' COMMENT '直属下级会员个数',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '帐号状态N冻结，Y正常',
  `truname` varchar(20) DEFAULT NULL COMMENT '用户姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `birth` varchar(20) DEFAULT NULL COMMENT '出生日期',
  `sex` varchar(5) DEFAULT NULL COMMENT '性别',
  `registertime` int(11) DEFAULT NULL COMMENT '注册时间',
  `registerip` varchar(20) DEFAULT NULL COMMENT '注册ip',
  `logincount` int(11) DEFAULT '0' COMMENT '登录次数',
  `logintime` int(11) DEFAULT NULL COMMENT '登录时间',
  `loginecount` int(11) DEFAULT '0' COMMENT '登录错误次数',
  `loginetime` int(11) DEFAULT NULL COMMENT '错误时间',
  `firstmoney` float(10,2) DEFAULT '0.00' COMMENT '首存金额',
  `firsttime` int(11) DEFAULT NULL COMMENT '首存时间',
  `rebate` float(10,2) DEFAULT '0.00' COMMENT '返利总金额',
  `rebatetime` int(11) DEFAULT NULL COMMENT '最后返利时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否是删除状态,N未删除,Y已删除',
  PRIMARY KEY (`id`),
  KEY `user_agent_key` (`username`,`agent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of kv_users
-- ----------------------------
INSERT INTO `kv_users` VALUES ('9', 'kevin', 'cb38d9f022528ff7b486e4892e743a1c', '2', '262.36', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '测试', '13410001000', 'kevin@163.com', '2015-09-11', '男', '1439454690', '127.0.0.1', '12', '1441871563', '0', '1442124437', '123.00', '1442127616', '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('10', 'kevin1', '6d2b6ecb82dda37e2660c1c72956845f', '2', '0.00', '2', '81dc9bdb52d04dc20036dbd8313ed055', '0', ',', '0', 'N', '测试2', '13410001001', '', null, null, null, null, '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('11', 'kevin1', '6d2b6ecb82dda37e2660c1c72956845f', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', ',', '0', 'Y', '测试2', '13410001001', '', null, null, null, null, '0', null, '0', null, '0.00', null, '0.00', null, 'Y');
INSERT INTO `kv_users` VALUES ('12', 'kevin1', '6d2b6ecb82dda37e2660c1c72956845f', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', ',', '0', 'Y', '测试2', '13410001001', '', null, null, null, null, '0', null, '0', null, '0.00', null, '0.00', null, 'Y');
INSERT INTO `kv_users` VALUES ('13', 'kevin2', '1bb0c90ea5967d9037d6472a5370af23', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'N', '测试2', '13410001002', null, null, null, '1439529769', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('14', 'kevin3', 'd652b5831cba5961756c51fdec5aec11', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'N', '测试3', '13410001002', null, null, null, '1439533894', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('15', 'kevin4', '21fe46f6ff15b77c590f81e1e2b5b2d0', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'N', '测试4', '13410001002', null, null, null, '1439533906', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('16', 'kevin5', '6c3eb67be6cf43706ff9cec5cdd391a7', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '测试4', '13410001002', '', null, null, '1439534048', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('17', 'kevin6', '934b18e179c98baa969efc2df22fff62', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '测试4', '13410001002', null, null, null, '1439534098', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('18', 'kevin7', '1ff6e211132194cced0df8aeeda52efa', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '张三', '13410001007', null, null, null, '1439952611', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('19', 'kevin8', '02de283cddbfc4508a0cb6be03bdcf0e', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '测试3', '13410001008', null, null, null, '1439958061', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('20', 'kevin9', '4fddae2ae41a3c46c090e4eb9140d436', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '测试3', '13410001009', null, null, null, '1439958123', '127.0.0.1', '4', '1440134307', '0', '1439972311', '0.00', null, '0.00', null, 'N');
INSERT INTO `kv_users` VALUES ('21', 'kevin10', 'd9fe0ec35ab7047b86f7bfc018a898d7', '2', '0.00', '1', '81dc9bdb52d04dc20036dbd8313ed055', '0', '', '0', 'Y', '测试5', '13410001010', null, null, null, '1439958228', '127.0.0.1', '0', null, '0', null, '0.00', null, '0.00', null, 'N');

-- ----------------------------
-- Table structure for `kv_users_bank`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_bank`;
CREATE TABLE `kv_users_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `agent_id` int(10) NOT NULL COMMENT '代理id',
  `banktype_id` mediumint(6) NOT NULL COMMENT '开户银行',
  `card` varchar(30) NOT NULL COMMENT '银行卡号',
  `province` varchar(20) NOT NULL COMMENT '开户省',
  `city` varchar(20) NOT NULL COMMENT '开户城市',
  `address` varchar(50) NOT NULL COMMENT '开户网点',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y是，N否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户开户银行';

-- ----------------------------
-- Records of kv_users_bank
-- ----------------------------
INSERT INTO `kv_users_bank` VALUES ('1', '9', '2', '3', '1234123412341234', '北京', '北京', '国贸支行', 'N');
INSERT INTO `kv_users_bank` VALUES ('2', '9', '2', '1', '123456789123456789', '北京', '北京', '朝阳支行', 'N');

-- ----------------------------
-- Table structure for `kv_users_banktype`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_banktype`;
CREATE TABLE `kv_users_banktype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) NOT NULL COMMENT '代理id',
  `name` varchar(50) NOT NULL COMMENT '银行名称',
  `intro` varchar(50) NOT NULL COMMENT '说明',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y是，N否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会员银行类别';

-- ----------------------------
-- Records of kv_users_banktype
-- ----------------------------
INSERT INTO `kv_users_banktype` VALUES ('1', '2', '工商银行', '实时到账', 'N');
INSERT INTO `kv_users_banktype` VALUES ('2', '2', '交通银行', '30分钟到账', 'N');
INSERT INTO `kv_users_banktype` VALUES ('3', '2', '建设银行', '实时到账', 'N');

-- ----------------------------
-- Table structure for `kv_users_extend`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_extend`;
CREATE TABLE `kv_users_extend` (
  `extend_id` varchar(32) NOT NULL COMMENT '推广编号',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `agent_id` int(11) NOT NULL COMMENT '代理id',
  `bonus` varchar(300) NOT NULL COMMENT '反水比',
  `addtime` int(11) NOT NULL COMMENT '生成时间',
  `del` char(1) DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`extend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推广设置';

-- ----------------------------
-- Records of kv_users_extend
-- ----------------------------

-- ----------------------------
-- Table structure for `kv_users_group`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_group`;
CREATE TABLE `kv_users_group` (
  `id` smallint(3) NOT NULL AUTO_INCREMENT COMMENT '级别id',
  `name` varchar(30) NOT NULL COMMENT '级别名称',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `upmoney` float(10,2) NOT NULL DEFAULT '10000.00' COMMENT '升级金额',
  `rebate` float(6,2) NOT NULL DEFAULT '0.00' COMMENT '返点',
  `mindeposit` float(10,2) NOT NULL DEFAULT '100.00' COMMENT '最小存款',
  `maxdeposit` float(10,2) NOT NULL DEFAULT '10000.00' COMMENT '最大存款金额',
  `mindraw` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '最小取款金额',
  `maxdraw` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '最大取款金额',
  `banknum` smallint(3) NOT NULL DEFAULT '1' COMMENT '可绑定银行卡',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户级别';

-- ----------------------------
-- Records of kv_users_group
-- ----------------------------
INSERT INTO `kv_users_group` VALUES ('1', '一级会员', '2', '1000.00', '0.10', '100.00', '10000.00', '100.00', '10000.00', '1', 'N');
INSERT INTO `kv_users_group` VALUES ('2', '二级会员', '2', '50000.00', '0.20', '100.00', '20000.00', '100.00', '20000.00', '2', 'N');
INSERT INTO `kv_users_group` VALUES ('3', '三级会员', '2', '100000.00', '0.30', '100.00', '30000.00', '100.00', '30000.00', '3', 'N');
INSERT INTO `kv_users_group` VALUES ('4', '四级会员', '2', '200000.00', '0.40', '100.00', '40000.00', '100.00', '40000.00', '4', 'N');
INSERT INTO `kv_users_group` VALUES ('5', '五级会员', '2', '500000.00', '0.50', '100.00', '50000.00', '100.00', '50000.00', '5', 'N');
INSERT INTO `kv_users_group` VALUES ('6', '六级会员', '2', '1000000.00', '0.60', '100.00', '60000.00', '100.00', '60000.00', '6', 'N');
INSERT INTO `kv_users_group` VALUES ('7', '七级会员', '2', '100000000.00', '0.70', '100.00', '70000.00', '100.00', '70000.00', '7', 'N');

-- ----------------------------
-- Table structure for `kv_users_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_login_log`;
CREATE TABLE `kv_users_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '登录的用户id',
  `agent_id` int(11) NOT NULL COMMENT '代理id',
  `ip` varchar(40) NOT NULL COMMENT '登录ip',
  `logintime` int(11) NOT NULL COMMENT '登录时间',
  `del` char(1) NOT NULL DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录记录';

-- ----------------------------
-- Records of kv_users_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for `kv_users_same_ip`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_same_ip`;
CREATE TABLE `kv_users_same_ip` (
  `ip` varchar(40) NOT NULL COMMENT 'ip',
  `agent_id` int(11) NOT NULL COMMENT '代理id',
  `username` varchar(300) NOT NULL,
  `lasttime` int(11) NOT NULL COMMENT '最后记录时间',
  `del` char(1) DEFAULT 'N',
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户同ip';

-- ----------------------------
-- Records of kv_users_same_ip
-- ----------------------------
INSERT INTO `kv_users_same_ip` VALUES ('127.0.0.1', '2', 'kevin3,kevin4,kevin5,kevin6,kevin7,kevin8,kevin9,kevin10,', '1439958228', 'N');

-- ----------------------------
-- Table structure for `kv_users_same_pc`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_same_pc`;
CREATE TABLE `kv_users_same_pc` (
  `no` varchar(40) NOT NULL,
  `agent_id` int(11) NOT NULL COMMENT '代理id',
  `username` varchar(300) NOT NULL,
  `lasttime` int(11) NOT NULL COMMENT '最后记录时间',
  `del` char(255) DEFAULT 'N',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户同电脑';

-- ----------------------------
-- Records of kv_users_same_pc
-- ----------------------------
INSERT INTO `kv_users_same_pc` VALUES ('2ce9f1b15a11e6af95249325cf0289f8', '2', 'kevin3,kevin4,kevin5,kevin6,', '1439534098', 'N');
INSERT INTO `kv_users_same_pc` VALUES ('a9e83c3f1f5fccce0106f8a8e1ab7426', '2', 'kevin10,', '1439958228', 'N');

-- ----------------------------
-- Table structure for `kv_users_view`
-- ----------------------------
DROP TABLE IF EXISTS `kv_users_view`;
CREATE TABLE `kv_users_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL COMMENT '访问url',
  `agent_id` mediumint(10) NOT NULL COMMENT '代理id',
  `username` varchar(30) DEFAULT NULL COMMENT '操作人',
  `uid` int(11) DEFAULT '0',
  `ip` varchar(40) NOT NULL COMMENT 'ip地址',
  `addtime` int(11) NOT NULL COMMENT '操作时间',
  `del` char(1) DEFAULT 'N' COMMENT '是否已删除，Y已删除，N未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of kv_users_view
-- ----------------------------
