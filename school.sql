/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : school

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-12-27 21:50:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cx_admin`
-- ----------------------------
DROP TABLE IF EXISTS `cx_admin`;
CREATE TABLE `cx_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` tinyint(4) DEFAULT '0' COMMENT '权限组id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '0.0.0.0' COMMENT '最后登录ip',
  `admin_name` varchar(15) NOT NULL COMMENT '管理员登录账号',
  `admin_password` varchar(32) NOT NULL COMMENT '管理员登录密码',
  `status` tinyint(1) DEFAULT '1' COMMENT '账号状态',
  `add_time` varchar(13) NOT NULL COMMENT '添加时间',
  `last_login_time` varchar(13) DEFAULT NULL COMMENT '最后登录时间',
  `login_times` int(11) DEFAULT '0' COMMENT '登录次数',
  `is_supper` tinyint(1) DEFAULT '0' COMMENT '是否超级管理员',
  `admin_avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `phone` varchar(200) DEFAULT NULL,
  `class` int(11) DEFAULT NULL COMMENT '班级id',
  `grade` int(11) DEFAULT NULL COMMENT '年级id',
  `department_ids` text COMMENT '部门主管id（可以是多个）',
  PRIMARY KEY (`admin_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员表';

-- ----------------------------
-- Records of cx_admin
-- ----------------------------
INSERT INTO `cx_admin` VALUES ('1', '1', '127.0.0.1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '', '1514378639', '218', '1', 'http://img.51chuanxing.com/Uploads/User/2016/10/18/2016-10-18/5805fd6195bfd.jpg', null, null, null, '1,2');
INSERT INTO `cx_admin` VALUES ('3', '2', '127.0.0.1', 's1', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513841734', '1514378604', '2', '0', '', null, '2', '6', null);
INSERT INTO `cx_admin` VALUES ('5', '2', '0.0.0.0', 's2', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513842141', null, '0', '0', '', null, '2', '8', null);
INSERT INTO `cx_admin` VALUES ('7', '7', '127.0.0.1', 's3', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513848140', '1514374161', '1', '0', '', '15507966528', null, '8', '1,2');
INSERT INTO `cx_admin` VALUES ('8', '7', '0.0.0.0', 's4', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513848403', null, '0', '0', '', '15507963171', null, '9', null);
INSERT INTO `cx_admin` VALUES ('9', '7', '0.0.0.0', 's5', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513848403', null, '0', '0', '', '15507966528', null, '8', null);
INSERT INTO `cx_admin` VALUES ('10', '7', '0.0.0.0', 's6', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513848600', null, '0', '0', '', '15507963171', null, '9', null);
INSERT INTO `cx_admin` VALUES ('11', '7', '0.0.0.0', 's7', 'e10adc3949ba59abbe56e057f20f883e', '1', '1513848600', null, '0', '0', '', '15507966528', null, '8', null);

-- ----------------------------
-- Table structure for `cx_admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `cx_admin_role`;
CREATE TABLE `cx_admin_role` (
  `role_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL COMMENT '权限组名',
  `sort` tinyint(3) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:是 1:否)',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色表';

-- ----------------------------
-- Records of cx_admin_role
-- ----------------------------
INSERT INTO `cx_admin_role` VALUES ('1', '超级管理员', '100', '1');
INSERT INTO `cx_admin_role` VALUES ('2', '学生', '0', '1');
INSERT INTO `cx_admin_role` VALUES ('7', '教师', '0', '1');

-- ----------------------------
-- Table structure for `cx_area`
-- ----------------------------
DROP TABLE IF EXISTS `cx_area`;
CREATE TABLE `cx_area` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `region_name` varchar(30) NOT NULL DEFAULT '',
  `parent_id` smallint(5) NOT NULL DEFAULT '0',
  `level` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3801 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='地区表';

-- ----------------------------
-- Records of cx_area
-- ----------------------------
INSERT INTO `cx_area` VALUES ('1', '北京', '0', '1');
INSERT INTO `cx_area` VALUES ('20', '三环以内', '2', '3');
INSERT INTO `cx_area` VALUES ('21', '三环到四环之间', '2', '3');
INSERT INTO `cx_area` VALUES ('22', '四环到五环之间', '2', '3');
INSERT INTO `cx_area` VALUES ('23', '五环到六环之间', '2', '3');
INSERT INTO `cx_area` VALUES ('24', '管庄', '2', '3');
INSERT INTO `cx_area` VALUES ('25', '北苑', '2', '3');
INSERT INTO `cx_area` VALUES ('26', '天通苑', '2', '3');
INSERT INTO `cx_area` VALUES ('27', '定福庄', '2', '3');
INSERT INTO `cx_area` VALUES ('28', '北京经济技术开发区', '2', '3');
INSERT INTO `cx_area` VALUES ('29', '三环以内', '3', '3');
INSERT INTO `cx_area` VALUES ('30', '三环到四环之间', '3', '3');
INSERT INTO `cx_area` VALUES ('31', '四环到五环之间', '3', '3');
INSERT INTO `cx_area` VALUES ('32', '五环到六环之间', '3', '3');
INSERT INTO `cx_area` VALUES ('33', '六环以外', '3', '3');
INSERT INTO `cx_area` VALUES ('34', '上地', '3', '3');
INSERT INTO `cx_area` VALUES ('35', '西三旗', '3', '3');
INSERT INTO `cx_area` VALUES ('36', '清河', '3', '3');
INSERT INTO `cx_area` VALUES ('37', '圆明园西路', '3', '3');
INSERT INTO `cx_area` VALUES ('38', '农业大学西校区', '3', '3');
INSERT INTO `cx_area` VALUES ('39', '西二旗', '3', '3');
INSERT INTO `cx_area` VALUES ('40', '内环到二环里', '4', '3');
INSERT INTO `cx_area` VALUES ('41', '二环到三环', '4', '3');
INSERT INTO `cx_area` VALUES ('42', '内环到三环里', '5', '3');
INSERT INTO `cx_area` VALUES ('43', '一环到二环', '6', '3');
INSERT INTO `cx_area` VALUES ('44', '二环到三环', '6', '3');
INSERT INTO `cx_area` VALUES ('45', '内环到三环里', '7', '3');
INSERT INTO `cx_area` VALUES ('46', '四环到五环之间', '8', '3');
INSERT INTO `cx_area` VALUES ('47', '二环到三环', '8', '3');
INSERT INTO `cx_area` VALUES ('48', '三环到四环之间', '8', '3');
INSERT INTO `cx_area` VALUES ('49', '五环以外', '8', '3');
INSERT INTO `cx_area` VALUES ('50', '四环到五环内', '9', '3');
INSERT INTO `cx_area` VALUES ('51', '石景山城区', '9', '3');
INSERT INTO `cx_area` VALUES ('52', '八大处科技园区', '9', '3');
INSERT INTO `cx_area` VALUES ('53', '六环以外', '10', '3');
INSERT INTO `cx_area` VALUES ('54', '五环以外', '11', '3');
INSERT INTO `cx_area` VALUES ('55', '六环以外', '12', '3');
INSERT INTO `cx_area` VALUES ('56', '通州郊区', '12', '3');
INSERT INTO `cx_area` VALUES ('57', '通州城区内', '12', '3');
INSERT INTO `cx_area` VALUES ('58', '亦庄经济技术开发区', '13', '3');
INSERT INTO `cx_area` VALUES ('59', '旧宫镇', '13', '3');
INSERT INTO `cx_area` VALUES ('60', '四环至五环之间', '13', '3');
INSERT INTO `cx_area` VALUES ('61', '西红门', '13', '3');
INSERT INTO `cx_area` VALUES ('62', '六环以外', '13', '3');
INSERT INTO `cx_area` VALUES ('63', '亦庄其它', '13', '3');
INSERT INTO `cx_area` VALUES ('64', '五环以外', '14', '3');
INSERT INTO `cx_area` VALUES ('65', '五环以外', '15', '3');
INSERT INTO `cx_area` VALUES ('66', '五环以外', '16', '3');
INSERT INTO `cx_area` VALUES ('67', '五环以外', '17', '3');
INSERT INTO `cx_area` VALUES ('68', '回龙观', '17', '3');
INSERT INTO `cx_area` VALUES ('69', '天通苑', '17', '3');
INSERT INTO `cx_area` VALUES ('70', '六环以外', '18', '3');
INSERT INTO `cx_area` VALUES ('71', '六环以外', '19', '3');
INSERT INTO `cx_area` VALUES ('72', '上海', '0', '1');
INSERT INTO `cx_area` VALUES ('92', '内环以内', '73', '3');
INSERT INTO `cx_area` VALUES ('93', '内环中环之间', '73', '3');
INSERT INTO `cx_area` VALUES ('94', '中环外环之间', '73', '3');
INSERT INTO `cx_area` VALUES ('95', '内环中环之间', '74', '3');
INSERT INTO `cx_area` VALUES ('96', '内环以内', '74', '3');
INSERT INTO `cx_area` VALUES ('97', '中环外环之间', '74', '3');
INSERT INTO `cx_area` VALUES ('98', '内环以内', '75', '3');
INSERT INTO `cx_area` VALUES ('99', '内环中环之间', '75', '3');
INSERT INTO `cx_area` VALUES ('100', '内环以内', '76', '3');
INSERT INTO `cx_area` VALUES ('101', '内环中环之间', '76', '3');
INSERT INTO `cx_area` VALUES ('102', '中环外环之间', '76', '3');
INSERT INTO `cx_area` VALUES ('103', '内环以内', '77', '3');
INSERT INTO `cx_area` VALUES ('104', '内环中环之间', '77', '3');
INSERT INTO `cx_area` VALUES ('105', '中环外环之间', '77', '3');
INSERT INTO `cx_area` VALUES ('106', '内环以内', '78', '3');
INSERT INTO `cx_area` VALUES ('107', '内环中环之间', '78', '3');
INSERT INTO `cx_area` VALUES ('108', '中环外环之间', '78', '3');
INSERT INTO `cx_area` VALUES ('109', '内环以内', '79', '3');
INSERT INTO `cx_area` VALUES ('110', '内环中环之间', '79', '3');
INSERT INTO `cx_area` VALUES ('111', '中环外环之间', '79', '3');
INSERT INTO `cx_area` VALUES ('112', '内环以内', '80', '3');
INSERT INTO `cx_area` VALUES ('113', '内环中环之间', '80', '3');
INSERT INTO `cx_area` VALUES ('114', '中环外环之间', '80', '3');
INSERT INTO `cx_area` VALUES ('115', '中环以内', '81', '3');
INSERT INTO `cx_area` VALUES ('116', '中环外环之间', '81', '3');
INSERT INTO `cx_area` VALUES ('117', '外环以外', '81', '3');
INSERT INTO `cx_area` VALUES ('118', '中环以内', '82', '3');
INSERT INTO `cx_area` VALUES ('119', '中环外环之间', '82', '3');
INSERT INTO `cx_area` VALUES ('120', '外环以外', '82', '3');
INSERT INTO `cx_area` VALUES ('121', '外环以外', '83', '3');
INSERT INTO `cx_area` VALUES ('122', '中环以内', '84', '3');
INSERT INTO `cx_area` VALUES ('123', '中环外环之间', '84', '3');
INSERT INTO `cx_area` VALUES ('124', '外环以外', '84', '3');
INSERT INTO `cx_area` VALUES ('125', '外环以外', '85', '3');
INSERT INTO `cx_area` VALUES ('126', '外环以外', '86', '3');
INSERT INTO `cx_area` VALUES ('127', '外环以外', '87', '3');
INSERT INTO `cx_area` VALUES ('128', '祝桥镇', '88', '3');
INSERT INTO `cx_area` VALUES ('129', '新场镇', '88', '3');
INSERT INTO `cx_area` VALUES ('130', '惠南镇', '88', '3');
INSERT INTO `cx_area` VALUES ('131', '康桥镇', '88', '3');
INSERT INTO `cx_area` VALUES ('132', '宣桥镇', '88', '3');
INSERT INTO `cx_area` VALUES ('133', '书院镇', '88', '3');
INSERT INTO `cx_area` VALUES ('134', '大团镇', '88', '3');
INSERT INTO `cx_area` VALUES ('135', '周浦镇', '88', '3');
INSERT INTO `cx_area` VALUES ('136', '芦潮港镇', '88', '3');
INSERT INTO `cx_area` VALUES ('137', '泥城镇', '88', '3');
INSERT INTO `cx_area` VALUES ('138', '六灶镇', '88', '3');
INSERT INTO `cx_area` VALUES ('139', '航头镇', '88', '3');
INSERT INTO `cx_area` VALUES ('140', '万祥镇', '88', '3');
INSERT INTO `cx_area` VALUES ('141', '老港镇', '88', '3');
INSERT INTO `cx_area` VALUES ('142', '申港街道', '88', '3');
INSERT INTO `cx_area` VALUES ('143', '临港新城', '88', '3');
INSERT INTO `cx_area` VALUES ('144', '外环以外', '89', '3');
INSERT INTO `cx_area` VALUES ('145', '内环以内', '90', '3');
INSERT INTO `cx_area` VALUES ('146', '内环中环之间', '90', '3');
INSERT INTO `cx_area` VALUES ('147', '中环外环之间', '90', '3');
INSERT INTO `cx_area` VALUES ('148', '桃浦新村', '90', '3');
INSERT INTO `cx_area` VALUES ('149', '崇明岛', '91', '3');
INSERT INTO `cx_area` VALUES ('150', '长兴岛', '91', '3');
INSERT INTO `cx_area` VALUES ('151', '横沙', '91', '3');
INSERT INTO `cx_area` VALUES ('152', '天津', '0', '1');
INSERT INTO `cx_area` VALUES ('154', '塘沽区', '153', '3');
INSERT INTO `cx_area` VALUES ('155', '西青区', '153', '3');
INSERT INTO `cx_area` VALUES ('156', '北辰区', '153', '3');
INSERT INTO `cx_area` VALUES ('157', '东丽区', '153', '3');
INSERT INTO `cx_area` VALUES ('158', '汉沽区', '153', '3');
INSERT INTO `cx_area` VALUES ('159', '大港区', '153', '3');
INSERT INTO `cx_area` VALUES ('160', '津南区', '153', '3');
INSERT INTO `cx_area` VALUES ('161', '蓟县', '153', '3');
INSERT INTO `cx_area` VALUES ('162', '武清县', '153', '3');
INSERT INTO `cx_area` VALUES ('163', '宁河县', '153', '3');
INSERT INTO `cx_area` VALUES ('164', '宝坻县', '153', '3');
INSERT INTO `cx_area` VALUES ('165', '静海县', '153', '3');
INSERT INTO `cx_area` VALUES ('166', '南开区', '153', '3');
INSERT INTO `cx_area` VALUES ('167', '和平区', '153', '3');
INSERT INTO `cx_area` VALUES ('168', '河西区', '153', '3');
INSERT INTO `cx_area` VALUES ('169', '红桥区', '153', '3');
INSERT INTO `cx_area` VALUES ('170', '河北区', '153', '3');
INSERT INTO `cx_area` VALUES ('171', '河东区', '153', '3');
INSERT INTO `cx_area` VALUES ('172', '重庆', '0', '1');
INSERT INTO `cx_area` VALUES ('174', '渝中区', '173', '3');
INSERT INTO `cx_area` VALUES ('175', '江北区', '173', '3');
INSERT INTO `cx_area` VALUES ('176', '九龙坡区', '173', '3');
INSERT INTO `cx_area` VALUES ('177', '沙坪坝区', '173', '3');
INSERT INTO `cx_area` VALUES ('178', '高新区', '173', '3');
INSERT INTO `cx_area` VALUES ('179', '大渡口', '173', '3');
INSERT INTO `cx_area` VALUES ('180', '巴南区', '173', '3');
INSERT INTO `cx_area` VALUES ('181', '南岸区', '173', '3');
INSERT INTO `cx_area` VALUES ('182', '万盛区', '173', '3');
INSERT INTO `cx_area` VALUES ('183', '合川区', '173', '3');
INSERT INTO `cx_area` VALUES ('184', '城口县', '173', '3');
INSERT INTO `cx_area` VALUES ('185', '渝北区', '173', '3');
INSERT INTO `cx_area` VALUES ('186', '北碚区', '173', '3');
INSERT INTO `cx_area` VALUES ('187', '双桥区', '173', '3');
INSERT INTO `cx_area` VALUES ('188', '万州区', '173', '3');
INSERT INTO `cx_area` VALUES ('189', '培陵区', '173', '3');
INSERT INTO `cx_area` VALUES ('190', '梁平县', '173', '3');
INSERT INTO `cx_area` VALUES ('191', '永川区', '173', '3');
INSERT INTO `cx_area` VALUES ('192', '江津区', '173', '3');
INSERT INTO `cx_area` VALUES ('193', '南川市', '173', '3');
INSERT INTO `cx_area` VALUES ('194', '铜梁县', '173', '3');
INSERT INTO `cx_area` VALUES ('195', '长寿区', '173', '3');
INSERT INTO `cx_area` VALUES ('196', '潼南县', '173', '3');
INSERT INTO `cx_area` VALUES ('197', '荣昌县', '173', '3');
INSERT INTO `cx_area` VALUES ('198', '壁山县', '173', '3');
INSERT INTO `cx_area` VALUES ('199', '大足县', '173', '3');
INSERT INTO `cx_area` VALUES ('200', '黔江区', '173', '3');
INSERT INTO `cx_area` VALUES ('201', '武隆县', '173', '3');
INSERT INTO `cx_area` VALUES ('202', '丰都县', '173', '3');
INSERT INTO `cx_area` VALUES ('203', '奉节县', '173', '3');
INSERT INTO `cx_area` VALUES ('204', '开县', '173', '3');
INSERT INTO `cx_area` VALUES ('205', '云阳县', '173', '3');
INSERT INTO `cx_area` VALUES ('206', '忠县', '173', '3');
INSERT INTO `cx_area` VALUES ('207', '巫溪县', '173', '3');
INSERT INTO `cx_area` VALUES ('208', '巫山县', '173', '3');
INSERT INTO `cx_area` VALUES ('209', '石柱土家族', '173', '3');
INSERT INTO `cx_area` VALUES ('210', '彭水苗族土家', '173', '3');
INSERT INTO `cx_area` VALUES ('211', '垫江县', '173', '3');
INSERT INTO `cx_area` VALUES ('212', '酉阳土家族苗族', '173', '3');
INSERT INTO `cx_area` VALUES ('213', '秀山土家族苗族', '173', '3');
INSERT INTO `cx_area` VALUES ('214', '綦江县', '173', '3');
INSERT INTO `cx_area` VALUES ('215', '江北区', '173', '3');
INSERT INTO `cx_area` VALUES ('216', '高新区', '173', '3');
INSERT INTO `cx_area` VALUES ('217', '南岸区', '173', '3');
INSERT INTO `cx_area` VALUES ('218', '巴南区', '173', '3');
INSERT INTO `cx_area` VALUES ('219', '九龙坡区', '173', '3');
INSERT INTO `cx_area` VALUES ('220', '大渡口区', '173', '3');
INSERT INTO `cx_area` VALUES ('221', '沙坪坝区', '173', '3');
INSERT INTO `cx_area` VALUES ('222', '河北', '0', '1');
INSERT INTO `cx_area` VALUES ('234', '长安区', '223', '3');
INSERT INTO `cx_area` VALUES ('235', '桥东区', '223', '3');
INSERT INTO `cx_area` VALUES ('236', '桥西区', '223', '3');
INSERT INTO `cx_area` VALUES ('237', '新华区', '223', '3');
INSERT INTO `cx_area` VALUES ('238', '裕华区', '223', '3');
INSERT INTO `cx_area` VALUES ('239', '井陉矿区', '223', '3');
INSERT INTO `cx_area` VALUES ('240', '经济技术开发区', '223', '3');
INSERT INTO `cx_area` VALUES ('241', '平山县', '223', '3');
INSERT INTO `cx_area` VALUES ('242', '辛集市', '223', '3');
INSERT INTO `cx_area` VALUES ('243', '藁城市', '223', '3');
INSERT INTO `cx_area` VALUES ('244', '晋州市', '223', '3');
INSERT INTO `cx_area` VALUES ('245', '新乐市', '223', '3');
INSERT INTO `cx_area` VALUES ('246', '鹿泉市', '223', '3');
INSERT INTO `cx_area` VALUES ('247', '井陉县', '223', '3');
INSERT INTO `cx_area` VALUES ('248', '栾城县', '223', '3');
INSERT INTO `cx_area` VALUES ('249', '正定县', '223', '3');
INSERT INTO `cx_area` VALUES ('250', '行唐县', '223', '3');
INSERT INTO `cx_area` VALUES ('251', '灵寿县', '223', '3');
INSERT INTO `cx_area` VALUES ('252', '高邑县', '223', '3');
INSERT INTO `cx_area` VALUES ('253', '赵县', '223', '3');
INSERT INTO `cx_area` VALUES ('254', '赞皇县', '223', '3');
INSERT INTO `cx_area` VALUES ('255', '深泽县', '223', '3');
INSERT INTO `cx_area` VALUES ('256', '无极县', '223', '3');
INSERT INTO `cx_area` VALUES ('257', '元氏县', '223', '3');
INSERT INTO `cx_area` VALUES ('258', '矿区', '223', '3');
INSERT INTO `cx_area` VALUES ('259', '丛台区', '224', '3');
INSERT INTO `cx_area` VALUES ('260', '邯山区', '224', '3');
INSERT INTO `cx_area` VALUES ('261', '复兴区', '224', '3');
INSERT INTO `cx_area` VALUES ('262', '永年县', '224', '3');
INSERT INTO `cx_area` VALUES ('263', '武汉市', '224', '3');
INSERT INTO `cx_area` VALUES ('264', '邯郸县', '224', '3');
INSERT INTO `cx_area` VALUES ('265', '峰峰矿区', '224', '3');
INSERT INTO `cx_area` VALUES ('266', '曲周县', '224', '3');
INSERT INTO `cx_area` VALUES ('267', '馆陶县', '224', '3');
INSERT INTO `cx_area` VALUES ('268', '魏县', '224', '3');
INSERT INTO `cx_area` VALUES ('269', '成安县', '224', '3');
INSERT INTO `cx_area` VALUES ('270', '大名县', '224', '3');
INSERT INTO `cx_area` VALUES ('271', '涉县', '224', '3');
INSERT INTO `cx_area` VALUES ('272', '鸡泽县', '224', '3');
INSERT INTO `cx_area` VALUES ('273', '邱县', '224', '3');
INSERT INTO `cx_area` VALUES ('274', '广平县', '224', '3');
INSERT INTO `cx_area` VALUES ('275', '肥乡县', '224', '3');
INSERT INTO `cx_area` VALUES ('276', '磁县', '224', '3');
INSERT INTO `cx_area` VALUES ('277', '临漳县', '224', '3');
INSERT INTO `cx_area` VALUES ('278', '邢台县', '225', '3');
INSERT INTO `cx_area` VALUES ('279', '南宫市', '225', '3');
INSERT INTO `cx_area` VALUES ('280', '沙河市', '225', '3');
INSERT INTO `cx_area` VALUES ('281', '柏乡县', '225', '3');
INSERT INTO `cx_area` VALUES ('282', '任县', '225', '3');
INSERT INTO `cx_area` VALUES ('283', '清河县', '225', '3');
INSERT INTO `cx_area` VALUES ('284', '隆尧县', '225', '3');
INSERT INTO `cx_area` VALUES ('285', '临城县', '225', '3');
INSERT INTO `cx_area` VALUES ('286', '广宗县', '225', '3');
INSERT INTO `cx_area` VALUES ('287', '临西县', '225', '3');
INSERT INTO `cx_area` VALUES ('288', '内丘县', '225', '3');
INSERT INTO `cx_area` VALUES ('289', '平乡县', '225', '3');
INSERT INTO `cx_area` VALUES ('290', '巨鹿县', '225', '3');
INSERT INTO `cx_area` VALUES ('291', '新河县', '225', '3');
INSERT INTO `cx_area` VALUES ('292', '南和县', '225', '3');
INSERT INTO `cx_area` VALUES ('293', '邢台市内', '225', '3');
INSERT INTO `cx_area` VALUES ('294', '宁晋县', '225', '3');
INSERT INTO `cx_area` VALUES ('295', '威县', '225', '3');
INSERT INTO `cx_area` VALUES ('296', '桥西区', '225', '3');
INSERT INTO `cx_area` VALUES ('297', '桥东区', '225', '3');
INSERT INTO `cx_area` VALUES ('298', '保定市', '226', '3');
INSERT INTO `cx_area` VALUES ('299', '涿州市', '226', '3');
INSERT INTO `cx_area` VALUES ('300', '定州市', '226', '3');
INSERT INTO `cx_area` VALUES ('301', '安国市', '226', '3');
INSERT INTO `cx_area` VALUES ('302', '高碑店市', '226', '3');
INSERT INTO `cx_area` VALUES ('303', '满城县', '226', '3');
INSERT INTO `cx_area` VALUES ('304', '清苑县', '226', '3');
INSERT INTO `cx_area` VALUES ('305', '涞水县', '226', '3');
INSERT INTO `cx_area` VALUES ('306', '阜平县', '226', '3');
INSERT INTO `cx_area` VALUES ('307', '徐水县', '226', '3');
INSERT INTO `cx_area` VALUES ('308', '定兴县', '226', '3');
INSERT INTO `cx_area` VALUES ('309', '唐县', '226', '3');
INSERT INTO `cx_area` VALUES ('310', '高阳县', '226', '3');
INSERT INTO `cx_area` VALUES ('311', '容城县', '226', '3');
INSERT INTO `cx_area` VALUES ('312', '涞源县', '226', '3');
INSERT INTO `cx_area` VALUES ('313', '望都县', '226', '3');
INSERT INTO `cx_area` VALUES ('314', '易县', '226', '3');
INSERT INTO `cx_area` VALUES ('315', '曲阳县', '226', '3');
INSERT INTO `cx_area` VALUES ('316', '蠡县', '226', '3');
INSERT INTO `cx_area` VALUES ('317', '顺平县', '226', '3');
INSERT INTO `cx_area` VALUES ('318', '博野县', '226', '3');
INSERT INTO `cx_area` VALUES ('319', '雄县', '226', '3');
INSERT INTO `cx_area` VALUES ('320', '新市区', '226', '3');
INSERT INTO `cx_area` VALUES ('321', '北市区', '226', '3');
INSERT INTO `cx_area` VALUES ('322', '南市区', '226', '3');
INSERT INTO `cx_area` VALUES ('323', '安新县', '226', '3');
INSERT INTO `cx_area` VALUES ('324', '宣化县', '227', '3');
INSERT INTO `cx_area` VALUES ('325', '康保县', '227', '3');
INSERT INTO `cx_area` VALUES ('326', '张北县', '227', '3');
INSERT INTO `cx_area` VALUES ('327', '阳原县', '227', '3');
INSERT INTO `cx_area` VALUES ('328', '赤城县', '227', '3');
INSERT INTO `cx_area` VALUES ('329', '怀安县', '227', '3');
INSERT INTO `cx_area` VALUES ('330', '怀来县', '227', '3');
INSERT INTO `cx_area` VALUES ('331', '崇礼县', '227', '3');
INSERT INTO `cx_area` VALUES ('332', '尚义县', '227', '3');
INSERT INTO `cx_area` VALUES ('333', '蔚县', '227', '3');
INSERT INTO `cx_area` VALUES ('334', '涿鹿县', '227', '3');
INSERT INTO `cx_area` VALUES ('335', '万全县', '227', '3');
INSERT INTO `cx_area` VALUES ('336', '下花园区', '227', '3');
INSERT INTO `cx_area` VALUES ('337', '沽源县', '227', '3');
INSERT INTO `cx_area` VALUES ('338', '桥西区', '227', '3');
INSERT INTO `cx_area` VALUES ('339', '桥东区', '227', '3');
INSERT INTO `cx_area` VALUES ('340', '宣化区', '227', '3');
INSERT INTO `cx_area` VALUES ('341', '兴隆县', '228', '3');
INSERT INTO `cx_area` VALUES ('342', '平泉县', '228', '3');
INSERT INTO `cx_area` VALUES ('343', '滦平县', '228', '3');
INSERT INTO `cx_area` VALUES ('344', '丰宁满族自治区', '228', '3');
INSERT INTO `cx_area` VALUES ('345', '围场满族蒙古族自治县', '228', '3');
INSERT INTO `cx_area` VALUES ('346', '宽城满族自治县', '228', '3');
INSERT INTO `cx_area` VALUES ('347', '隆化县', '228', '3');
INSERT INTO `cx_area` VALUES ('348', '承德县', '228', '3');
INSERT INTO `cx_area` VALUES ('349', '双桥区', '228', '3');
INSERT INTO `cx_area` VALUES ('350', '双滦区', '228', '3');
INSERT INTO `cx_area` VALUES ('351', '鹰手营子矿区', '228', '3');
INSERT INTO `cx_area` VALUES ('352', '海港区', '229', '3');
INSERT INTO `cx_area` VALUES ('353', '卢龙县', '229', '3');
INSERT INTO `cx_area` VALUES ('354', '青龙满族自治县', '229', '3');
INSERT INTO `cx_area` VALUES ('355', '昌黎县', '229', '3');
INSERT INTO `cx_area` VALUES ('356', '山海关区', '229', '3');
INSERT INTO `cx_area` VALUES ('357', '北戴河区', '229', '3');
INSERT INTO `cx_area` VALUES ('358', '抚宁县', '229', '3');
INSERT INTO `cx_area` VALUES ('359', '路北区', '230', '3');
INSERT INTO `cx_area` VALUES ('360', '路南区', '230', '3');
INSERT INTO `cx_area` VALUES ('361', '古冶区', '230', '3');
INSERT INTO `cx_area` VALUES ('362', '开平区', '230', '3');
INSERT INTO `cx_area` VALUES ('363', '遵化市', '230', '3');
INSERT INTO `cx_area` VALUES ('364', '丰南区', '230', '3');
INSERT INTO `cx_area` VALUES ('365', '迁安市', '230', '3');
INSERT INTO `cx_area` VALUES ('366', '迁西县', '230', '3');
INSERT INTO `cx_area` VALUES ('367', '滦南县', '230', '3');
INSERT INTO `cx_area` VALUES ('368', '丰润区', '230', '3');
INSERT INTO `cx_area` VALUES ('369', '玉田县', '230', '3');
INSERT INTO `cx_area` VALUES ('370', '唐海县', '230', '3');
INSERT INTO `cx_area` VALUES ('371', '乐亭县', '230', '3');
INSERT INTO `cx_area` VALUES ('372', '滦县', '230', '3');
INSERT INTO `cx_area` VALUES ('373', '沧县', '231', '3');
INSERT INTO `cx_area` VALUES ('374', '泊头市', '231', '3');
INSERT INTO `cx_area` VALUES ('375', '任丘市', '231', '3');
INSERT INTO `cx_area` VALUES ('376', '河间市', '231', '3');
INSERT INTO `cx_area` VALUES ('377', '献县', '231', '3');
INSERT INTO `cx_area` VALUES ('378', '肃宁县', '231', '3');
INSERT INTO `cx_area` VALUES ('379', '青县', '231', '3');
INSERT INTO `cx_area` VALUES ('380', '东光县', '231', '3');
INSERT INTO `cx_area` VALUES ('381', '吴桥县', '231', '3');
INSERT INTO `cx_area` VALUES ('382', '南皮具', '231', '3');
INSERT INTO `cx_area` VALUES ('383', '盐山县', '231', '3');
INSERT INTO `cx_area` VALUES ('384', '海兴县', '231', '3');
INSERT INTO `cx_area` VALUES ('385', '孟村回族自治县', '231', '3');
INSERT INTO `cx_area` VALUES ('386', '黄骅市', '231', '3');
INSERT INTO `cx_area` VALUES ('387', '运河区', '231', '3');
INSERT INTO `cx_area` VALUES ('388', '新华区', '231', '3');
INSERT INTO `cx_area` VALUES ('389', '霸州市', '232', '3');
INSERT INTO `cx_area` VALUES ('390', '三河市', '232', '3');
INSERT INTO `cx_area` VALUES ('391', '固安县', '232', '3');
INSERT INTO `cx_area` VALUES ('392', '永清县', '232', '3');
INSERT INTO `cx_area` VALUES ('393', '香河县', '232', '3');
INSERT INTO `cx_area` VALUES ('394', '大城县', '232', '3');
INSERT INTO `cx_area` VALUES ('395', '文安县', '232', '3');
INSERT INTO `cx_area` VALUES ('396', '大厂回族自治县', '232', '3');
INSERT INTO `cx_area` VALUES ('397', '安次县', '232', '3');
INSERT INTO `cx_area` VALUES ('398', '广阳区', '232', '3');
INSERT INTO `cx_area` VALUES ('399', '开发区', '232', '3');
INSERT INTO `cx_area` VALUES ('400', '冀州市', '233', '3');
INSERT INTO `cx_area` VALUES ('401', '深州市', '233', '3');
INSERT INTO `cx_area` VALUES ('402', '饶阳县', '233', '3');
INSERT INTO `cx_area` VALUES ('403', '枣强县', '233', '3');
INSERT INTO `cx_area` VALUES ('404', '故城县', '233', '3');
INSERT INTO `cx_area` VALUES ('405', '阜城县', '233', '3');
INSERT INTO `cx_area` VALUES ('406', '安平县', '233', '3');
INSERT INTO `cx_area` VALUES ('407', '武邑县', '233', '3');
INSERT INTO `cx_area` VALUES ('408', '景县', '233', '3');
INSERT INTO `cx_area` VALUES ('409', '武强县', '233', '3');
INSERT INTO `cx_area` VALUES ('410', '桃城区', '233', '3');
INSERT INTO `cx_area` VALUES ('411', '山西', '0', '1');
INSERT INTO `cx_area` VALUES ('423', '阳曲县', '412', '3');
INSERT INTO `cx_area` VALUES ('424', '古交市', '412', '3');
INSERT INTO `cx_area` VALUES ('425', '娄烦县', '412', '3');
INSERT INTO `cx_area` VALUES ('426', '清徐县', '412', '3');
INSERT INTO `cx_area` VALUES ('427', '杏花岭区', '412', '3');
INSERT INTO `cx_area` VALUES ('428', '小店区', '412', '3');
INSERT INTO `cx_area` VALUES ('429', '迎泽区', '412', '3');
INSERT INTO `cx_area` VALUES ('430', '尖草坪区', '412', '3');
INSERT INTO `cx_area` VALUES ('431', '万柏林区', '412', '3');
INSERT INTO `cx_area` VALUES ('432', '晋源区', '412', '3');
INSERT INTO `cx_area` VALUES ('433', '大同县', '413', '3');
INSERT INTO `cx_area` VALUES ('434', '天镇县', '413', '3');
INSERT INTO `cx_area` VALUES ('435', '灵丘县', '413', '3');
INSERT INTO `cx_area` VALUES ('436', '阳高县', '413', '3');
INSERT INTO `cx_area` VALUES ('437', '左云县', '413', '3');
INSERT INTO `cx_area` VALUES ('438', '浑源县', '413', '3');
INSERT INTO `cx_area` VALUES ('439', '广灵县', '413', '3');
INSERT INTO `cx_area` VALUES ('440', '新荣区', '413', '3');
INSERT INTO `cx_area` VALUES ('441', '南郊区', '413', '3');
INSERT INTO `cx_area` VALUES ('442', '矿区', '413', '3');
INSERT INTO `cx_area` VALUES ('443', '城区', '413', '3');
INSERT INTO `cx_area` VALUES ('444', '盂县', '414', '3');
INSERT INTO `cx_area` VALUES ('445', '平定县', '414', '3');
INSERT INTO `cx_area` VALUES ('446', '郊区', '414', '3');
INSERT INTO `cx_area` VALUES ('447', '矿区', '414', '3');
INSERT INTO `cx_area` VALUES ('448', '城区', '414', '3');
INSERT INTO `cx_area` VALUES ('449', '高平市', '415', '3');
INSERT INTO `cx_area` VALUES ('450', '阳城县', '415', '3');
INSERT INTO `cx_area` VALUES ('451', '沁水县', '415', '3');
INSERT INTO `cx_area` VALUES ('452', '陵川县', '415', '3');
INSERT INTO `cx_area` VALUES ('453', '泽州县', '415', '3');
INSERT INTO `cx_area` VALUES ('454', '城区', '415', '3');
INSERT INTO `cx_area` VALUES ('455', '山阴县', '416', '3');
INSERT INTO `cx_area` VALUES ('456', '右玉县', '416', '3');
INSERT INTO `cx_area` VALUES ('457', '应县', '416', '3');
INSERT INTO `cx_area` VALUES ('458', '怀仁县', '416', '3');
INSERT INTO `cx_area` VALUES ('459', '朔城区', '416', '3');
INSERT INTO `cx_area` VALUES ('460', '平鲁区', '416', '3');
INSERT INTO `cx_area` VALUES ('461', '榆次区', '417', '3');
INSERT INTO `cx_area` VALUES ('462', '介休市', '417', '3');
INSERT INTO `cx_area` VALUES ('463', '昔阳县', '417', '3');
INSERT INTO `cx_area` VALUES ('464', '祁县', '417', '3');
INSERT INTO `cx_area` VALUES ('465', '左权县', '417', '3');
INSERT INTO `cx_area` VALUES ('466', '寿阳县', '417', '3');
INSERT INTO `cx_area` VALUES ('467', '太谷县', '417', '3');
INSERT INTO `cx_area` VALUES ('468', '和顺县', '417', '3');
INSERT INTO `cx_area` VALUES ('469', '灵石县', '417', '3');
INSERT INTO `cx_area` VALUES ('470', '平遥县', '417', '3');
INSERT INTO `cx_area` VALUES ('471', '榆社县', '417', '3');
INSERT INTO `cx_area` VALUES ('472', '原平市', '418', '3');
INSERT INTO `cx_area` VALUES ('473', '代县', '418', '3');
INSERT INTO `cx_area` VALUES ('474', '神池县', '418', '3');
INSERT INTO `cx_area` VALUES ('475', '五寨县', '418', '3');
INSERT INTO `cx_area` VALUES ('476', '五台县', '418', '3');
INSERT INTO `cx_area` VALUES ('477', '偏关县', '418', '3');
INSERT INTO `cx_area` VALUES ('478', '宁武县', '418', '3');
INSERT INTO `cx_area` VALUES ('479', '静乐县', '418', '3');
INSERT INTO `cx_area` VALUES ('480', '繁峙县', '418', '3');
INSERT INTO `cx_area` VALUES ('481', '河曲县', '418', '3');
INSERT INTO `cx_area` VALUES ('482', '保德县', '418', '3');
INSERT INTO `cx_area` VALUES ('483', '定襄县', '418', '3');
INSERT INTO `cx_area` VALUES ('484', '忻府区', '418', '3');
INSERT INTO `cx_area` VALUES ('485', '岢岚县', '418', '3');
INSERT INTO `cx_area` VALUES ('486', '离石区', '419', '3');
INSERT INTO `cx_area` VALUES ('487', '孝义市', '419', '3');
INSERT INTO `cx_area` VALUES ('488', '汾阳市', '419', '3');
INSERT INTO `cx_area` VALUES ('489', '文水县', '419', '3');
INSERT INTO `cx_area` VALUES ('490', '中阳县', '419', '3');
INSERT INTO `cx_area` VALUES ('491', '兴县', '419', '3');
INSERT INTO `cx_area` VALUES ('492', '临县', '419', '3');
INSERT INTO `cx_area` VALUES ('493', '方山县', '419', '3');
INSERT INTO `cx_area` VALUES ('494', '柳林县', '419', '3');
INSERT INTO `cx_area` VALUES ('495', '岚县', '419', '3');
INSERT INTO `cx_area` VALUES ('496', '交口县', '419', '3');
INSERT INTO `cx_area` VALUES ('497', '交城县', '419', '3');
INSERT INTO `cx_area` VALUES ('498', '石楼县', '419', '3');
INSERT INTO `cx_area` VALUES ('499', '侯马市', '420', '3');
INSERT INTO `cx_area` VALUES ('500', '霍州市', '420', '3');
INSERT INTO `cx_area` VALUES ('501', '汾西县', '420', '3');
INSERT INTO `cx_area` VALUES ('502', '吉县', '420', '3');
INSERT INTO `cx_area` VALUES ('503', '安泽县', '420', '3');
INSERT INTO `cx_area` VALUES ('504', '浮山县', '420', '3');
INSERT INTO `cx_area` VALUES ('505', '大宁县', '420', '3');
INSERT INTO `cx_area` VALUES ('506', '古县', '420', '3');
INSERT INTO `cx_area` VALUES ('507', '隰 县', '420', '3');
INSERT INTO `cx_area` VALUES ('508', '襄汾县', '420', '3');
INSERT INTO `cx_area` VALUES ('509', '翼城县', '420', '3');
INSERT INTO `cx_area` VALUES ('510', '永和县', '420', '3');
INSERT INTO `cx_area` VALUES ('511', '乡宁县', '420', '3');
INSERT INTO `cx_area` VALUES ('512', '洪洞县', '420', '3');
INSERT INTO `cx_area` VALUES ('513', '蒲县', '420', '3');
INSERT INTO `cx_area` VALUES ('514', '曲沃县', '420', '3');
INSERT INTO `cx_area` VALUES ('515', '尧都区', '420', '3');
INSERT INTO `cx_area` VALUES ('516', '河津市', '421', '3');
INSERT INTO `cx_area` VALUES ('517', '永济市', '421', '3');
INSERT INTO `cx_area` VALUES ('518', '新绛县', '421', '3');
INSERT INTO `cx_area` VALUES ('519', '平陆县', '421', '3');
INSERT INTO `cx_area` VALUES ('520', '垣曲县', '421', '3');
INSERT INTO `cx_area` VALUES ('521', '绛县', '421', '3');
INSERT INTO `cx_area` VALUES ('522', '稷山县', '421', '3');
INSERT INTO `cx_area` VALUES ('523', '芮城县', '421', '3');
INSERT INTO `cx_area` VALUES ('524', '夏县', '421', '3');
INSERT INTO `cx_area` VALUES ('525', '临猗县', '421', '3');
INSERT INTO `cx_area` VALUES ('526', '万荣县', '421', '3');
INSERT INTO `cx_area` VALUES ('527', '盐湖区', '421', '3');
INSERT INTO `cx_area` VALUES ('528', '闻喜县', '421', '3');
INSERT INTO `cx_area` VALUES ('529', '长治县', '422', '3');
INSERT INTO `cx_area` VALUES ('530', '潞城市', '422', '3');
INSERT INTO `cx_area` VALUES ('531', '城区', '422', '3');
INSERT INTO `cx_area` VALUES ('532', '郊区', '422', '3');
INSERT INTO `cx_area` VALUES ('533', '襄垣县', '422', '3');
INSERT INTO `cx_area` VALUES ('534', '屯留县', '422', '3');
INSERT INTO `cx_area` VALUES ('535', '平顺县', '422', '3');
INSERT INTO `cx_area` VALUES ('536', '黎城县', '422', '3');
INSERT INTO `cx_area` VALUES ('537', '壶关县', '422', '3');
INSERT INTO `cx_area` VALUES ('538', '长子县', '422', '3');
INSERT INTO `cx_area` VALUES ('539', '武乡县', '422', '3');
INSERT INTO `cx_area` VALUES ('540', '沁 县', '422', '3');
INSERT INTO `cx_area` VALUES ('541', '沁源县', '422', '3');
INSERT INTO `cx_area` VALUES ('542', '河南', '0', '1');
INSERT INTO `cx_area` VALUES ('561', '二七区', '543', '3');
INSERT INTO `cx_area` VALUES ('562', '中原区', '543', '3');
INSERT INTO `cx_area` VALUES ('563', '郑东新区', '543', '3');
INSERT INTO `cx_area` VALUES ('564', '郑州市区', '543', '3');
INSERT INTO `cx_area` VALUES ('565', '管城回族区', '543', '3');
INSERT INTO `cx_area` VALUES ('566', '金水区', '543', '3');
INSERT INTO `cx_area` VALUES ('567', '上街区', '543', '3');
INSERT INTO `cx_area` VALUES ('568', '惠济区', '543', '3');
INSERT INTO `cx_area` VALUES ('569', '巩义市', '543', '3');
INSERT INTO `cx_area` VALUES ('570', '新郑市', '543', '3');
INSERT INTO `cx_area` VALUES ('571', '新密市', '543', '3');
INSERT INTO `cx_area` VALUES ('572', '登封市', '543', '3');
INSERT INTO `cx_area` VALUES ('573', '中牟县', '543', '3');
INSERT INTO `cx_area` VALUES ('574', '荥阳市', '543', '3');
INSERT INTO `cx_area` VALUES ('575', '高新区', '543', '3');
INSERT INTO `cx_area` VALUES ('576', '开封县', '544', '3');
INSERT INTO `cx_area` VALUES ('577', '杞县', '544', '3');
INSERT INTO `cx_area` VALUES ('578', '兰考县', '544', '3');
INSERT INTO `cx_area` VALUES ('579', '尉氏县', '544', '3');
INSERT INTO `cx_area` VALUES ('580', '通许县', '544', '3');
INSERT INTO `cx_area` VALUES ('581', '金明区', '544', '3');
INSERT INTO `cx_area` VALUES ('582', '禹王台区', '544', '3');
INSERT INTO `cx_area` VALUES ('583', '顺河回族区', '544', '3');
INSERT INTO `cx_area` VALUES ('584', '龙亭区', '544', '3');
INSERT INTO `cx_area` VALUES ('585', '鼓楼区', '544', '3');
INSERT INTO `cx_area` VALUES ('586', '洛龙区', '545', '3');
INSERT INTO `cx_area` VALUES ('587', '涧西区', '545', '3');
INSERT INTO `cx_area` VALUES ('588', '西工区', '545', '3');
INSERT INTO `cx_area` VALUES ('589', '洛南新区', '545', '3');
INSERT INTO `cx_area` VALUES ('590', '嵩县', '545', '3');
INSERT INTO `cx_area` VALUES ('591', '瀍河回族区', '545', '3');
INSERT INTO `cx_area` VALUES ('592', '老城区', '545', '3');
INSERT INTO `cx_area` VALUES ('593', '吉利区', '545', '3');
INSERT INTO `cx_area` VALUES ('594', '偃师市', '545', '3');
INSERT INTO `cx_area` VALUES ('595', '孟津县', '545', '3');
INSERT INTO `cx_area` VALUES ('596', '汝阳县', '545', '3');
INSERT INTO `cx_area` VALUES ('597', '伊川县', '545', '3');
INSERT INTO `cx_area` VALUES ('598', '洛宁县', '545', '3');
INSERT INTO `cx_area` VALUES ('599', '宜阳县', '545', '3');
INSERT INTO `cx_area` VALUES ('600', '栾川县', '545', '3');
INSERT INTO `cx_area` VALUES ('601', '新安县', '545', '3');
INSERT INTO `cx_area` VALUES ('602', '汝州市', '546', '3');
INSERT INTO `cx_area` VALUES ('603', '舞钢市', '546', '3');
INSERT INTO `cx_area` VALUES ('604', '郏县', '546', '3');
INSERT INTO `cx_area` VALUES ('605', '叶县', '546', '3');
INSERT INTO `cx_area` VALUES ('606', '鲁山县', '546', '3');
INSERT INTO `cx_area` VALUES ('607', '宝丰县', '546', '3');
INSERT INTO `cx_area` VALUES ('608', '石龙区', '546', '3');
INSERT INTO `cx_area` VALUES ('609', '湛河区', '546', '3');
INSERT INTO `cx_area` VALUES ('610', '卫东区', '546', '3');
INSERT INTO `cx_area` VALUES ('611', '新华区', '546', '3');
INSERT INTO `cx_area` VALUES ('612', '新城区', '546', '3');
INSERT INTO `cx_area` VALUES ('613', '沁阳市', '547', '3');
INSERT INTO `cx_area` VALUES ('614', '孟州市', '547', '3');
INSERT INTO `cx_area` VALUES ('615', '修武县', '547', '3');
INSERT INTO `cx_area` VALUES ('616', '温县', '547', '3');
INSERT INTO `cx_area` VALUES ('617', '武陟县', '547', '3');
INSERT INTO `cx_area` VALUES ('618', '博爱县', '547', '3');
INSERT INTO `cx_area` VALUES ('619', '山阳区', '547', '3');
INSERT INTO `cx_area` VALUES ('620', '马村区', '547', '3');
INSERT INTO `cx_area` VALUES ('621', '中站区', '547', '3');
INSERT INTO `cx_area` VALUES ('622', '解放区', '547', '3');
INSERT INTO `cx_area` VALUES ('623', '浚县', '548', '3');
INSERT INTO `cx_area` VALUES ('624', '淇县', '548', '3');
INSERT INTO `cx_area` VALUES ('625', '鹤山区', '548', '3');
INSERT INTO `cx_area` VALUES ('626', '山城区', '548', '3');
INSERT INTO `cx_area` VALUES ('627', '淇滨区', '548', '3');
INSERT INTO `cx_area` VALUES ('628', '卫辉市', '549', '3');
INSERT INTO `cx_area` VALUES ('629', '辉县市', '549', '3');
INSERT INTO `cx_area` VALUES ('630', '新乡县', '549', '3');
INSERT INTO `cx_area` VALUES ('631', '获嘉县', '549', '3');
INSERT INTO `cx_area` VALUES ('632', '原阳县', '549', '3');
INSERT INTO `cx_area` VALUES ('633', '长垣县', '549', '3');
INSERT INTO `cx_area` VALUES ('634', '延津县', '549', '3');
INSERT INTO `cx_area` VALUES ('635', '封丘县', '549', '3');
INSERT INTO `cx_area` VALUES ('636', '牧野区', '549', '3');
INSERT INTO `cx_area` VALUES ('637', '凤泉区', '549', '3');
INSERT INTO `cx_area` VALUES ('638', '红旗区', '549', '3');
INSERT INTO `cx_area` VALUES ('639', '卫滨区', '549', '3');
INSERT INTO `cx_area` VALUES ('640', '林州市', '550', '3');
INSERT INTO `cx_area` VALUES ('641', '安阳县', '550', '3');
INSERT INTO `cx_area` VALUES ('642', '滑县', '550', '3');
INSERT INTO `cx_area` VALUES ('643', '汤阴县', '550', '3');
INSERT INTO `cx_area` VALUES ('644', '内黄县', '550', '3');
INSERT INTO `cx_area` VALUES ('645', '龙安区', '550', '3');
INSERT INTO `cx_area` VALUES ('646', '殷都区', '550', '3');
INSERT INTO `cx_area` VALUES ('647', '文峰区', '550', '3');
INSERT INTO `cx_area` VALUES ('648', '北关区', '550', '3');
INSERT INTO `cx_area` VALUES ('649', '濮阳县', '551', '3');
INSERT INTO `cx_area` VALUES ('650', '南乐县', '551', '3');
INSERT INTO `cx_area` VALUES ('651', '台前县', '551', '3');
INSERT INTO `cx_area` VALUES ('652', '清丰县', '551', '3');
INSERT INTO `cx_area` VALUES ('653', '范县', '551', '3');
INSERT INTO `cx_area` VALUES ('654', '华龙区', '551', '3');
INSERT INTO `cx_area` VALUES ('655', '禹州市', '552', '3');
INSERT INTO `cx_area` VALUES ('656', '长葛市', '552', '3');
INSERT INTO `cx_area` VALUES ('657', '许昌县', '552', '3');
INSERT INTO `cx_area` VALUES ('658', '鄢陵县', '552', '3');
INSERT INTO `cx_area` VALUES ('659', '襄城县', '552', '3');
INSERT INTO `cx_area` VALUES ('660', '魏都区', '552', '3');
INSERT INTO `cx_area` VALUES ('661', '郾城区', '553', '3');
INSERT INTO `cx_area` VALUES ('662', '临颍县', '553', '3');
INSERT INTO `cx_area` VALUES ('663', '召陵区', '553', '3');
INSERT INTO `cx_area` VALUES ('664', '舞阳县', '553', '3');
INSERT INTO `cx_area` VALUES ('665', '源汇区', '553', '3');
INSERT INTO `cx_area` VALUES ('666', '义马市', '554', '3');
INSERT INTO `cx_area` VALUES ('667', '灵宝市', '554', '3');
INSERT INTO `cx_area` VALUES ('668', '陕县', '554', '3');
INSERT INTO `cx_area` VALUES ('669', '卢氏县', '554', '3');
INSERT INTO `cx_area` VALUES ('670', '湖滨区', '554', '3');
INSERT INTO `cx_area` VALUES ('671', '渑池县', '554', '3');
INSERT INTO `cx_area` VALUES ('672', '邓州市', '555', '3');
INSERT INTO `cx_area` VALUES ('673', '桐柏县', '555', '3');
INSERT INTO `cx_area` VALUES ('674', '方城县', '555', '3');
INSERT INTO `cx_area` VALUES ('675', '淅川县', '555', '3');
INSERT INTO `cx_area` VALUES ('676', '镇平县', '555', '3');
INSERT INTO `cx_area` VALUES ('677', '唐河县', '555', '3');
INSERT INTO `cx_area` VALUES ('678', '南召县', '555', '3');
INSERT INTO `cx_area` VALUES ('679', '内乡县', '555', '3');
INSERT INTO `cx_area` VALUES ('680', '新野县', '555', '3');
INSERT INTO `cx_area` VALUES ('681', '社旗县', '555', '3');
INSERT INTO `cx_area` VALUES ('682', '西峡县', '555', '3');
INSERT INTO `cx_area` VALUES ('683', '卧龙区', '555', '3');
INSERT INTO `cx_area` VALUES ('684', '宛城区', '555', '3');
INSERT INTO `cx_area` VALUES ('685', '南阳市市区', '555', '3');
INSERT INTO `cx_area` VALUES ('686', '高新区', '555', '3');
INSERT INTO `cx_area` VALUES ('687', '永城市', '556', '3');
INSERT INTO `cx_area` VALUES ('688', '宁陵县', '556', '3');
INSERT INTO `cx_area` VALUES ('689', '虞城县', '556', '3');
INSERT INTO `cx_area` VALUES ('690', '民权县', '556', '3');
INSERT INTO `cx_area` VALUES ('691', '夏邑县', '556', '3');
INSERT INTO `cx_area` VALUES ('692', '柘城县', '556', '3');
INSERT INTO `cx_area` VALUES ('693', '睢县', '556', '3');
INSERT INTO `cx_area` VALUES ('694', '睢阳区', '556', '3');
INSERT INTO `cx_area` VALUES ('695', '梁园区', '556', '3');
INSERT INTO `cx_area` VALUES ('696', '项城市', '557', '3');
INSERT INTO `cx_area` VALUES ('697', '商水县', '557', '3');
INSERT INTO `cx_area` VALUES ('698', '淮阳县', '557', '3');
INSERT INTO `cx_area` VALUES ('699', '太康县', '557', '3');
INSERT INTO `cx_area` VALUES ('700', '鹿邑县', '557', '3');
INSERT INTO `cx_area` VALUES ('701', '西华县', '557', '3');
INSERT INTO `cx_area` VALUES ('702', '扶沟县', '557', '3');
INSERT INTO `cx_area` VALUES ('703', '沈丘县', '557', '3');
INSERT INTO `cx_area` VALUES ('704', '郸城县', '557', '3');
INSERT INTO `cx_area` VALUES ('705', '川汇区', '557', '3');
INSERT INTO `cx_area` VALUES ('706', '确山县', '558', '3');
INSERT INTO `cx_area` VALUES ('707', '新蔡县', '558', '3');
INSERT INTO `cx_area` VALUES ('708', '上蔡县', '558', '3');
INSERT INTO `cx_area` VALUES ('709', '泌阳县', '558', '3');
INSERT INTO `cx_area` VALUES ('710', '西平县', '558', '3');
INSERT INTO `cx_area` VALUES ('711', '遂平县', '558', '3');
INSERT INTO `cx_area` VALUES ('712', '汝南县', '558', '3');
INSERT INTO `cx_area` VALUES ('713', '平舆县', '558', '3');
INSERT INTO `cx_area` VALUES ('714', '正阳县', '558', '3');
INSERT INTO `cx_area` VALUES ('715', '驿城区', '558', '3');
INSERT INTO `cx_area` VALUES ('716', '潢川县', '559', '3');
INSERT INTO `cx_area` VALUES ('717', '淮滨县', '559', '3');
INSERT INTO `cx_area` VALUES ('718', '息县', '559', '3');
INSERT INTO `cx_area` VALUES ('719', '新县', '559', '3');
INSERT INTO `cx_area` VALUES ('720', '固始县', '559', '3');
INSERT INTO `cx_area` VALUES ('721', '罗山县', '559', '3');
INSERT INTO `cx_area` VALUES ('722', '光山县', '559', '3');
INSERT INTO `cx_area` VALUES ('723', '平桥区', '559', '3');
INSERT INTO `cx_area` VALUES ('724', '商城县', '559', '3');
INSERT INTO `cx_area` VALUES ('725', '浉河区', '559', '3');
INSERT INTO `cx_area` VALUES ('726', '济源市区内', '560', '3');
INSERT INTO `cx_area` VALUES ('727', '辽宁', '0', '1');
INSERT INTO `cx_area` VALUES ('743', '沈河区', '728', '3');
INSERT INTO `cx_area` VALUES ('744', '和平区', '728', '3');
INSERT INTO `cx_area` VALUES ('745', '皇姑区', '728', '3');
INSERT INTO `cx_area` VALUES ('746', '铁西区', '728', '3');
INSERT INTO `cx_area` VALUES ('747', '大东区', '728', '3');
INSERT INTO `cx_area` VALUES ('748', '于洪区', '728', '3');
INSERT INTO `cx_area` VALUES ('749', '东陵区', '728', '3');
INSERT INTO `cx_area` VALUES ('750', '苏家屯区', '728', '3');
INSERT INTO `cx_area` VALUES ('751', '新民区', '728', '3');
INSERT INTO `cx_area` VALUES ('752', '法库县', '728', '3');
INSERT INTO `cx_area` VALUES ('753', '辽中县', '728', '3');
INSERT INTO `cx_area` VALUES ('754', '康平县', '728', '3');
INSERT INTO `cx_area` VALUES ('755', '沈北新区', '728', '3');
INSERT INTO `cx_area` VALUES ('756', '浑南新区', '728', '3');
INSERT INTO `cx_area` VALUES ('757', '沙河口区', '729', '3');
INSERT INTO `cx_area` VALUES ('758', '西岗区', '729', '3');
INSERT INTO `cx_area` VALUES ('759', '中山区', '729', '3');
INSERT INTO `cx_area` VALUES ('760', '大连开发区', '729', '3');
INSERT INTO `cx_area` VALUES ('761', '高新园区', '729', '3');
INSERT INTO `cx_area` VALUES ('762', '普兰店市', '729', '3');
INSERT INTO `cx_area` VALUES ('763', '瓦房店市', '729', '3');
INSERT INTO `cx_area` VALUES ('764', '庄河市', '729', '3');
INSERT INTO `cx_area` VALUES ('765', '长海县', '729', '3');
INSERT INTO `cx_area` VALUES ('766', '金州区', '729', '3');
INSERT INTO `cx_area` VALUES ('767', '旅顺口区', '729', '3');
INSERT INTO `cx_area` VALUES ('768', '甘井子区', '729', '3');
INSERT INTO `cx_area` VALUES ('769', '台安县', '730', '3');
INSERT INTO `cx_area` VALUES ('770', '海城市', '730', '3');
INSERT INTO `cx_area` VALUES ('771', '岫岩满族自治县', '730', '3');
INSERT INTO `cx_area` VALUES ('772', '铁东区', '730', '3');
INSERT INTO `cx_area` VALUES ('773', '铁西区', '730', '3');
INSERT INTO `cx_area` VALUES ('774', '立山区', '730', '3');
INSERT INTO `cx_area` VALUES ('775', '千山区', '730', '3');
INSERT INTO `cx_area` VALUES ('776', '抚顺县', '731', '3');
INSERT INTO `cx_area` VALUES ('777', '新宾满族自治县', '731', '3');
INSERT INTO `cx_area` VALUES ('778', '清原满族自治县', '731', '3');
INSERT INTO `cx_area` VALUES ('779', '望花区', '731', '3');
INSERT INTO `cx_area` VALUES ('780', '东洲区', '731', '3');
INSERT INTO `cx_area` VALUES ('781', '新抚区', '731', '3');
INSERT INTO `cx_area` VALUES ('782', '顺城区', '731', '3');
INSERT INTO `cx_area` VALUES ('783', '平山区', '732', '3');
INSERT INTO `cx_area` VALUES ('784', '明山区', '732', '3');
INSERT INTO `cx_area` VALUES ('785', '南芬区', '732', '3');
INSERT INTO `cx_area` VALUES ('786', '平山区', '732', '3');
INSERT INTO `cx_area` VALUES ('787', '明山区', '732', '3');
INSERT INTO `cx_area` VALUES ('788', '溪湖区', '732', '3');
INSERT INTO `cx_area` VALUES ('789', '本溪满族自治县', '732', '3');
INSERT INTO `cx_area` VALUES ('790', '横仁满族自治县', '732', '3');
INSERT INTO `cx_area` VALUES ('791', '东港市', '733', '3');
INSERT INTO `cx_area` VALUES ('792', '凤城市', '733', '3');
INSERT INTO `cx_area` VALUES ('793', '宽甸满族自治县', '733', '3');
INSERT INTO `cx_area` VALUES ('794', '振安区', '733', '3');
INSERT INTO `cx_area` VALUES ('795', '元宝区', '733', '3');
INSERT INTO `cx_area` VALUES ('796', '振兴区', '733', '3');
INSERT INTO `cx_area` VALUES ('797', '义县', '734', '3');
INSERT INTO `cx_area` VALUES ('798', '凌海市', '734', '3');
INSERT INTO `cx_area` VALUES ('799', '北镇市', '734', '3');
INSERT INTO `cx_area` VALUES ('800', '黑山县', '734', '3');
INSERT INTO `cx_area` VALUES ('801', '凌河区', '734', '3');
INSERT INTO `cx_area` VALUES ('802', '古塔区', '734', '3');
INSERT INTO `cx_area` VALUES ('803', '太和区', '734', '3');
INSERT INTO `cx_area` VALUES ('804', '兴城市', '735', '3');
INSERT INTO `cx_area` VALUES ('805', '绥中县', '735', '3');
INSERT INTO `cx_area` VALUES ('806', '建昌县', '735', '3');
INSERT INTO `cx_area` VALUES ('807', '南票区', '735', '3');
INSERT INTO `cx_area` VALUES ('808', '龙岗区', '735', '3');
INSERT INTO `cx_area` VALUES ('809', '连山区', '735', '3');
INSERT INTO `cx_area` VALUES ('810', '杨家杖子经济开发区', '735', '3');
INSERT INTO `cx_area` VALUES ('811', '大石桥市', '736', '3');
INSERT INTO `cx_area` VALUES ('812', '盖州市', '736', '3');
INSERT INTO `cx_area` VALUES ('813', '鲅鱼圈区', '736', '3');
INSERT INTO `cx_area` VALUES ('814', '老边区', '736', '3');
INSERT INTO `cx_area` VALUES ('815', '西市区', '736', '3');
INSERT INTO `cx_area` VALUES ('816', '站前区', '736', '3');
INSERT INTO `cx_area` VALUES ('817', '盘山县', '737', '3');
INSERT INTO `cx_area` VALUES ('818', '大洼县', '737', '3');
INSERT INTO `cx_area` VALUES ('819', '兴隆台区', '737', '3');
INSERT INTO `cx_area` VALUES ('820', '双台子区', '737', '3');
INSERT INTO `cx_area` VALUES ('821', '阜新蒙古自治县', '738', '3');
INSERT INTO `cx_area` VALUES ('822', '彰武县', '738', '3');
INSERT INTO `cx_area` VALUES ('823', '细河区', '738', '3');
INSERT INTO `cx_area` VALUES ('824', '清河门区', '738', '3');
INSERT INTO `cx_area` VALUES ('825', '太平区', '738', '3');
INSERT INTO `cx_area` VALUES ('826', '新邱区', '738', '3');
INSERT INTO `cx_area` VALUES ('827', '海州区', '738', '3');
INSERT INTO `cx_area` VALUES ('828', '灯塔市', '739', '3');
INSERT INTO `cx_area` VALUES ('829', '辽阳县', '739', '3');
INSERT INTO `cx_area` VALUES ('830', '太子河区', '739', '3');
INSERT INTO `cx_area` VALUES ('831', '弓长岭区', '739', '3');
INSERT INTO `cx_area` VALUES ('832', '宏伟区', '739', '3');
INSERT INTO `cx_area` VALUES ('833', '文圣区', '739', '3');
INSERT INTO `cx_area` VALUES ('834', '白塔区', '739', '3');
INSERT INTO `cx_area` VALUES ('835', '开原市', '740', '3');
INSERT INTO `cx_area` VALUES ('836', '西丰县', '740', '3');
INSERT INTO `cx_area` VALUES ('837', '昌图县', '740', '3');
INSERT INTO `cx_area` VALUES ('838', '铁岭县', '740', '3');
INSERT INTO `cx_area` VALUES ('839', '调兵山市', '740', '3');
INSERT INTO `cx_area` VALUES ('840', '清河区', '740', '3');
INSERT INTO `cx_area` VALUES ('841', '银州区', '740', '3');
INSERT INTO `cx_area` VALUES ('842', '凌源市', '741', '3');
INSERT INTO `cx_area` VALUES ('843', '北票市', '741', '3');
INSERT INTO `cx_area` VALUES ('844', '喀喇沁左翼蒙古自治县', '741', '3');
INSERT INTO `cx_area` VALUES ('845', '朝阳县', '741', '3');
INSERT INTO `cx_area` VALUES ('846', '建平县', '741', '3');
INSERT INTO `cx_area` VALUES ('847', '双塔区', '741', '3');
INSERT INTO `cx_area` VALUES ('848', '龙城区', '741', '3');
INSERT INTO `cx_area` VALUES ('849', '海城市内', '742', '3');
INSERT INTO `cx_area` VALUES ('850', '吉林', '0', '1');
INSERT INTO `cx_area` VALUES ('864', '南关区', '851', '3');
INSERT INTO `cx_area` VALUES ('865', '二道区', '851', '3');
INSERT INTO `cx_area` VALUES ('866', '绿园区', '851', '3');
INSERT INTO `cx_area` VALUES ('867', '朝阳区', '851', '3');
INSERT INTO `cx_area` VALUES ('868', '高新区', '851', '3');
INSERT INTO `cx_area` VALUES ('869', '宽城区', '851', '3');
INSERT INTO `cx_area` VALUES ('870', '经济技术开发区', '851', '3');
INSERT INTO `cx_area` VALUES ('871', '汽车产业开发区', '851', '3');
INSERT INTO `cx_area` VALUES ('872', '德惠市', '851', '3');
INSERT INTO `cx_area` VALUES ('873', '榆树市', '851', '3');
INSERT INTO `cx_area` VALUES ('874', '九台市', '851', '3');
INSERT INTO `cx_area` VALUES ('875', '农安县', '851', '3');
INSERT INTO `cx_area` VALUES ('876', '双阳区', '851', '3');
INSERT INTO `cx_area` VALUES ('877', '净月开发区', '851', '3');
INSERT INTO `cx_area` VALUES ('878', '舒兰市', '852', '3');
INSERT INTO `cx_area` VALUES ('879', '桦甸市', '852', '3');
INSERT INTO `cx_area` VALUES ('880', '蛟河市', '852', '3');
INSERT INTO `cx_area` VALUES ('881', '磐石市', '852', '3');
INSERT INTO `cx_area` VALUES ('882', '永吉县', '852', '3');
INSERT INTO `cx_area` VALUES ('883', '丰满区', '852', '3');
INSERT INTO `cx_area` VALUES ('884', '昌邑区', '852', '3');
INSERT INTO `cx_area` VALUES ('885', '龙潭区', '852', '3');
INSERT INTO `cx_area` VALUES ('886', '船营区', '852', '3');
INSERT INTO `cx_area` VALUES ('887', '公主岭市', '853', '3');
INSERT INTO `cx_area` VALUES ('888', '双辽市', '853', '3');
INSERT INTO `cx_area` VALUES ('889', '梨树县', '853', '3');
INSERT INTO `cx_area` VALUES ('890', '铁西区', '853', '3');
INSERT INTO `cx_area` VALUES ('891', '伊通满族自治县', '853', '3');
INSERT INTO `cx_area` VALUES ('892', '铁东区', '853', '3');
INSERT INTO `cx_area` VALUES ('893', '梅河口市', '854', '3');
INSERT INTO `cx_area` VALUES ('894', '集安市', '854', '3');
INSERT INTO `cx_area` VALUES ('895', '通化县', '854', '3');
INSERT INTO `cx_area` VALUES ('896', '辉南县', '854', '3');
INSERT INTO `cx_area` VALUES ('897', '柳河县', '854', '3');
INSERT INTO `cx_area` VALUES ('898', '二道江区', '854', '3');
INSERT INTO `cx_area` VALUES ('899', '东昌区', '854', '3');
INSERT INTO `cx_area` VALUES ('900', '临江市', '855', '3');
INSERT INTO `cx_area` VALUES ('901', '江源区', '855', '3');
INSERT INTO `cx_area` VALUES ('902', '浑江区', '855', '3');
INSERT INTO `cx_area` VALUES ('903', '靖宇县', '855', '3');
INSERT INTO `cx_area` VALUES ('904', '抚松县', '855', '3');
INSERT INTO `cx_area` VALUES ('905', '长白朝鲜族自治县', '855', '3');
INSERT INTO `cx_area` VALUES ('906', '乾安县', '856', '3');
INSERT INTO `cx_area` VALUES ('907', '长岭县', '856', '3');
INSERT INTO `cx_area` VALUES ('908', '扶余县', '856', '3');
INSERT INTO `cx_area` VALUES ('909', '前郭尔罗斯蒙古族自治县', '856', '3');
INSERT INTO `cx_area` VALUES ('910', '宁江区', '856', '3');
INSERT INTO `cx_area` VALUES ('911', '大安市', '857', '3');
INSERT INTO `cx_area` VALUES ('912', '洮南市', '857', '3');
INSERT INTO `cx_area` VALUES ('913', '通榆县', '857', '3');
INSERT INTO `cx_area` VALUES ('914', '镇赍市', '857', '3');
INSERT INTO `cx_area` VALUES ('915', '洮北区', '857', '3');
INSERT INTO `cx_area` VALUES ('916', '延吉市', '858', '3');
INSERT INTO `cx_area` VALUES ('917', '图们市', '858', '3');
INSERT INTO `cx_area` VALUES ('918', '敦化市', '858', '3');
INSERT INTO `cx_area` VALUES ('919', '珲春市', '858', '3');
INSERT INTO `cx_area` VALUES ('920', '龙井市', '858', '3');
INSERT INTO `cx_area` VALUES ('921', '和龙市', '858', '3');
INSERT INTO `cx_area` VALUES ('922', '汪清县', '858', '3');
INSERT INTO `cx_area` VALUES ('923', '安图县', '858', '3');
INSERT INTO `cx_area` VALUES ('924', '图们市', '859', '3');
INSERT INTO `cx_area` VALUES ('925', '敦化市', '859', '3');
INSERT INTO `cx_area` VALUES ('926', '珲春市', '859', '3');
INSERT INTO `cx_area` VALUES ('927', '龙井市', '859', '3');
INSERT INTO `cx_area` VALUES ('928', '和龙市', '859', '3');
INSERT INTO `cx_area` VALUES ('929', '汪清县', '859', '3');
INSERT INTO `cx_area` VALUES ('930', '安图县', '859', '3');
INSERT INTO `cx_area` VALUES ('931', '延吉市区内', '859', '3');
INSERT INTO `cx_area` VALUES ('932', '公主岭市市区', '860', '3');
INSERT INTO `cx_area` VALUES ('933', '龙山区', '861', '3');
INSERT INTO `cx_area` VALUES ('934', '西安区', '861', '3');
INSERT INTO `cx_area` VALUES ('935', '东丰县', '861', '3');
INSERT INTO `cx_area` VALUES ('936', '东辽县', '861', '3');
INSERT INTO `cx_area` VALUES ('937', '珲春市', '862', '3');
INSERT INTO `cx_area` VALUES ('938', '集安市', '863', '3');
INSERT INTO `cx_area` VALUES ('939', '黑龙江', '0', '1');
INSERT INTO `cx_area` VALUES ('955', '道里区', '940', '3');
INSERT INTO `cx_area` VALUES ('956', '南岗区', '940', '3');
INSERT INTO `cx_area` VALUES ('957', '道外区', '940', '3');
INSERT INTO `cx_area` VALUES ('958', '香坊区', '940', '3');
INSERT INTO `cx_area` VALUES ('959', '平房区', '940', '3');
INSERT INTO `cx_area` VALUES ('960', '经济技术开发区', '940', '3');
INSERT INTO `cx_area` VALUES ('961', '阿城区', '940', '3');
INSERT INTO `cx_area` VALUES ('962', '尚志市', '940', '3');
INSERT INTO `cx_area` VALUES ('963', '双城市', '940', '3');
INSERT INTO `cx_area` VALUES ('964', '五常市', '940', '3');
INSERT INTO `cx_area` VALUES ('965', '呼兰区', '940', '3');
INSERT INTO `cx_area` VALUES ('966', '方正县', '940', '3');
INSERT INTO `cx_area` VALUES ('967', '宾县', '940', '3');
INSERT INTO `cx_area` VALUES ('968', '依兰县', '940', '3');
INSERT INTO `cx_area` VALUES ('969', '巴彦县', '940', '3');
INSERT INTO `cx_area` VALUES ('970', '通河县', '940', '3');
INSERT INTO `cx_area` VALUES ('971', '木兰县', '940', '3');
INSERT INTO `cx_area` VALUES ('972', '延寿县', '940', '3');
INSERT INTO `cx_area` VALUES ('973', '梅里斯达翰尔族区', '941', '3');
INSERT INTO `cx_area` VALUES ('974', '昂昂溪区', '941', '3');
INSERT INTO `cx_area` VALUES ('975', '富拉尔基区', '941', '3');
INSERT INTO `cx_area` VALUES ('976', '碾子山区', '941', '3');
INSERT INTO `cx_area` VALUES ('977', '讷河市', '941', '3');
INSERT INTO `cx_area` VALUES ('978', '富裕县', '941', '3');
INSERT INTO `cx_area` VALUES ('979', '拜泉县', '941', '3');
INSERT INTO `cx_area` VALUES ('980', '甘南县', '941', '3');
INSERT INTO `cx_area` VALUES ('981', '依安县', '941', '3');
INSERT INTO `cx_area` VALUES ('982', '克山县', '941', '3');
INSERT INTO `cx_area` VALUES ('983', '龙江县', '941', '3');
INSERT INTO `cx_area` VALUES ('984', '克东县', '941', '3');
INSERT INTO `cx_area` VALUES ('985', '泰来县', '941', '3');
INSERT INTO `cx_area` VALUES ('986', '建华区', '941', '3');
INSERT INTO `cx_area` VALUES ('987', '龙沙区', '941', '3');
INSERT INTO `cx_area` VALUES ('988', '铁风区', '941', '3');
INSERT INTO `cx_area` VALUES ('989', '萝北县', '942', '3');
INSERT INTO `cx_area` VALUES ('990', '绥滨县', '942', '3');
INSERT INTO `cx_area` VALUES ('991', '兴山区', '942', '3');
INSERT INTO `cx_area` VALUES ('992', '向阳区', '942', '3');
INSERT INTO `cx_area` VALUES ('993', '工农区', '942', '3');
INSERT INTO `cx_area` VALUES ('994', '南山区', '942', '3');
INSERT INTO `cx_area` VALUES ('995', '兴安区', '942', '3');
INSERT INTO `cx_area` VALUES ('996', '东山区', '942', '3');
INSERT INTO `cx_area` VALUES ('997', '集贤县', '943', '3');
INSERT INTO `cx_area` VALUES ('998', '宝清县', '943', '3');
INSERT INTO `cx_area` VALUES ('999', '友谊县', '943', '3');
INSERT INTO `cx_area` VALUES ('1000', '饶河县', '943', '3');
INSERT INTO `cx_area` VALUES ('1001', '尖山区', '943', '3');
INSERT INTO `cx_area` VALUES ('1002', '岭东区', '943', '3');
INSERT INTO `cx_area` VALUES ('1003', '四方台区', '943', '3');
INSERT INTO `cx_area` VALUES ('1004', '宝山区', '943', '3');
INSERT INTO `cx_area` VALUES ('1005', '密山市', '944', '3');
INSERT INTO `cx_area` VALUES ('1006', '虎林市', '944', '3');
INSERT INTO `cx_area` VALUES ('1007', '鸡东县', '944', '3');
INSERT INTO `cx_area` VALUES ('1008', '鸡冠区', '944', '3');
INSERT INTO `cx_area` VALUES ('1009', '恒山区', '944', '3');
INSERT INTO `cx_area` VALUES ('1010', '滴道区', '944', '3');
INSERT INTO `cx_area` VALUES ('1011', '梨树区', '944', '3');
INSERT INTO `cx_area` VALUES ('1012', '城子河区', '944', '3');
INSERT INTO `cx_area` VALUES ('1013', '麻山区', '944', '3');
INSERT INTO `cx_area` VALUES ('1014', '萨尔图区', '945', '3');
INSERT INTO `cx_area` VALUES ('1015', '龙凤区', '945', '3');
INSERT INTO `cx_area` VALUES ('1016', '让胡路区', '945', '3');
INSERT INTO `cx_area` VALUES ('1017', '红岗区', '945', '3');
INSERT INTO `cx_area` VALUES ('1018', '大同区', '945', '3');
INSERT INTO `cx_area` VALUES ('1019', '林甸县', '945', '3');
INSERT INTO `cx_area` VALUES ('1020', '肇州县', '945', '3');
INSERT INTO `cx_area` VALUES ('1021', '肇源县', '945', '3');
INSERT INTO `cx_area` VALUES ('1022', '杜尔伯特蒙古族', '945', '3');
INSERT INTO `cx_area` VALUES ('1023', '铁力市', '946', '3');
INSERT INTO `cx_area` VALUES ('1024', '嘉荫县', '946', '3');
INSERT INTO `cx_area` VALUES ('1025', '伊春区', '946', '3');
INSERT INTO `cx_area` VALUES ('1026', '南岔区', '946', '3');
INSERT INTO `cx_area` VALUES ('1027', '友好区', '946', '3');
INSERT INTO `cx_area` VALUES ('1028', '西林区', '946', '3');
INSERT INTO `cx_area` VALUES ('1029', '翠峦区', '946', '3');
INSERT INTO `cx_area` VALUES ('1030', '新青区', '946', '3');
INSERT INTO `cx_area` VALUES ('1031', '美溪区', '946', '3');
INSERT INTO `cx_area` VALUES ('1032', '金山屯区', '946', '3');
INSERT INTO `cx_area` VALUES ('1033', '五营区', '946', '3');
INSERT INTO `cx_area` VALUES ('1034', '乌马河区', '946', '3');
INSERT INTO `cx_area` VALUES ('1035', '汤旺河区', '946', '3');
INSERT INTO `cx_area` VALUES ('1036', '带岭区', '946', '3');
INSERT INTO `cx_area` VALUES ('1037', '乌伊岭区', '946', '3');
INSERT INTO `cx_area` VALUES ('1038', '红星区', '946', '3');
INSERT INTO `cx_area` VALUES ('1039', '上甘岭区', '946', '3');
INSERT INTO `cx_area` VALUES ('1040', '东风区', '946', '3');
INSERT INTO `cx_area` VALUES ('1041', '海林市', '947', '3');
INSERT INTO `cx_area` VALUES ('1042', '宁安市', '947', '3');
INSERT INTO `cx_area` VALUES ('1043', '穆棱市', '947', '3');
INSERT INTO `cx_area` VALUES ('1044', '林口县', '947', '3');
INSERT INTO `cx_area` VALUES ('1045', '东宁县', '947', '3');
INSERT INTO `cx_area` VALUES ('1046', '爱民区', '947', '3');
INSERT INTO `cx_area` VALUES ('1047', '东安区', '947', '3');
INSERT INTO `cx_area` VALUES ('1048', '阳明区', '947', '3');
INSERT INTO `cx_area` VALUES ('1049', '西安区', '947', '3');
INSERT INTO `cx_area` VALUES ('1050', '绥芬河市', '947', '3');
INSERT INTO `cx_area` VALUES ('1051', '同江市', '948', '3');
INSERT INTO `cx_area` VALUES ('1052', '富锦市', '948', '3');
INSERT INTO `cx_area` VALUES ('1053', '桦川县', '948', '3');
INSERT INTO `cx_area` VALUES ('1054', '抚远县', '948', '3');
INSERT INTO `cx_area` VALUES ('1055', '桦南县', '948', '3');
INSERT INTO `cx_area` VALUES ('1056', '汤原县', '948', '3');
INSERT INTO `cx_area` VALUES ('1057', '前进区', '948', '3');
INSERT INTO `cx_area` VALUES ('1058', '永红区', '948', '3');
INSERT INTO `cx_area` VALUES ('1059', '向阳区', '948', '3');
INSERT INTO `cx_area` VALUES ('1060', '郊区', '948', '3');
INSERT INTO `cx_area` VALUES ('1061', '勃利县', '949', '3');
INSERT INTO `cx_area` VALUES ('1062', '桃山区', '949', '3');
INSERT INTO `cx_area` VALUES ('1063', '新兴区', '949', '3');
INSERT INTO `cx_area` VALUES ('1064', '茄子河区', '949', '3');
INSERT INTO `cx_area` VALUES ('1065', '北安市', '950', '3');
INSERT INTO `cx_area` VALUES ('1066', '五大连池市', '950', '3');
INSERT INTO `cx_area` VALUES ('1067', '逊克县', '950', '3');
INSERT INTO `cx_area` VALUES ('1068', '孙吴县', '950', '3');
INSERT INTO `cx_area` VALUES ('1069', '黑河市区内', '950', '3');
INSERT INTO `cx_area` VALUES ('1070', '嫩江县', '950', '3');
INSERT INTO `cx_area` VALUES ('1071', '爱辉区', '950', '3');
INSERT INTO `cx_area` VALUES ('1072', '安达市', '951', '3');
INSERT INTO `cx_area` VALUES ('1073', '肇东市', '951', '3');
INSERT INTO `cx_area` VALUES ('1074', '海伦市', '951', '3');
INSERT INTO `cx_area` VALUES ('1075', '绥棱县', '951', '3');
INSERT INTO `cx_area` VALUES ('1076', '兰西县', '951', '3');
INSERT INTO `cx_area` VALUES ('1077', '明水县', '951', '3');
INSERT INTO `cx_area` VALUES ('1078', '青冈县', '951', '3');
INSERT INTO `cx_area` VALUES ('1079', '庆安县', '951', '3');
INSERT INTO `cx_area` VALUES ('1080', '望奎县', '951', '3');
INSERT INTO `cx_area` VALUES ('1081', '北林区', '951', '3');
INSERT INTO `cx_area` VALUES ('1082', '呼玛县', '952', '3');
INSERT INTO `cx_area` VALUES ('1083', '塔河县', '952', '3');
INSERT INTO `cx_area` VALUES ('1084', '漠河县', '952', '3');
INSERT INTO `cx_area` VALUES ('1085', '加格达奇区', '952', '3');
INSERT INTO `cx_area` VALUES ('1086', '松岭区', '952', '3');
INSERT INTO `cx_area` VALUES ('1087', '呼中区', '952', '3');
INSERT INTO `cx_area` VALUES ('1088', '铁力市区内', '953', '3');
INSERT INTO `cx_area` VALUES ('1089', '北安市', '954', '3');
INSERT INTO `cx_area` VALUES ('1090', '内蒙古', '0', '1');
INSERT INTO `cx_area` VALUES ('1104', '回民区', '1091', '3');
INSERT INTO `cx_area` VALUES ('1105', '新城区', '1091', '3');
INSERT INTO `cx_area` VALUES ('1106', '玉泉区', '1091', '3');
INSERT INTO `cx_area` VALUES ('1107', '赛罕区', '1091', '3');
INSERT INTO `cx_area` VALUES ('1108', '土默特左旗', '1091', '3');
INSERT INTO `cx_area` VALUES ('1109', '和林格尔县', '1091', '3');
INSERT INTO `cx_area` VALUES ('1110', '武川县', '1091', '3');
INSERT INTO `cx_area` VALUES ('1111', '托克托县', '1091', '3');
INSERT INTO `cx_area` VALUES ('1112', '清水河县', '1091', '3');
INSERT INTO `cx_area` VALUES ('1113', '固阳县', '1092', '3');
INSERT INTO `cx_area` VALUES ('1114', '土默特右旗', '1092', '3');
INSERT INTO `cx_area` VALUES ('1115', '达尔罕茂明安联合旗', '1092', '3');
INSERT INTO `cx_area` VALUES ('1116', '昆都仑区', '1092', '3');
INSERT INTO `cx_area` VALUES ('1117', '东河区', '1092', '3');
INSERT INTO `cx_area` VALUES ('1118', '青山区', '1092', '3');
INSERT INTO `cx_area` VALUES ('1119', '石拐区', '1092', '3');
INSERT INTO `cx_area` VALUES ('1120', '白云矿区', '1092', '3');
INSERT INTO `cx_area` VALUES ('1121', '九原区', '1092', '3');
INSERT INTO `cx_area` VALUES ('1122', '海勃湾区', '1093', '3');
INSERT INTO `cx_area` VALUES ('1123', '海南区', '1093', '3');
INSERT INTO `cx_area` VALUES ('1124', '乌达区', '1093', '3');
INSERT INTO `cx_area` VALUES ('1125', '宁城县', '1094', '3');
INSERT INTO `cx_area` VALUES ('1126', '敖汉旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1127', '喀喇沁旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1128', '翁牛特旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1129', '巴林右旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1130', '林西县', '1094', '3');
INSERT INTO `cx_area` VALUES ('1131', '克什克腾旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1132', '巴林左旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1133', '阿鲁科尔沁旗', '1094', '3');
INSERT INTO `cx_area` VALUES ('1134', '元宝山区', '1094', '3');
INSERT INTO `cx_area` VALUES ('1135', '红山区', '1094', '3');
INSERT INTO `cx_area` VALUES ('1136', '松山区', '1094', '3');
INSERT INTO `cx_area` VALUES ('1137', '集宁区', '1095', '3');
INSERT INTO `cx_area` VALUES ('1138', '丰镇市', '1095', '3');
INSERT INTO `cx_area` VALUES ('1139', '兴和县', '1095', '3');
INSERT INTO `cx_area` VALUES ('1140', '卓资县', '1095', '3');
INSERT INTO `cx_area` VALUES ('1141', '商都县', '1095', '3');
INSERT INTO `cx_area` VALUES ('1142', '凉城县', '1095', '3');
INSERT INTO `cx_area` VALUES ('1143', '化德县', '1095', '3');
INSERT INTO `cx_area` VALUES ('1144', '察哈尔右翼前旗', '1095', '3');
INSERT INTO `cx_area` VALUES ('1145', '察哈尔右翼中旗', '1095', '3');
INSERT INTO `cx_area` VALUES ('1146', '察哈尔右翼后旗', '1095', '3');
INSERT INTO `cx_area` VALUES ('1147', '四子王旗', '1095', '3');
INSERT INTO `cx_area` VALUES ('1148', '锡林浩特市', '1096', '3');
INSERT INTO `cx_area` VALUES ('1149', '二连浩特市', '1096', '3');
INSERT INTO `cx_area` VALUES ('1150', '多伦县', '1096', '3');
INSERT INTO `cx_area` VALUES ('1151', '阿巴嘎旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1152', '西乌珠穆沁旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1153', '东乌珠穆沁旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1154', '苏尼特右旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1155', '苏尼特左旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1156', '太仆寺旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1157', '正镶白旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1158', '正蓝旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1159', '镶黄旗', '1096', '3');
INSERT INTO `cx_area` VALUES ('1160', '海拉尔市', '1097', '3');
INSERT INTO `cx_area` VALUES ('1161', '满洲里市', '1097', '3');
INSERT INTO `cx_area` VALUES ('1162', '牙克石市', '1097', '3');
INSERT INTO `cx_area` VALUES ('1163', '扎兰屯市', '1097', '3');
INSERT INTO `cx_area` VALUES ('1164', '根河市', '1097', '3');
INSERT INTO `cx_area` VALUES ('1165', '额尔古纳市', '1097', '3');
INSERT INTO `cx_area` VALUES ('1166', '陈巴尔虎旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1167', '阿荣旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1168', '新巴尔虎左旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1169', '新巴尔虎右旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1170', '鄂伦春自治旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1171', '莫力达瓦达翰尔族自治旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1172', '鄂温克族自治旗', '1097', '3');
INSERT INTO `cx_area` VALUES ('1173', '霍林郭勒市', '1098', '3');
INSERT INTO `cx_area` VALUES ('1174', '科尔沁左翼中旗', '1098', '3');
INSERT INTO `cx_area` VALUES ('1175', '科尔沁左翼后旗', '1098', '3');
INSERT INTO `cx_area` VALUES ('1176', '库伦旗', '1098', '3');
INSERT INTO `cx_area` VALUES ('1177', '奈曼旗', '1098', '3');
INSERT INTO `cx_area` VALUES ('1178', '东胜区', '1099', '3');
INSERT INTO `cx_area` VALUES ('1179', '准格尔旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1180', '伊金霍洛旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1181', '乌审旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1182', '杭锦旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1183', '鄂托克旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1184', '鄂托克前旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1185', '达拉特旗', '1099', '3');
INSERT INTO `cx_area` VALUES ('1186', '临河区', '1100', '3');
INSERT INTO `cx_area` VALUES ('1187', '五原县', '1100', '3');
INSERT INTO `cx_area` VALUES ('1188', '磴口县', '1100', '3');
INSERT INTO `cx_area` VALUES ('1189', '杭锦后旗', '1100', '3');
INSERT INTO `cx_area` VALUES ('1190', '乌拉特中旗', '1100', '3');
INSERT INTO `cx_area` VALUES ('1191', '乌拉特后旗', '1100', '3');
INSERT INTO `cx_area` VALUES ('1192', '乌拉特前旗', '1100', '3');
INSERT INTO `cx_area` VALUES ('1193', '阿拉善右旗', '1101', '3');
INSERT INTO `cx_area` VALUES ('1194', '阿拉善左旗', '1101', '3');
INSERT INTO `cx_area` VALUES ('1195', '额济纳旗', '1101', '3');
INSERT INTO `cx_area` VALUES ('1196', '乌兰浩特市', '1102', '3');
INSERT INTO `cx_area` VALUES ('1197', '阿尔山市', '1102', '3');
INSERT INTO `cx_area` VALUES ('1198', '突泉县', '1102', '3');
INSERT INTO `cx_area` VALUES ('1199', '扎赍特旗', '1102', '3');
INSERT INTO `cx_area` VALUES ('1200', '科尔沁右翼前期', '1102', '3');
INSERT INTO `cx_area` VALUES ('1201', '科尔沁右翼中旗', '1102', '3');
INSERT INTO `cx_area` VALUES ('1202', '科尔沁区', '1103', '3');
INSERT INTO `cx_area` VALUES ('1203', '霍林郭勒市', '1103', '3');
INSERT INTO `cx_area` VALUES ('1204', '开鲁县', '1103', '3');
INSERT INTO `cx_area` VALUES ('1205', '库伦旗', '1103', '3');
INSERT INTO `cx_area` VALUES ('1206', '奈曼旗', '1103', '3');
INSERT INTO `cx_area` VALUES ('1207', '扎鲁特旗', '1103', '3');
INSERT INTO `cx_area` VALUES ('1208', '科尔沁左翼中旗', '1103', '3');
INSERT INTO `cx_area` VALUES ('1209', '科尔沁左翼后旗', '1103', '3');
INSERT INTO `cx_area` VALUES ('1210', '江苏', '0', '1');
INSERT INTO `cx_area` VALUES ('1224', '玄武区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1225', '白下区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1226', '秦淮区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1227', '鼓楼区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1228', '下关区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1229', '雨花台区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1230', '六合区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1231', '建邺区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1232', '浦口区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1233', '栖霞区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1234', '江宁区', '1211', '3');
INSERT INTO `cx_area` VALUES ('1235', '高淳县', '1211', '3');
INSERT INTO `cx_area` VALUES ('1236', '溧水县', '1211', '3');
INSERT INTO `cx_area` VALUES ('1237', '云龙区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1238', '鼓楼区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1239', '泉山区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1240', '贾汪区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1241', '邳州区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1242', '新沂市', '1212', '3');
INSERT INTO `cx_area` VALUES ('1243', '铜山县', '1212', '3');
INSERT INTO `cx_area` VALUES ('1244', '睢宁县', '1212', '3');
INSERT INTO `cx_area` VALUES ('1245', '沛县', '1212', '3');
INSERT INTO `cx_area` VALUES ('1246', '丰县', '1212', '3');
INSERT INTO `cx_area` VALUES ('1247', '金山桥开发区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1248', '铜山经济技术开发区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1249', '镇集镇', '1212', '3');
INSERT INTO `cx_area` VALUES ('1250', '大吴镇', '1212', '3');
INSERT INTO `cx_area` VALUES ('1251', '大庙镇', '1212', '3');
INSERT INTO `cx_area` VALUES ('1252', '八段工业园区', '1212', '3');
INSERT INTO `cx_area` VALUES ('1253', '柳新镇', '1212', '3');
INSERT INTO `cx_area` VALUES ('1254', '海州区', '1213', '3');
INSERT INTO `cx_area` VALUES ('1255', '新浦区', '1213', '3');
INSERT INTO `cx_area` VALUES ('1256', '连云区', '1213', '3');
INSERT INTO `cx_area` VALUES ('1257', '赣榆县', '1213', '3');
INSERT INTO `cx_area` VALUES ('1258', '灌云县', '1213', '3');
INSERT INTO `cx_area` VALUES ('1259', '东海县', '1213', '3');
INSERT INTO `cx_area` VALUES ('1260', '灌南县', '1213', '3');
INSERT INTO `cx_area` VALUES ('1261', '清河区', '1214', '3');
INSERT INTO `cx_area` VALUES ('1262', '淮阴区', '1214', '3');
INSERT INTO `cx_area` VALUES ('1263', '经济开发区', '1214', '3');
INSERT INTO `cx_area` VALUES ('1264', '清浦区', '1214', '3');
INSERT INTO `cx_area` VALUES ('1265', '楚州区', '1214', '3');
INSERT INTO `cx_area` VALUES ('1266', '涟水县', '1214', '3');
INSERT INTO `cx_area` VALUES ('1267', '洪泽县', '1214', '3');
INSERT INTO `cx_area` VALUES ('1268', '金湖县', '1214', '3');
INSERT INTO `cx_area` VALUES ('1269', '盱眙县', '1214', '3');
INSERT INTO `cx_area` VALUES ('1270', '宿城新区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1271', '宿迁市区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1272', '宿豫开发区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1273', '宿城开发区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1274', '宿豫区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1275', '宿城区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1276', '宿迁开发区', '1215', '3');
INSERT INTO `cx_area` VALUES ('1277', '沭阳县', '1215', '3');
INSERT INTO `cx_area` VALUES ('1278', '泗阳县', '1215', '3');
INSERT INTO `cx_area` VALUES ('1279', '泗洪县', '1215', '3');
INSERT INTO `cx_area` VALUES ('1280', '双庄街', '1215', '3');
INSERT INTO `cx_area` VALUES ('1281', '三树街', '1215', '3');
INSERT INTO `cx_area` VALUES ('1282', '卓圩街', '1215', '3');
INSERT INTO `cx_area` VALUES ('1283', '盐都区', '1216', '3');
INSERT INTO `cx_area` VALUES ('1284', '亭湖区', '1216', '3');
INSERT INTO `cx_area` VALUES ('1285', '东台市', '1216', '3');
INSERT INTO `cx_area` VALUES ('1286', '大丰市', '1216', '3');
INSERT INTO `cx_area` VALUES ('1287', '建湖县', '1216', '3');
INSERT INTO `cx_area` VALUES ('1288', '响水县', '1216', '3');
INSERT INTO `cx_area` VALUES ('1289', '射阳县', '1216', '3');
INSERT INTO `cx_area` VALUES ('1290', '阜宁县', '1216', '3');
INSERT INTO `cx_area` VALUES ('1291', '滨海县', '1216', '3');
INSERT INTO `cx_area` VALUES ('1292', '广陵区', '1217', '3');
INSERT INTO `cx_area` VALUES ('1293', '邗江区', '1217', '3');
INSERT INTO `cx_area` VALUES ('1294', '维扬区', '1217', '3');
INSERT INTO `cx_area` VALUES ('1295', '宝应县', '1217', '3');
INSERT INTO `cx_area` VALUES ('1296', '高邮市', '1217', '3');
INSERT INTO `cx_area` VALUES ('1297', '江都市', '1217', '3');
INSERT INTO `cx_area` VALUES ('1298', '仪征市', '1217', '3');
INSERT INTO `cx_area` VALUES ('1299', '海陵区', '1218', '3');
INSERT INTO `cx_area` VALUES ('1300', '泰兴市', '1218', '3');
INSERT INTO `cx_area` VALUES ('1301', '姜堰市', '1218', '3');
INSERT INTO `cx_area` VALUES ('1302', '靖江市', '1218', '3');
INSERT INTO `cx_area` VALUES ('1303', '兴化市', '1218', '3');
INSERT INTO `cx_area` VALUES ('1304', '高港区', '1218', '3');
INSERT INTO `cx_area` VALUES ('1305', '通州区', '1219', '3');
INSERT INTO `cx_area` VALUES ('1306', '崇川区', '1219', '3');
INSERT INTO `cx_area` VALUES ('1307', '港闸区', '1219', '3');
INSERT INTO `cx_area` VALUES ('1308', '南通经济技术开发区', '1219', '3');
INSERT INTO `cx_area` VALUES ('1309', '通州区', '1219', '3');
INSERT INTO `cx_area` VALUES ('1310', '如皋市', '1219', '3');
INSERT INTO `cx_area` VALUES ('1311', '开发区', '1219', '3');
INSERT INTO `cx_area` VALUES ('1312', '海门市', '1219', '3');
INSERT INTO `cx_area` VALUES ('1313', '启东市', '1219', '3');
INSERT INTO `cx_area` VALUES ('1314', '如东县', '1219', '3');
INSERT INTO `cx_area` VALUES ('1315', '海安县', '1219', '3');
INSERT INTO `cx_area` VALUES ('1316', '丹徒区', '1220', '3');
INSERT INTO `cx_area` VALUES ('1317', '润州区', '1220', '3');
INSERT INTO `cx_area` VALUES ('1318', '京口区', '1220', '3');
INSERT INTO `cx_area` VALUES ('1319', '扬中市', '1220', '3');
INSERT INTO `cx_area` VALUES ('1320', '丹阳市', '1220', '3');
INSERT INTO `cx_area` VALUES ('1321', '句容市', '1220', '3');
INSERT INTO `cx_area` VALUES ('1322', '钟楼区', '1221', '3');
INSERT INTO `cx_area` VALUES ('1323', '天宁区', '1221', '3');
INSERT INTO `cx_area` VALUES ('1324', '戚墅堰区', '1221', '3');
INSERT INTO `cx_area` VALUES ('1325', '新北区', '1221', '3');
INSERT INTO `cx_area` VALUES ('1326', '武进区', '1221', '3');
INSERT INTO `cx_area` VALUES ('1327', '溧阳市', '1221', '3');
INSERT INTO `cx_area` VALUES ('1328', '崇安区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1329', '南长区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1330', '北塘区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1331', '锡山区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1332', '新区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1333', '江阴市', '1222', '3');
INSERT INTO `cx_area` VALUES ('1334', '滨湖区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1335', '惠山区', '1222', '3');
INSERT INTO `cx_area` VALUES ('1336', '宜兴市', '1222', '3');
INSERT INTO `cx_area` VALUES ('1337', '常熟市', '1223', '3');
INSERT INTO `cx_area` VALUES ('1338', '平江市', '1223', '3');
INSERT INTO `cx_area` VALUES ('1339', '沧浪区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1340', '金阊区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1341', '工业园区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1342', '高新区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1343', '昆山市', '1223', '3');
INSERT INTO `cx_area` VALUES ('1344', '吴中区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1345', '相城区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1346', '太仓市', '1223', '3');
INSERT INTO `cx_area` VALUES ('1347', '虎丘区', '1223', '3');
INSERT INTO `cx_area` VALUES ('1348', '张家港市', '1223', '3');
INSERT INTO `cx_area` VALUES ('1349', '吴江市', '1223', '3');
INSERT INTO `cx_area` VALUES ('1350', '山东', '0', '1');
INSERT INTO `cx_area` VALUES ('1368', '历城区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1369', '天桥区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1370', '槐荫区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1371', '历下区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1372', '市中区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1373', '高新区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1374', '章丘市', '1351', '3');
INSERT INTO `cx_area` VALUES ('1375', '长清区', '1351', '3');
INSERT INTO `cx_area` VALUES ('1376', '平阴县', '1351', '3');
INSERT INTO `cx_area` VALUES ('1377', '济阳县', '1351', '3');
INSERT INTO `cx_area` VALUES ('1378', '商河县', '1351', '3');
INSERT INTO `cx_area` VALUES ('1379', '李沧区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1380', '胶州市', '1352', '3');
INSERT INTO `cx_area` VALUES ('1381', '胶南市', '1352', '3');
INSERT INTO `cx_area` VALUES ('1382', '平度市', '1352', '3');
INSERT INTO `cx_area` VALUES ('1383', '即墨市', '1352', '3');
INSERT INTO `cx_area` VALUES ('1384', '莱西市', '1352', '3');
INSERT INTO `cx_area` VALUES ('1385', '城阳区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1386', '崂山区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1387', '黄岛区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1388', '四方区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1389', '市北区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1390', '市南区', '1352', '3');
INSERT INTO `cx_area` VALUES ('1391', '高青县', '1353', '3');
INSERT INTO `cx_area` VALUES ('1392', '沂源县', '1353', '3');
INSERT INTO `cx_area` VALUES ('1393', '桓台县', '1353', '3');
INSERT INTO `cx_area` VALUES ('1394', '周村区', '1353', '3');
INSERT INTO `cx_area` VALUES ('1395', '淄川区', '1353', '3');
INSERT INTO `cx_area` VALUES ('1396', '博山区', '1353', '3');
INSERT INTO `cx_area` VALUES ('1397', '临淄区', '1353', '3');
INSERT INTO `cx_area` VALUES ('1398', '张店区', '1353', '3');
INSERT INTO `cx_area` VALUES ('1399', '滕州市', '1354', '3');
INSERT INTO `cx_area` VALUES ('1400', '山亭区', '1354', '3');
INSERT INTO `cx_area` VALUES ('1401', '台儿庄区', '1354', '3');
INSERT INTO `cx_area` VALUES ('1402', '峄城区', '1354', '3');
INSERT INTO `cx_area` VALUES ('1403', '薛城区', '1354', '3');
INSERT INTO `cx_area` VALUES ('1404', '市中区', '1354', '3');
INSERT INTO `cx_area` VALUES ('1405', '东营区', '1355', '3');
INSERT INTO `cx_area` VALUES ('1406', '河口区', '1355', '3');
INSERT INTO `cx_area` VALUES ('1407', '广饶县', '1355', '3');
INSERT INTO `cx_area` VALUES ('1408', '利津县', '1355', '3');
INSERT INTO `cx_area` VALUES ('1409', '垦利县', '1355', '3');
INSERT INTO `cx_area` VALUES ('1410', '青州市', '1356', '3');
INSERT INTO `cx_area` VALUES ('1411', '诸城市', '1356', '3');
INSERT INTO `cx_area` VALUES ('1412', '寿光市', '1356', '3');
INSERT INTO `cx_area` VALUES ('1413', '安丘市', '1356', '3');
INSERT INTO `cx_area` VALUES ('1414', '高密市', '1356', '3');
INSERT INTO `cx_area` VALUES ('1415', '昌邑市', '1356', '3');
INSERT INTO `cx_area` VALUES ('1416', '昌乐县', '1356', '3');
INSERT INTO `cx_area` VALUES ('1417', '临朐县', '1356', '3');
INSERT INTO `cx_area` VALUES ('1418', '奎文区', '1356', '3');
INSERT INTO `cx_area` VALUES ('1419', '坊子区', '1356', '3');
INSERT INTO `cx_area` VALUES ('1420', '寒亭区', '1356', '3');
INSERT INTO `cx_area` VALUES ('1421', '潍城区', '1356', '3');
INSERT INTO `cx_area` VALUES ('1422', '潍坊高新技术开发区', '1356', '3');
INSERT INTO `cx_area` VALUES ('1423', '福山区', '1357', '3');
INSERT INTO `cx_area` VALUES ('1424', '莱山区', '1357', '3');
INSERT INTO `cx_area` VALUES ('1425', '烟台开发区', '1357', '3');
INSERT INTO `cx_area` VALUES ('1426', '龙口市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1427', '莱阳市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1428', '莱州市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1429', '招远市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1430', '蓬莱市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1431', '栖霞市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1432', '海阳市', '1357', '3');
INSERT INTO `cx_area` VALUES ('1433', '长岛县', '1357', '3');
INSERT INTO `cx_area` VALUES ('1434', '牟平区', '1357', '3');
INSERT INTO `cx_area` VALUES ('1435', '芝罘区', '1357', '3');
INSERT INTO `cx_area` VALUES ('1436', '乳山市', '1358', '3');
INSERT INTO `cx_area` VALUES ('1437', '文登市', '1358', '3');
INSERT INTO `cx_area` VALUES ('1438', '荣成市', '1358', '3');
INSERT INTO `cx_area` VALUES ('1439', '环翠区', '1358', '3');
INSERT INTO `cx_area` VALUES ('1440', '高区', '1358', '3');
INSERT INTO `cx_area` VALUES ('1441', '经济技术开发区', '1358', '3');
INSERT INTO `cx_area` VALUES ('1442', '莱城区', '1359', '3');
INSERT INTO `cx_area` VALUES ('1443', '钢城区', '1359', '3');
INSERT INTO `cx_area` VALUES ('1444', '乐陵市', '1360', '3');
INSERT INTO `cx_area` VALUES ('1445', '禹城市', '1360', '3');
INSERT INTO `cx_area` VALUES ('1446', '陵县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1447', '宁津县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1448', '齐河县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1449', '武城县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1450', '庆云县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1451', '平原县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1452', '临邑县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1453', '夏津县', '1360', '3');
INSERT INTO `cx_area` VALUES ('1454', '德城区', '1360', '3');
INSERT INTO `cx_area` VALUES ('1455', '沂南县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1456', '沂水县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1457', '苍山县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1458', '费县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1459', '平邑县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1460', '蒙阴县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1461', '临沭县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1462', '河东区', '1361', '3');
INSERT INTO `cx_area` VALUES ('1463', '莒南县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1464', '郯城县', '1361', '3');
INSERT INTO `cx_area` VALUES ('1465', '罗庄区', '1361', '3');
INSERT INTO `cx_area` VALUES ('1466', '兰山区', '1361', '3');
INSERT INTO `cx_area` VALUES ('1467', '临清市', '1362', '3');
INSERT INTO `cx_area` VALUES ('1468', '东昌府区', '1362', '3');
INSERT INTO `cx_area` VALUES ('1469', '阳谷县', '1362', '3');
INSERT INTO `cx_area` VALUES ('1470', '荏平县', '1362', '3');
INSERT INTO `cx_area` VALUES ('1471', '莘县', '1362', '3');
INSERT INTO `cx_area` VALUES ('1472', '东阿县', '1362', '3');
INSERT INTO `cx_area` VALUES ('1473', '冠县', '1362', '3');
INSERT INTO `cx_area` VALUES ('1474', '高唐', '1362', '3');
INSERT INTO `cx_area` VALUES ('1475', '滨城区', '1363', '3');
INSERT INTO `cx_area` VALUES ('1476', '邹平县', '1363', '3');
INSERT INTO `cx_area` VALUES ('1477', '沾化县', '1363', '3');
INSERT INTO `cx_area` VALUES ('1478', '惠民县', '1363', '3');
INSERT INTO `cx_area` VALUES ('1479', '博兴县', '1363', '3');
INSERT INTO `cx_area` VALUES ('1480', '阳信县', '1363', '3');
INSERT INTO `cx_area` VALUES ('1481', '无棣县', '1363', '3');
INSERT INTO `cx_area` VALUES ('1482', '菏泽市', '1364', '3');
INSERT INTO `cx_area` VALUES ('1483', '单县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1484', '曹县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1485', '定陶县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1486', '巨野县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1487', '成武县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1488', '东明县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1489', '郓城县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1490', '鄄城县', '1364', '3');
INSERT INTO `cx_area` VALUES ('1491', '牡丹区', '1364', '3');
INSERT INTO `cx_area` VALUES ('1492', '东港区', '1365', '3');
INSERT INTO `cx_area` VALUES ('1493', '五莲县', '1365', '3');
INSERT INTO `cx_area` VALUES ('1494', '莒县', '1365', '3');
INSERT INTO `cx_area` VALUES ('1495', '岚山区', '1365', '3');
INSERT INTO `cx_area` VALUES ('1496', '新市区', '1365', '3');
INSERT INTO `cx_area` VALUES ('1497', '新泰市', '1366', '3');
INSERT INTO `cx_area` VALUES ('1498', '东平县', '1366', '3');
INSERT INTO `cx_area` VALUES ('1499', '宁阳县', '1366', '3');
INSERT INTO `cx_area` VALUES ('1500', '肥城市', '1366', '3');
INSERT INTO `cx_area` VALUES ('1501', '岱岳区', '1366', '3');
INSERT INTO `cx_area` VALUES ('1502', '泰山区', '1366', '3');
INSERT INTO `cx_area` VALUES ('1503', '邹城市', '1367', '3');
INSERT INTO `cx_area` VALUES ('1504', '梁山县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1505', '曲阜市', '1367', '3');
INSERT INTO `cx_area` VALUES ('1506', '兖州市', '1367', '3');
INSERT INTO `cx_area` VALUES ('1507', '济宁市', '1367', '3');
INSERT INTO `cx_area` VALUES ('1508', '微山县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1509', '汶上县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1510', '泗水县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1511', '嘉祥县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1512', '鱼台县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1513', '金乡县', '1367', '3');
INSERT INTO `cx_area` VALUES ('1514', '任城区', '1367', '3');
INSERT INTO `cx_area` VALUES ('1515', '市中区', '1367', '3');
INSERT INTO `cx_area` VALUES ('1516', '安徽', '0', '1');
INSERT INTO `cx_area` VALUES ('1537', '铜陵县', '1517', '3');
INSERT INTO `cx_area` VALUES ('1538', '郊区', '1517', '3');
INSERT INTO `cx_area` VALUES ('1539', '狮子山区', '1517', '3');
INSERT INTO `cx_area` VALUES ('1540', '铜官山区', '1517', '3');
INSERT INTO `cx_area` VALUES ('1541', '包河区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1542', '蜀山区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1543', '瑶海区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1544', '庐阳区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1545', '经济技术开发区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1546', '高新技术开发区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1547', '经济开发区', '1518', '3');
INSERT INTO `cx_area` VALUES ('1548', '长丰县', '1518', '3');
INSERT INTO `cx_area` VALUES ('1549', '肥西县', '1518', '3');
INSERT INTO `cx_area` VALUES ('1550', '肥东县', '1518', '3');
INSERT INTO `cx_area` VALUES ('1551', '凤台县', '1519', '3');
INSERT INTO `cx_area` VALUES ('1552', '田家庵区', '1519', '3');
INSERT INTO `cx_area` VALUES ('1553', '大通区', '1519', '3');
INSERT INTO `cx_area` VALUES ('1554', '谢家集区', '1519', '3');
INSERT INTO `cx_area` VALUES ('1555', '八公山区', '1519', '3');
INSERT INTO `cx_area` VALUES ('1556', '潘集区', '1519', '3');
INSERT INTO `cx_area` VALUES ('1557', '濉溪县', '1520', '3');
INSERT INTO `cx_area` VALUES ('1558', '烈山区', '1520', '3');
INSERT INTO `cx_area` VALUES ('1559', '杜集区', '1520', '3');
INSERT INTO `cx_area` VALUES ('1560', '相山区', '1520', '3');
INSERT INTO `cx_area` VALUES ('1561', '镜湖区', '1521', '3');
INSERT INTO `cx_area` VALUES ('1562', '弋江区', '1521', '3');
INSERT INTO `cx_area` VALUES ('1563', '鸠江区', '1521', '3');
INSERT INTO `cx_area` VALUES ('1564', '新芜区', '1521', '3');
INSERT INTO `cx_area` VALUES ('1565', '马塘区', '1521', '3');
INSERT INTO `cx_area` VALUES ('1566', '芜湖县', '1521', '3');
INSERT INTO `cx_area` VALUES ('1567', '繁昌县', '1521', '3');
INSERT INTO `cx_area` VALUES ('1568', '南陵县', '1521', '3');
INSERT INTO `cx_area` VALUES ('1569', '淮上区', '1522', '3');
INSERT INTO `cx_area` VALUES ('1570', '禹会区', '1522', '3');
INSERT INTO `cx_area` VALUES ('1571', '龙子湖区', '1522', '3');
INSERT INTO `cx_area` VALUES ('1572', '怀远县', '1522', '3');
INSERT INTO `cx_area` VALUES ('1573', '固镇县', '1522', '3');
INSERT INTO `cx_area` VALUES ('1574', '五河县', '1522', '3');
INSERT INTO `cx_area` VALUES ('1575', '金家庄区', '1523', '3');
INSERT INTO `cx_area` VALUES ('1576', '花山区', '1523', '3');
INSERT INTO `cx_area` VALUES ('1577', '雨山区', '1523', '3');
INSERT INTO `cx_area` VALUES ('1578', '当涂县', '1523', '3');
INSERT INTO `cx_area` VALUES ('1579', '当涂县', '1524', '3');
INSERT INTO `cx_area` VALUES ('1580', '宜秀区', '1525', '3');
INSERT INTO `cx_area` VALUES ('1581', '大观区', '1525', '3');
INSERT INTO `cx_area` VALUES ('1582', '迎江区', '1525', '3');
INSERT INTO `cx_area` VALUES ('1583', '安庆市开发区', '1525', '3');
INSERT INTO `cx_area` VALUES ('1584', '桐城市', '1525', '3');
INSERT INTO `cx_area` VALUES ('1585', '宿松县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1586', '枞阳县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1587', '太湖县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1588', '怀宁县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1589', '岳西县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1590', '望江县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1591', '潜山县', '1525', '3');
INSERT INTO `cx_area` VALUES ('1592', '郊区', '1525', '3');
INSERT INTO `cx_area` VALUES ('1593', '休宁县', '1526', '3');
INSERT INTO `cx_area` VALUES ('1594', '歙县', '1526', '3');
INSERT INTO `cx_area` VALUES ('1595', '黟县', '1526', '3');
INSERT INTO `cx_area` VALUES ('1596', '祁门县', '1526', '3');
INSERT INTO `cx_area` VALUES ('1597', '屯溪区', '1526', '3');
INSERT INTO `cx_area` VALUES ('1599', '徽州区', '1526', '3');
INSERT INTO `cx_area` VALUES ('1600', '琅琊区', '1527', '3');
INSERT INTO `cx_area` VALUES ('1601', '南谯区', '1527', '3');
INSERT INTO `cx_area` VALUES ('1602', '天长市', '1527', '3');
INSERT INTO `cx_area` VALUES ('1603', '明光市', '1527', '3');
INSERT INTO `cx_area` VALUES ('1604', '全椒县', '1527', '3');
INSERT INTO `cx_area` VALUES ('1605', '来安县', '1527', '3');
INSERT INTO `cx_area` VALUES ('1606', '定远县', '1527', '3');
INSERT INTO `cx_area` VALUES ('1607', '凤阳县', '1527', '3');
INSERT INTO `cx_area` VALUES ('1608', '颍州区', '1528', '3');
INSERT INTO `cx_area` VALUES ('1609', '颍东区', '1528', '3');
INSERT INTO `cx_area` VALUES ('1610', '颍泉区', '1528', '3');
INSERT INTO `cx_area` VALUES ('1611', '阜阳经济技术开发区', '1528', '3');
INSERT INTO `cx_area` VALUES ('1612', '界首市', '1528', '3');
INSERT INTO `cx_area` VALUES ('1613', '太和县', '1528', '3');
INSERT INTO `cx_area` VALUES ('1614', '阜南县', '1528', '3');
INSERT INTO `cx_area` VALUES ('1615', '颍上县', '1528', '3');
INSERT INTO `cx_area` VALUES ('1616', '临泉县', '1528', '3');
INSERT INTO `cx_area` VALUES ('1617', '利辛县', '1529', '3');
INSERT INTO `cx_area` VALUES ('1618', '蒙城县', '1529', '3');
INSERT INTO `cx_area` VALUES ('1619', '涡阳县', '1529', '3');
INSERT INTO `cx_area` VALUES ('1620', '谯城区', '1529', '3');
INSERT INTO `cx_area` VALUES ('1621', '灵璧县', '1530', '3');
INSERT INTO `cx_area` VALUES ('1622', '泗县', '1530', '3');
INSERT INTO `cx_area` VALUES ('1623', '萧县', '1530', '3');
INSERT INTO `cx_area` VALUES ('1624', '砀山县', '1530', '3');
INSERT INTO `cx_area` VALUES ('1625', '埇桥区', '1530', '3');
INSERT INTO `cx_area` VALUES ('1626', '含山县', '1531', '3');
INSERT INTO `cx_area` VALUES ('1627', '和县', '1531', '3');
INSERT INTO `cx_area` VALUES ('1628', '无为县', '1531', '3');
INSERT INTO `cx_area` VALUES ('1629', '庐江县', '1531', '3');
INSERT INTO `cx_area` VALUES ('1630', '居巢区', '1531', '3');
INSERT INTO `cx_area` VALUES ('1631', '宁国市', '1532', '3');
INSERT INTO `cx_area` VALUES ('1632', '广德县', '1532', '3');
INSERT INTO `cx_area` VALUES ('1633', '郎溪县', '1532', '3');
INSERT INTO `cx_area` VALUES ('1634', '泾县', '1532', '3');
INSERT INTO `cx_area` VALUES ('1635', '旌德县', '1532', '3');
INSERT INTO `cx_area` VALUES ('1636', '绩溪县', '1532', '3');
INSERT INTO `cx_area` VALUES ('1637', '宜城市区内', '1532', '3');
INSERT INTO `cx_area` VALUES ('1638', '东至县', '1533', '3');
INSERT INTO `cx_area` VALUES ('1639', '石台县', '1533', '3');
INSERT INTO `cx_area` VALUES ('1640', '青阳县', '1533', '3');
INSERT INTO `cx_area` VALUES ('1641', '贵池区', '1533', '3');
INSERT INTO `cx_area` VALUES ('1642', '寿县', '1534', '3');
INSERT INTO `cx_area` VALUES ('1643', '霍山县', '1534', '3');
INSERT INTO `cx_area` VALUES ('1644', '金寨县', '1534', '3');
INSERT INTO `cx_area` VALUES ('1645', '霍邱县', '1534', '3');
INSERT INTO `cx_area` VALUES ('1646', '舒城县', '1534', '3');
INSERT INTO `cx_area` VALUES ('1647', '金安区', '1534', '3');
INSERT INTO `cx_area` VALUES ('1648', '裕安区', '1534', '3');
INSERT INTO `cx_area` VALUES ('1649', '宣州区', '1535', '3');
INSERT INTO `cx_area` VALUES ('1650', '旌德县', '1535', '3');
INSERT INTO `cx_area` VALUES ('1651', '宁国市', '1535', '3');
INSERT INTO `cx_area` VALUES ('1652', '郎溪县', '1535', '3');
INSERT INTO `cx_area` VALUES ('1653', '广德县', '1535', '3');
INSERT INTO `cx_area` VALUES ('1654', '绩溪县', '1535', '3');
INSERT INTO `cx_area` VALUES ('1655', '凤阳县', '1536', '3');
INSERT INTO `cx_area` VALUES ('1656', '浙江', '0', '1');
INSERT INTO `cx_area` VALUES ('1668', '海曙区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1669', '江东区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1670', '鄞州中心区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1671', '余姚市', '1657', '3');
INSERT INTO `cx_area` VALUES ('1672', '江北区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1673', '宁波保税区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1674', '高新科技开发区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1675', '北仑区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1676', '镇海区', '1657', '3');
INSERT INTO `cx_area` VALUES ('1677', '慈溪市', '1657', '3');
INSERT INTO `cx_area` VALUES ('1678', '奉化市', '1657', '3');
INSERT INTO `cx_area` VALUES ('1679', '宁海县', '1657', '3');
INSERT INTO `cx_area` VALUES ('1680', '象山县', '1657', '3');
INSERT INTO `cx_area` VALUES ('1681', '江干区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1682', '滨江区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1683', '上城区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1684', '下城区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1685', '拱墅区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1686', '西湖区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1687', '下沙区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1688', '良渚镇', '1658', '3');
INSERT INTO `cx_area` VALUES ('1689', '萧山区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1690', '乔司镇', '1658', '3');
INSERT INTO `cx_area` VALUES ('1691', '余杭区', '1658', '3');
INSERT INTO `cx_area` VALUES ('1692', '闲林镇', '1658', '3');
INSERT INTO `cx_area` VALUES ('1693', '瓶窑镇', '1658', '3');
INSERT INTO `cx_area` VALUES ('1694', '临平镇', '1658', '3');
INSERT INTO `cx_area` VALUES ('1695', '临安市', '1658', '3');
INSERT INTO `cx_area` VALUES ('1696', '富阳市', '1658', '3');
INSERT INTO `cx_area` VALUES ('1697', '桐庐县', '1658', '3');
INSERT INTO `cx_area` VALUES ('1698', '建德市', '1658', '3');
INSERT INTO `cx_area` VALUES ('1699', '淳安县', '1658', '3');
INSERT INTO `cx_area` VALUES ('1700', '温州茶山高教园区', '1659', '3');
INSERT INTO `cx_area` VALUES ('1701', '郭溪镇', '1659', '3');
INSERT INTO `cx_area` VALUES ('1702', '瞿溪镇', '1659', '3');
INSERT INTO `cx_area` VALUES ('1703', '潘桥镇', '1659', '3');
INSERT INTO `cx_area` VALUES ('1704', '南白象镇', '1659', '3');
INSERT INTO `cx_area` VALUES ('1705', '永嘉县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1706', '龙湾区', '1659', '3');
INSERT INTO `cx_area` VALUES ('1707', '鹿城区', '1659', '3');
INSERT INTO `cx_area` VALUES ('1708', '瓯海区', '1659', '3');
INSERT INTO `cx_area` VALUES ('1709', '乐清市', '1659', '3');
INSERT INTO `cx_area` VALUES ('1710', '永嘉县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1711', '瑞安市', '1659', '3');
INSERT INTO `cx_area` VALUES ('1712', '文成县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1713', '平阳县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1714', '泰顺县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1715', '洞头县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1716', '苍南县', '1659', '3');
INSERT INTO `cx_area` VALUES ('1717', '龙湾区海城街道', '1659', '3');
INSERT INTO `cx_area` VALUES ('1718', '南湖区', '1660', '3');
INSERT INTO `cx_area` VALUES ('1719', '秀洲区', '1660', '3');
INSERT INTO `cx_area` VALUES ('1720', '桐乡市', '1660', '3');
INSERT INTO `cx_area` VALUES ('1721', '平湖市', '1660', '3');
INSERT INTO `cx_area` VALUES ('1722', '嘉善县', '1660', '3');
INSERT INTO `cx_area` VALUES ('1723', '南浔区', '1660', '3');
INSERT INTO `cx_area` VALUES ('1724', '海盐县', '1660', '3');
INSERT INTO `cx_area` VALUES ('1725', '嘉兴经济开发区', '1660', '3');
INSERT INTO `cx_area` VALUES ('1726', '海宁市', '1660', '3');
INSERT INTO `cx_area` VALUES ('1727', '吴兴区', '1661', '3');
INSERT INTO `cx_area` VALUES ('1728', '南浔区', '1661', '3');
INSERT INTO `cx_area` VALUES ('1729', '长兴县', '1661', '3');
INSERT INTO `cx_area` VALUES ('1730', '德清县', '1661', '3');
INSERT INTO `cx_area` VALUES ('1731', '安吉县', '1661', '3');
INSERT INTO `cx_area` VALUES ('1732', '绍兴市市内', '1662', '3');
INSERT INTO `cx_area` VALUES ('1733', '绍兴县', '1662', '3');
INSERT INTO `cx_area` VALUES ('1734', '袍江工业园', '1662', '3');
INSERT INTO `cx_area` VALUES ('1735', '诸暨市', '1662', '3');
INSERT INTO `cx_area` VALUES ('1736', '上虞市', '1662', '3');
INSERT INTO `cx_area` VALUES ('1737', '嵊州市 ', '1662', '3');
INSERT INTO `cx_area` VALUES ('1738', '新昌县', '1662', '3');
INSERT INTO `cx_area` VALUES ('1739', '金东区', '1663', '3');
INSERT INTO `cx_area` VALUES ('1740', '婺城区', '1663', '3');
INSERT INTO `cx_area` VALUES ('1741', '义乌市', '1663', '3');
INSERT INTO `cx_area` VALUES ('1742', '东阳市', '1663', '3');
INSERT INTO `cx_area` VALUES ('1743', '永康市', '1663', '3');
INSERT INTO `cx_area` VALUES ('1744', '武义县', '1663', '3');
INSERT INTO `cx_area` VALUES ('1745', '浦江县', '1663', '3');
INSERT INTO `cx_area` VALUES ('1746', '磐安县', '1663', '3');
INSERT INTO `cx_area` VALUES ('1747', '兰溪市', '1663', '3');
INSERT INTO `cx_area` VALUES ('1748', '衢江区 ', '1664', '3');
INSERT INTO `cx_area` VALUES ('1749', '江山市', '1664', '3');
INSERT INTO `cx_area` VALUES ('1750', '常山县', '1664', '3');
INSERT INTO `cx_area` VALUES ('1751', '开化县', '1664', '3');
INSERT INTO `cx_area` VALUES ('1752', '龙游县', '1664', '3');
INSERT INTO `cx_area` VALUES ('1753', '柯城区', '1664', '3');
INSERT INTO `cx_area` VALUES ('1754', '莲都区', '1665', '3');
INSERT INTO `cx_area` VALUES ('1755', '龙泉市', '1665', '3');
INSERT INTO `cx_area` VALUES ('1756', '缙云县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1757', '遂昌县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1758', '松阳县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1759', '景宁畚族自治县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1760', '云和县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1761', '青田县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1762', '庆元县', '1665', '3');
INSERT INTO `cx_area` VALUES ('1763', '临海市', '1666', '3');
INSERT INTO `cx_area` VALUES ('1764', '温岭市', '1666', '3');
INSERT INTO `cx_area` VALUES ('1765', '玉环县', '1666', '3');
INSERT INTO `cx_area` VALUES ('1766', '三门县', '1666', '3');
INSERT INTO `cx_area` VALUES ('1767', '天台县', '1666', '3');
INSERT INTO `cx_area` VALUES ('1768', '仙居县', '1666', '3');
INSERT INTO `cx_area` VALUES ('1769', '椒江区', '1666', '3');
INSERT INTO `cx_area` VALUES ('1770', '黄岩区', '1666', '3');
INSERT INTO `cx_area` VALUES ('1771', '路桥区', '1666', '3');
INSERT INTO `cx_area` VALUES ('1772', '普陀区', '1667', '3');
INSERT INTO `cx_area` VALUES ('1773', '岱山县', '1667', '3');
INSERT INTO `cx_area` VALUES ('1774', '嵊泗县', '1667', '3');
INSERT INTO `cx_area` VALUES ('1775', '定海区', '1667', '3');
INSERT INTO `cx_area` VALUES ('1776', '福建', '0', '1');
INSERT INTO `cx_area` VALUES ('1786', '台江区', '1777', '3');
INSERT INTO `cx_area` VALUES ('1787', '鼓楼区', '1777', '3');
INSERT INTO `cx_area` VALUES ('1788', '晋安区', '1777', '3');
INSERT INTO `cx_area` VALUES ('1789', '仓山区', '1777', '3');
INSERT INTO `cx_area` VALUES ('1790', '马尾区', '1777', '3');
INSERT INTO `cx_area` VALUES ('1791', '长乐市', '1777', '3');
INSERT INTO `cx_area` VALUES ('1792', '福清市', '1777', '3');
INSERT INTO `cx_area` VALUES ('1793', '闽侯县', '1777', '3');
INSERT INTO `cx_area` VALUES ('1794', '平潭县', '1777', '3');
INSERT INTO `cx_area` VALUES ('1795', '连江县', '1777', '3');
INSERT INTO `cx_area` VALUES ('1796', '罗源县', '1777', '3');
INSERT INTO `cx_area` VALUES ('1797', '永泰县', '1777', '3');
INSERT INTO `cx_area` VALUES ('1798', '闽清县', '1777', '3');
INSERT INTO `cx_area` VALUES ('1799', '思明区', '1778', '3');
INSERT INTO `cx_area` VALUES ('1800', '海沧区', '1778', '3');
INSERT INTO `cx_area` VALUES ('1801', '湖里区', '1778', '3');
INSERT INTO `cx_area` VALUES ('1802', '集美区', '1778', '3');
INSERT INTO `cx_area` VALUES ('1803', '同安区', '1778', '3');
INSERT INTO `cx_area` VALUES ('1804', '翔安区', '1778', '3');
INSERT INTO `cx_area` VALUES ('1805', '永安市', '1779', '3');
INSERT INTO `cx_area` VALUES ('1806', '明溪县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1807', '将乐县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1808', '大田县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1809', '宁化县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1810', '建宁县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1811', '沙县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1812', '龙溪县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1813', '清流县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1814', '泰宁县', '1779', '3');
INSERT INTO `cx_area` VALUES ('1815', '梅列区', '1779', '3');
INSERT INTO `cx_area` VALUES ('1816', '三元区', '1779', '3');
INSERT INTO `cx_area` VALUES ('1817', '城厢区', '1780', '3');
INSERT INTO `cx_area` VALUES ('1818', '荔城区', '1780', '3');
INSERT INTO `cx_area` VALUES ('1819', '秀屿区', '1780', '3');
INSERT INTO `cx_area` VALUES ('1820', '仙游区', '1780', '3');
INSERT INTO `cx_area` VALUES ('1821', '涵江区', '1780', '3');
INSERT INTO `cx_area` VALUES ('1822', '鲤城区', '1781', '3');
INSERT INTO `cx_area` VALUES ('1823', '丰泽区', '1781', '3');
INSERT INTO `cx_area` VALUES ('1824', '洛江区', '1781', '3');
INSERT INTO `cx_area` VALUES ('1825', '石狮市', '1781', '3');
INSERT INTO `cx_area` VALUES ('1826', '晋江市', '1781', '3');
INSERT INTO `cx_area` VALUES ('1827', '南安市', '1781', '3');
INSERT INTO `cx_area` VALUES ('1828', '惠安县', '1781', '3');
INSERT INTO `cx_area` VALUES ('1829', '安溪县', '1781', '3');
INSERT INTO `cx_area` VALUES ('1830', '德化县', '1781', '3');
INSERT INTO `cx_area` VALUES ('1831', '永春县', '1781', '3');
INSERT INTO `cx_area` VALUES ('1832', '泉港区', '1781', '3');
INSERT INTO `cx_area` VALUES ('1833', '金门县', '1781', '3');
INSERT INTO `cx_area` VALUES ('1834', '龙海市', '1782', '3');
INSERT INTO `cx_area` VALUES ('1835', '平和县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1836', '南靖县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1837', '诏安县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1838', '漳浦县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1839', '华安县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1840', '云霄县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1841', '东山县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1842', '长泰县', '1782', '3');
INSERT INTO `cx_area` VALUES ('1843', '芗城区', '1782', '3');
INSERT INTO `cx_area` VALUES ('1844', '龙文区', '1782', '3');
INSERT INTO `cx_area` VALUES ('1845', '建瓯市', '1783', '3');
INSERT INTO `cx_area` VALUES ('1846', '邵武市', '1783', '3');
INSERT INTO `cx_area` VALUES ('1847', '武夷山市', '1783', '3');
INSERT INTO `cx_area` VALUES ('1848', '建阳市', '1783', '3');
INSERT INTO `cx_area` VALUES ('1849', '松溪县', '1783', '3');
INSERT INTO `cx_area` VALUES ('1850', '顺昌县', '1783', '3');
INSERT INTO `cx_area` VALUES ('1851', '浦城县', '1783', '3');
INSERT INTO `cx_area` VALUES ('1852', '政和县', '1783', '3');
INSERT INTO `cx_area` VALUES ('1853', '延平区', '1783', '3');
INSERT INTO `cx_area` VALUES ('1854', '光泽县', '1783', '3');
INSERT INTO `cx_area` VALUES ('1855', '漳平市', '1784', '3');
INSERT INTO `cx_area` VALUES ('1856', '长汀县', '1784', '3');
INSERT INTO `cx_area` VALUES ('1857', '武平县', '1784', '3');
INSERT INTO `cx_area` VALUES ('1858', '永定县', '1784', '3');
INSERT INTO `cx_area` VALUES ('1859', '上杭县', '1784', '3');
INSERT INTO `cx_area` VALUES ('1861', '新罗区', '1784', '3');
INSERT INTO `cx_area` VALUES ('1862', '福安市', '1785', '3');
INSERT INTO `cx_area` VALUES ('1863', '福鼎市', '1785', '3');
INSERT INTO `cx_area` VALUES ('1864', '寿宁县', '1785', '3');
INSERT INTO `cx_area` VALUES ('1865', '霞浦县', '1785', '3');
INSERT INTO `cx_area` VALUES ('1866', '柘荣县', '1785', '3');
INSERT INTO `cx_area` VALUES ('1867', '屏南县', '1785', '3');
INSERT INTO `cx_area` VALUES ('1868', '古田县', '1785', '3');
INSERT INTO `cx_area` VALUES ('1869', '周宁县', '1785', '3');
INSERT INTO `cx_area` VALUES ('1870', '宁德市', '1785', '3');
INSERT INTO `cx_area` VALUES ('1871', '湖北', '0', '1');
INSERT INTO `cx_area` VALUES ('1893', '硚口区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1894', '汉阳区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1895', '青山区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1896', '洪山区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1897', '东西湖区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1898', '江岸区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1899', '武昌区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1900', '江汉区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1901', '蔡甸区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1902', '江夏区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1903', '新洲区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1904', '黄陂区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1905', '汉南区', '1872', '3');
INSERT INTO `cx_area` VALUES ('1906', '西塞山区', '1873', '3');
INSERT INTO `cx_area` VALUES ('1907', '黄石港区', '1873', '3');
INSERT INTO `cx_area` VALUES ('1908', '下陆区', '1873', '3');
INSERT INTO `cx_area` VALUES ('1909', '铁山区', '1873', '3');
INSERT INTO `cx_area` VALUES ('1910', '大冶市', '1873', '3');
INSERT INTO `cx_area` VALUES ('1911', '阳新县', '1873', '3');
INSERT INTO `cx_area` VALUES ('1912', '老河口市', '1874', '3');
INSERT INTO `cx_area` VALUES ('1913', '枣阳市', '1874', '3');
INSERT INTO `cx_area` VALUES ('1914', '宜城市', '1874', '3');
INSERT INTO `cx_area` VALUES ('1915', '南漳县', '1874', '3');
INSERT INTO `cx_area` VALUES ('1916', '保康县', '1874', '3');
INSERT INTO `cx_area` VALUES ('1917', '谷城县', '1874', '3');
INSERT INTO `cx_area` VALUES ('1918', '襄阳区', '1874', '3');
INSERT INTO `cx_area` VALUES ('1919', '樊城区', '1874', '3');
INSERT INTO `cx_area` VALUES ('1920', '襄城区', '1874', '3');
INSERT INTO `cx_area` VALUES ('1921', '丹江口市', '1875', '3');
INSERT INTO `cx_area` VALUES ('1922', '房县', '1875', '3');
INSERT INTO `cx_area` VALUES ('1923', '竹山县', '1875', '3');
INSERT INTO `cx_area` VALUES ('1924', '竹溪县', '1875', '3');
INSERT INTO `cx_area` VALUES ('1925', '郧县', '1875', '3');
INSERT INTO `cx_area` VALUES ('1926', '郧西县', '1875', '3');
INSERT INTO `cx_area` VALUES ('1927', '茅箭区', '1875', '3');
INSERT INTO `cx_area` VALUES ('1928', '张湾区', '1875', '3');
INSERT INTO `cx_area` VALUES ('1929', '江陵县', '1876', '3');
INSERT INTO `cx_area` VALUES ('1930', '洪湖市', '1876', '3');
INSERT INTO `cx_area` VALUES ('1931', '石首市', '1876', '3');
INSERT INTO `cx_area` VALUES ('1932', '松滋市', '1876', '3');
INSERT INTO `cx_area` VALUES ('1933', '监利县', '1876', '3');
INSERT INTO `cx_area` VALUES ('1934', '公安县', '1876', '3');
INSERT INTO `cx_area` VALUES ('1935', '沙市区', '1876', '3');
INSERT INTO `cx_area` VALUES ('1936', '荆州区', '1876', '3');
INSERT INTO `cx_area` VALUES ('1937', '当阳市', '1877', '3');
INSERT INTO `cx_area` VALUES ('1938', '枝江市', '1877', '3');
INSERT INTO `cx_area` VALUES ('1939', '夷陵区', '1877', '3');
INSERT INTO `cx_area` VALUES ('1940', '秭归县', '1877', '3');
INSERT INTO `cx_area` VALUES ('1941', '兴山县', '1877', '3');
INSERT INTO `cx_area` VALUES ('1942', '远安县', '1877', '3');
INSERT INTO `cx_area` VALUES ('1943', '五峰土家族自治县', '1877', '3');
INSERT INTO `cx_area` VALUES ('1944', '长阳土家族自治县', '1877', '3');
INSERT INTO `cx_area` VALUES ('1945', '宜都市', '1877', '3');
INSERT INTO `cx_area` VALUES ('1946', '猇亭区', '1877', '3');
INSERT INTO `cx_area` VALUES ('1947', '点军区', '1877', '3');
INSERT INTO `cx_area` VALUES ('1948', '伍家岗区', '1877', '3');
INSERT INTO `cx_area` VALUES ('1949', '西陵区', '1877', '3');
INSERT INTO `cx_area` VALUES ('1950', '应城市', '1878', '3');
INSERT INTO `cx_area` VALUES ('1951', '安陆市', '1878', '3');
INSERT INTO `cx_area` VALUES ('1952', '汉川市', '1878', '3');
INSERT INTO `cx_area` VALUES ('1953', '云梦县', '1878', '3');
INSERT INTO `cx_area` VALUES ('1954', '大悟县', '1878', '3');
INSERT INTO `cx_area` VALUES ('1955', '孝昌县', '1878', '3');
INSERT INTO `cx_area` VALUES ('1956', '孝南区', '1878', '3');
INSERT INTO `cx_area` VALUES ('1957', '麻城市', '1879', '3');
INSERT INTO `cx_area` VALUES ('1958', '武穴市', '1879', '3');
INSERT INTO `cx_area` VALUES ('1959', '红安县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1960', '罗田县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1961', '浠水县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1962', '黄梅县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1963', '英山县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1964', '团风县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1965', '蕲春县', '1879', '3');
INSERT INTO `cx_area` VALUES ('1966', '黄州区', '1879', '3');
INSERT INTO `cx_area` VALUES ('1967', '仙桃市', '1879', '3');
INSERT INTO `cx_area` VALUES ('1968', '咸安区', '1880', '3');
INSERT INTO `cx_area` VALUES ('1969', '赤壁市', '1880', '3');
INSERT INTO `cx_area` VALUES ('1970', '嘉鱼县', '1880', '3');
INSERT INTO `cx_area` VALUES ('1971', '通山县', '1880', '3');
INSERT INTO `cx_area` VALUES ('1972', '崇阳县', '1880', '3');
INSERT INTO `cx_area` VALUES ('1973', '通城县', '1880', '3');
INSERT INTO `cx_area` VALUES ('1974', '恩施市', '1881', '3');
INSERT INTO `cx_area` VALUES ('1975', '利川市', '1881', '3');
INSERT INTO `cx_area` VALUES ('1976', '建始县', '1881', '3');
INSERT INTO `cx_area` VALUES ('1977', '来凤县', '1881', '3');
INSERT INTO `cx_area` VALUES ('1978', '巴东县', '1881', '3');
INSERT INTO `cx_area` VALUES ('1979', '鹤峰县', '1881', '3');
INSERT INTO `cx_area` VALUES ('1980', '宣恩县', '1881', '3');
INSERT INTO `cx_area` VALUES ('1981', '咸丰县', '1881', '3');
INSERT INTO `cx_area` VALUES ('1982', '鄂城区', '1882', '3');
INSERT INTO `cx_area` VALUES ('1983', '梁子湖区', '1882', '3');
INSERT INTO `cx_area` VALUES ('1984', '华容区', '1882', '3');
INSERT INTO `cx_area` VALUES ('1985', '京山县', '1883', '3');
INSERT INTO `cx_area` VALUES ('1986', '钟祥市', '1883', '3');
INSERT INTO `cx_area` VALUES ('1987', '沙洋县', '1883', '3');
INSERT INTO `cx_area` VALUES ('1988', '掇刀区', '1883', '3');
INSERT INTO `cx_area` VALUES ('1989', '东宝区', '1883', '3');
INSERT INTO `cx_area` VALUES ('1990', '广水市', '1884', '3');
INSERT INTO `cx_area` VALUES ('1991', '曾都区', '1884', '3');
INSERT INTO `cx_area` VALUES ('1992', '潜江市区内', '1885', '3');
INSERT INTO `cx_area` VALUES ('1993', '天门市', '1886', '3');
INSERT INTO `cx_area` VALUES ('1994', '仙桃市区', '1887', '3');
INSERT INTO `cx_area` VALUES ('1995', '宜都市', '1888', '3');
INSERT INTO `cx_area` VALUES ('1996', '钟祥市', '1889', '3');
INSERT INTO `cx_area` VALUES ('1997', '神农架林区', '1890', '3');
INSERT INTO `cx_area` VALUES ('1998', '恩施市', '1891', '3');
INSERT INTO `cx_area` VALUES ('1999', '洪湖市', '1892', '3');
INSERT INTO `cx_area` VALUES ('2000', '湖南', '0', '1');
INSERT INTO `cx_area` VALUES ('2017', '芙蓉区', '2001', '3');
INSERT INTO `cx_area` VALUES ('2018', '雨花区', '2001', '3');
INSERT INTO `cx_area` VALUES ('2019', '开福区', '2001', '3');
INSERT INTO `cx_area` VALUES ('2020', '岳麓区', '2001', '3');
INSERT INTO `cx_area` VALUES ('2021', '浏阳市', '2001', '3');
INSERT INTO `cx_area` VALUES ('2022', '长沙县', '2001', '3');
INSERT INTO `cx_area` VALUES ('2023', '望城县', '2001', '3');
INSERT INTO `cx_area` VALUES ('2024', '宁乡县', '2001', '3');
INSERT INTO `cx_area` VALUES ('2025', '天心区', '2001', '3');
INSERT INTO `cx_area` VALUES ('2026', '天元区', '2002', '3');
INSERT INTO `cx_area` VALUES ('2027', '石峰区', '2002', '3');
INSERT INTO `cx_area` VALUES ('2028', '芦淞区', '2002', '3');
INSERT INTO `cx_area` VALUES ('2029', '荷塘区', '2002', '3');
INSERT INTO `cx_area` VALUES ('2030', '醴陵市', '2002', '3');
INSERT INTO `cx_area` VALUES ('2031', '株洲县', '2002', '3');
INSERT INTO `cx_area` VALUES ('2032', '攸县', '2002', '3');
INSERT INTO `cx_area` VALUES ('2033', '茶陵县', '2002', '3');
INSERT INTO `cx_area` VALUES ('2034', '炎陵县', '2002', '3');
INSERT INTO `cx_area` VALUES ('2035', '湘乡市', '2003', '3');
INSERT INTO `cx_area` VALUES ('2036', '湘潭县', '2003', '3');
INSERT INTO `cx_area` VALUES ('2037', '韶山市', '2003', '3');
INSERT INTO `cx_area` VALUES ('2038', '雨湖区', '2003', '3');
INSERT INTO `cx_area` VALUES ('2039', '岳塘区', '2003', '3');
INSERT INTO `cx_area` VALUES ('2040', '韶山市', '2004', '3');
INSERT INTO `cx_area` VALUES ('2041', '常宁市', '2005', '3');
INSERT INTO `cx_area` VALUES ('2042', '衡阳县', '2005', '3');
INSERT INTO `cx_area` VALUES ('2043', '耒阳市', '2005', '3');
INSERT INTO `cx_area` VALUES ('2044', '衡东县', '2005', '3');
INSERT INTO `cx_area` VALUES ('2045', '衡南县', '2005', '3');
INSERT INTO `cx_area` VALUES ('2046', '衡山县', '2005', '3');
INSERT INTO `cx_area` VALUES ('2047', '祁东县', '2005', '3');
INSERT INTO `cx_area` VALUES ('2048', '南岳区', '2005', '3');
INSERT INTO `cx_area` VALUES ('2049', '蒸湘区', '2005', '3');
INSERT INTO `cx_area` VALUES ('2050', '石鼓区', '2005', '3');
INSERT INTO `cx_area` VALUES ('2051', '珠晖区', '2005', '3');
INSERT INTO `cx_area` VALUES ('2052', '雁峰区', '2005', '3');
INSERT INTO `cx_area` VALUES ('2053', '武冈市', '2006', '3');
INSERT INTO `cx_area` VALUES ('2054', '邵东县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2055', '洞口县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2056', '新邵县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2057', '绥宁县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2058', '新宁县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2059', '邵阳县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2060', '隆回县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2061', '城步苗族自治县', '2006', '3');
INSERT INTO `cx_area` VALUES ('2062', '北塔区', '2006', '3');
INSERT INTO `cx_area` VALUES ('2063', '大祥区', '2006', '3');
INSERT INTO `cx_area` VALUES ('2064', '双清区', '2006', '3');
INSERT INTO `cx_area` VALUES ('2065', '临湘市', '2007', '3');
INSERT INTO `cx_area` VALUES ('2066', '汨罗市', '2007', '3');
INSERT INTO `cx_area` VALUES ('2067', '岳阳县', '2007', '3');
INSERT INTO `cx_area` VALUES ('2068', '湘阴县', '2007', '3');
INSERT INTO `cx_area` VALUES ('2069', '华容县', '2007', '3');
INSERT INTO `cx_area` VALUES ('2070', '平江县', '2007', '3');
INSERT INTO `cx_area` VALUES ('2071', '岳阳楼区', '2007', '3');
INSERT INTO `cx_area` VALUES ('2072', '君山区', '2007', '3');
INSERT INTO `cx_area` VALUES ('2073', '云溪区', '2007', '3');
INSERT INTO `cx_area` VALUES ('2074', '津市市', '2008', '3');
INSERT INTO `cx_area` VALUES ('2075', '澧县', '2008', '3');
INSERT INTO `cx_area` VALUES ('2076', '临澧县', '2008', '3');
INSERT INTO `cx_area` VALUES ('2077', '桃源县', '2008', '3');
INSERT INTO `cx_area` VALUES ('2078', '汉寿县', '2008', '3');
INSERT INTO `cx_area` VALUES ('2079', '石门县', '2008', '3');
INSERT INTO `cx_area` VALUES ('2080', '安乡县', '2008', '3');
INSERT INTO `cx_area` VALUES ('2081', '鼎城区', '2008', '3');
INSERT INTO `cx_area` VALUES ('2082', '武陵区', '2008', '3');
INSERT INTO `cx_area` VALUES ('2083', '慈利县', '2009', '3');
INSERT INTO `cx_area` VALUES ('2084', '桑植县', '2009', '3');
INSERT INTO `cx_area` VALUES ('2085', '武陵源区', '2009', '3');
INSERT INTO `cx_area` VALUES ('2086', '永定区', '2009', '3');
INSERT INTO `cx_area` VALUES ('2087', '资兴市', '2010', '3');
INSERT INTO `cx_area` VALUES ('2088', '宜章县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2089', '安仁县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2090', '汝城县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2091', '嘉禾县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2092', '临武县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2093', '桂东县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2094', '永兴县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2095', '桂阳县', '2010', '3');
INSERT INTO `cx_area` VALUES ('2096', '苏仙区', '2010', '3');
INSERT INTO `cx_area` VALUES ('2097', '北湖区', '2010', '3');
INSERT INTO `cx_area` VALUES ('2098', '南县', '2011', '3');
INSERT INTO `cx_area` VALUES ('2099', '桃江县', '2011', '3');
INSERT INTO `cx_area` VALUES ('2100', '安化县', '2011', '3');
INSERT INTO `cx_area` VALUES ('2101', '资阳区', '2011', '3');
INSERT INTO `cx_area` VALUES ('2102', '沅江市', '2011', '3');
INSERT INTO `cx_area` VALUES ('2103', '赫山区', '2011', '3');
INSERT INTO `cx_area` VALUES ('2104', '冷水滩区', '2012', '3');
INSERT INTO `cx_area` VALUES ('2105', '祁阳县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2106', '双牌县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2107', '道县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2108', '江永县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2109', '江华瑶族自治县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2110', '宁远县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2111', '新田县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2112', '蓝山县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2113', '东安县', '2012', '3');
INSERT INTO `cx_area` VALUES ('2114', '零陵区', '2012', '3');
INSERT INTO `cx_area` VALUES ('2115', '洪江市', '2013', '3');
INSERT INTO `cx_area` VALUES ('2116', '会同县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2117', '溆浦县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2118', '辰溪县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2119', '靖州苗族侗族自治县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2120', '通道侗族自治县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2121', '芷江侗族自治县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2122', '新晃东族自治县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2123', '麻阳苗族自治县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2124', '怀化市区内', '2013', '3');
INSERT INTO `cx_area` VALUES ('2125', '沅陵县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2126', '鹤城区', '2013', '3');
INSERT INTO `cx_area` VALUES ('2127', '中方县', '2013', '3');
INSERT INTO `cx_area` VALUES ('2128', '娄底市', '2014', '3');
INSERT INTO `cx_area` VALUES ('2129', '冷水江市', '2014', '3');
INSERT INTO `cx_area` VALUES ('2130', '涟源市', '2014', '3');
INSERT INTO `cx_area` VALUES ('2131', '新化县', '2014', '3');
INSERT INTO `cx_area` VALUES ('2132', '双峰县', '2014', '3');
INSERT INTO `cx_area` VALUES ('2133', '娄星区', '2014', '3');
INSERT INTO `cx_area` VALUES ('2134', '吉首市', '2015', '3');
INSERT INTO `cx_area` VALUES ('2135', '古丈县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2136', '龙山县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2137', '永顺县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2138', '泸溪县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2139', '凤凰县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2140', '花垣县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2141', '保靖县', '2015', '3');
INSERT INTO `cx_area` VALUES ('2142', '耒阳市', '2016', '3');
INSERT INTO `cx_area` VALUES ('2143', '蔡子池区', '2016', '3');
INSERT INTO `cx_area` VALUES ('2144', '广东', '0', '1');
INSERT INTO `cx_area` VALUES ('2166', '白云区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2167', '天河区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2168', '海珠区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2169', '荔湾区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2170', '越秀区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2171', '番禺区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2172', '黄浦区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2173', '增城市', '2145', '3');
INSERT INTO `cx_area` VALUES ('2174', '花都区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2175', '从化市', '2145', '3');
INSERT INTO `cx_area` VALUES ('2176', '南沙区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2177', '萝岗区', '2145', '3');
INSERT INTO `cx_area` VALUES ('2178', '宝安区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2179', '盐田区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2180', '龙岗区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2181', '南山区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2182', '宝安区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2183', '罗湖区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2184', '福田区', '2146', '3');
INSERT INTO `cx_area` VALUES ('2185', '香洲区', '2147', '3');
INSERT INTO `cx_area` VALUES ('2186', '拱北区', '2147', '3');
INSERT INTO `cx_area` VALUES ('2187', '金塘区', '2147', '3');
INSERT INTO `cx_area` VALUES ('2188', '斗门区', '2147', '3');
INSERT INTO `cx_area` VALUES ('2189', '金湾区', '2147', '3');
INSERT INTO `cx_area` VALUES ('2190', '吉大区', '2147', '3');
INSERT INTO `cx_area` VALUES ('2191', '龙湖区', '2148', '3');
INSERT INTO `cx_area` VALUES ('2192', '金平区', '2148', '3');
INSERT INTO `cx_area` VALUES ('2193', '澄海区', '2148', '3');
INSERT INTO `cx_area` VALUES ('2194', '南澳县', '2148', '3');
INSERT INTO `cx_area` VALUES ('2195', '濠江区', '2148', '3');
INSERT INTO `cx_area` VALUES ('2196', '潮阳区', '2148', '3');
INSERT INTO `cx_area` VALUES ('2197', '潮南区', '2148', '3');
INSERT INTO `cx_area` VALUES ('2198', '武江区', '2149', '3');
INSERT INTO `cx_area` VALUES ('2199', '浈江区', '2149', '3');
INSERT INTO `cx_area` VALUES ('2200', '南雄市', '2149', '3');
INSERT INTO `cx_area` VALUES ('2201', '乐昌市', '2149', '3');
INSERT INTO `cx_area` VALUES ('2202', '仁化县', '2149', '3');
INSERT INTO `cx_area` VALUES ('2203', '始兴县', '2149', '3');
INSERT INTO `cx_area` VALUES ('2204', '翁源县', '2149', '3');
INSERT INTO `cx_area` VALUES ('2205', '曲江县', '2149', '3');
INSERT INTO `cx_area` VALUES ('2206', '新丰县', '2149', '3');
INSERT INTO `cx_area` VALUES ('2207', '乳源瑶族自治县', '2149', '3');
INSERT INTO `cx_area` VALUES ('2208', '曲江区', '2149', '3');
INSERT INTO `cx_area` VALUES ('2209', '东源县', '2150', '3');
INSERT INTO `cx_area` VALUES ('2210', '源城区', '2150', '3');
INSERT INTO `cx_area` VALUES ('2211', '和平县', '2150', '3');
INSERT INTO `cx_area` VALUES ('2212', '龙川县', '2150', '3');
INSERT INTO `cx_area` VALUES ('2213', '紫金县', '2150', '3');
INSERT INTO `cx_area` VALUES ('2214', '连平县', '2150', '3');
INSERT INTO `cx_area` VALUES ('2215', '梅江区', '2151', '3');
INSERT INTO `cx_area` VALUES ('2216', '兴宁市', '2151', '3');
INSERT INTO `cx_area` VALUES ('2217', '梅县', '2151', '3');
INSERT INTO `cx_area` VALUES ('2218', '蕉岭县', '2151', '3');
INSERT INTO `cx_area` VALUES ('2219', '大埔县', '2151', '3');
INSERT INTO `cx_area` VALUES ('2220', '丰顺县', '2151', '3');
INSERT INTO `cx_area` VALUES ('2221', '五华县', '2151', '3');
INSERT INTO `cx_area` VALUES ('2222', '平原县', '2151', '3');
INSERT INTO `cx_area` VALUES ('2223', '惠城区', '2152', '3');
INSERT INTO `cx_area` VALUES ('2224', '惠阳区', '2152', '3');
INSERT INTO `cx_area` VALUES ('2225', '惠东县', '2152', '3');
INSERT INTO `cx_area` VALUES ('2226', '博罗县', '2152', '3');
INSERT INTO `cx_area` VALUES ('2227', '龙门县', '2152', '3');
INSERT INTO `cx_area` VALUES ('2228', '大亚湾区', '2152', '3');
INSERT INTO `cx_area` VALUES ('2229', '陆丰市', '2153', '3');
INSERT INTO `cx_area` VALUES ('2230', '陆河市', '2153', '3');
INSERT INTO `cx_area` VALUES ('2231', '城区', '2153', '3');
INSERT INTO `cx_area` VALUES ('2232', '海丰县', '2153', '3');
INSERT INTO `cx_area` VALUES ('2233', '东城区', '2154', '3');
INSERT INTO `cx_area` VALUES ('2234', '莞城区', '2154', '3');
INSERT INTO `cx_area` VALUES ('2235', '南城区', '2154', '3');
INSERT INTO `cx_area` VALUES ('2236', '长安镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2237', '虎门镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2238', '万江区', '2154', '3');
INSERT INTO `cx_area` VALUES ('2239', '东城区', '2154', '3');
INSERT INTO `cx_area` VALUES ('2240', '中堂镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2241', '大岭山镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2242', '大朗镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2243', '厚街镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2244', '凤岗镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2245', '常平镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2246', '横沥镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2247', '东坑镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2248', '黄江镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2249', '樟木头镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2250', '塘厦镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2251', '道滘镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2252', '清溪镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2253', '沙田镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2254', '高步镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2255', '石龙镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2256', '石排镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2257', '企石镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2258', '石碣镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2259', '寮步镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2260', '洪梅镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2261', '麻涌镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2262', '桥头镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2263', '望牛墩镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2264', '茶山镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2265', '谢岗镇', '2154', '3');
INSERT INTO `cx_area` VALUES ('2266', '松山湖', '2154', '3');
INSERT INTO `cx_area` VALUES ('2267', '中山市内', '2155', '3');
INSERT INTO `cx_area` VALUES ('2268', '南朗镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2269', '小榄镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2270', '古镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2271', '坦洲镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2272', '黄圃镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2273', '三乡镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2274', '东凤镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2275', '横栏真', '2155', '3');
INSERT INTO `cx_area` VALUES ('2276', '三角镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2277', '南头镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2278', '民众镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2279', '沙溪镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2280', '五桂山镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2281', '阜沙镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2282', '东升镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2283', '板芙镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2284', '神湾镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2285', '港口镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2286', '火炬开发区', '2155', '3');
INSERT INTO `cx_area` VALUES ('2287', '大涌镇', '2155', '3');
INSERT INTO `cx_area` VALUES ('2288', '江海区', '2156', '3');
INSERT INTO `cx_area` VALUES ('2289', '蓬江区', '2156', '3');
INSERT INTO `cx_area` VALUES ('2290', '台山市', '2156', '3');
INSERT INTO `cx_area` VALUES ('2291', '新会区', '2156', '3');
INSERT INTO `cx_area` VALUES ('2292', '开平市', '2156', '3');
INSERT INTO `cx_area` VALUES ('2293', '鹤山市', '2156', '3');
INSERT INTO `cx_area` VALUES ('2294', '恩平市', '2156', '3');
INSERT INTO `cx_area` VALUES ('2295', '禅城区市区', '2157', '3');
INSERT INTO `cx_area` VALUES ('2296', '南海区', '2157', '3');
INSERT INTO `cx_area` VALUES ('2297', '顺德区', '2157', '3');
INSERT INTO `cx_area` VALUES ('2298', '高明区', '2157', '3');
INSERT INTO `cx_area` VALUES ('2299', '三水区郊区', '2157', '3');
INSERT INTO `cx_area` VALUES ('2300', '阳东县', '2158', '3');
INSERT INTO `cx_area` VALUES ('2301', '江城区', '2158', '3');
INSERT INTO `cx_area` VALUES ('2302', '阳春市', '2158', '3');
INSERT INTO `cx_area` VALUES ('2303', '阳西县', '2158', '3');
INSERT INTO `cx_area` VALUES ('2304', '霞山区', '2159', '3');
INSERT INTO `cx_area` VALUES ('2305', '赤坎区', '2159', '3');
INSERT INTO `cx_area` VALUES ('2306', '遂溪县', '2159', '3');
INSERT INTO `cx_area` VALUES ('2307', '开发区', '2159', '3');
INSERT INTO `cx_area` VALUES ('2308', '廉江市', '2159', '3');
INSERT INTO `cx_area` VALUES ('2309', '雷州市', '2159', '3');
INSERT INTO `cx_area` VALUES ('2310', '吴川市', '2159', '3');
INSERT INTO `cx_area` VALUES ('2311', '徐闻县', '2159', '3');
INSERT INTO `cx_area` VALUES ('2312', '麻章区', '2159', '3');
INSERT INTO `cx_area` VALUES ('2349', '广西', '0', '1');
INSERT INTO `cx_area` VALUES ('2499', '江西', '0', '1');
INSERT INTO `cx_area` VALUES ('2613', '四川', '0', '1');
INSERT INTO `cx_area` VALUES ('2821', '海南', '0', '1');
INSERT INTO `cx_area` VALUES ('3026', '贵州', '0', '1');
INSERT INTO `cx_area` VALUES ('3125', '云南', '0', '1');
INSERT INTO `cx_area` VALUES ('3270', '西藏', '0', '1');
INSERT INTO `cx_area` VALUES ('3351', '陕西', '0', '1');
INSERT INTO `cx_area` VALUES ('3472', '甘肃', '0', '1');
INSERT INTO `cx_area` VALUES ('3586', '青海', '0', '1');
INSERT INTO `cx_area` VALUES ('3643', '宁夏', '0', '1');
INSERT INTO `cx_area` VALUES ('3672', '新疆', '0', '1');
INSERT INTO `cx_area` VALUES ('3791', '台湾', '0', '1');
INSERT INTO `cx_area` VALUES ('3794', '香港', '0', '1');
INSERT INTO `cx_area` VALUES ('3797', '澳门', '0', '1');
INSERT INTO `cx_area` VALUES ('3800', '钓鱼岛', '0', '1');

-- ----------------------------
-- Table structure for `cx_auth`
-- ----------------------------
DROP TABLE IF EXISTS `cx_auth`;
CREATE TABLE `cx_auth` (
  `role_id` tinyint(3) NOT NULL,
  `menu_id` smallint(6) NOT NULL,
  KEY `role_id` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户权限表';

-- ----------------------------
-- Records of cx_auth
-- ----------------------------
INSERT INTO `cx_auth` VALUES ('1', '1');
INSERT INTO `cx_auth` VALUES ('1', '2');
INSERT INTO `cx_auth` VALUES ('1', '3');
INSERT INTO `cx_auth` VALUES ('1', '4');
INSERT INTO `cx_auth` VALUES ('1', '5');
INSERT INTO `cx_auth` VALUES ('1', '6');
INSERT INTO `cx_auth` VALUES ('1', '43');
INSERT INTO `cx_auth` VALUES ('1', '44');
INSERT INTO `cx_auth` VALUES ('1', '45');
INSERT INTO `cx_auth` VALUES ('1', '46');
INSERT INTO `cx_auth` VALUES ('1', '47');
INSERT INTO `cx_auth` VALUES ('1', '48');
INSERT INTO `cx_auth` VALUES ('1', '49');
INSERT INTO `cx_auth` VALUES ('1', '50');
INSERT INTO `cx_auth` VALUES ('1', '51');
INSERT INTO `cx_auth` VALUES ('1', '52');
INSERT INTO `cx_auth` VALUES ('1', '53');
INSERT INTO `cx_auth` VALUES ('1', '54');
INSERT INTO `cx_auth` VALUES ('1', '55');
INSERT INTO `cx_auth` VALUES ('1', '56');
INSERT INTO `cx_auth` VALUES ('1', '57');
INSERT INTO `cx_auth` VALUES ('1', '58');
INSERT INTO `cx_auth` VALUES ('1', '62');
INSERT INTO `cx_auth` VALUES ('1', '63');
INSERT INTO `cx_auth` VALUES ('1', '70');
INSERT INTO `cx_auth` VALUES ('1', '71');
INSERT INTO `cx_auth` VALUES ('1', '72');
INSERT INTO `cx_auth` VALUES ('1', '78');
INSERT INTO `cx_auth` VALUES ('1', '79');
INSERT INTO `cx_auth` VALUES ('1', '80');
INSERT INTO `cx_auth` VALUES ('1', '83');
INSERT INTO `cx_auth` VALUES ('1', '85');
INSERT INTO `cx_auth` VALUES ('1', '86');
INSERT INTO `cx_auth` VALUES ('1', '88');
INSERT INTO `cx_auth` VALUES ('1', '89');
INSERT INTO `cx_auth` VALUES ('1', '99');
INSERT INTO `cx_auth` VALUES ('1', '100');
INSERT INTO `cx_auth` VALUES ('1', '101');
INSERT INTO `cx_auth` VALUES ('1', '102');
INSERT INTO `cx_auth` VALUES ('1', '103');
INSERT INTO `cx_auth` VALUES ('1', '104');
INSERT INTO `cx_auth` VALUES ('1', '105');
INSERT INTO `cx_auth` VALUES ('1', '106');
INSERT INTO `cx_auth` VALUES ('1', '107');
INSERT INTO `cx_auth` VALUES ('1', '108');
INSERT INTO `cx_auth` VALUES ('1', '109');
INSERT INTO `cx_auth` VALUES ('1', '110');
INSERT INTO `cx_auth` VALUES ('1', '111');
INSERT INTO `cx_auth` VALUES ('1', '112');
INSERT INTO `cx_auth` VALUES ('2', '1');
INSERT INTO `cx_auth` VALUES ('2', '2');
INSERT INTO `cx_auth` VALUES ('2', '3');
INSERT INTO `cx_auth` VALUES ('2', '43');
INSERT INTO `cx_auth` VALUES ('2', '54');
INSERT INTO `cx_auth` VALUES ('2', '116');
INSERT INTO `cx_auth` VALUES ('2', '117');
INSERT INTO `cx_auth` VALUES ('7', '1');
INSERT INTO `cx_auth` VALUES ('7', '2');
INSERT INTO `cx_auth` VALUES ('7', '3');
INSERT INTO `cx_auth` VALUES ('7', '4');
INSERT INTO `cx_auth` VALUES ('7', '5');
INSERT INTO `cx_auth` VALUES ('7', '6');
INSERT INTO `cx_auth` VALUES ('7', '43');
INSERT INTO `cx_auth` VALUES ('7', '50');
INSERT INTO `cx_auth` VALUES ('7', '52');
INSERT INTO `cx_auth` VALUES ('7', '54');
INSERT INTO `cx_auth` VALUES ('7', '70');
INSERT INTO `cx_auth` VALUES ('7', '71');
INSERT INTO `cx_auth` VALUES ('7', '99');
INSERT INTO `cx_auth` VALUES ('7', '100');
INSERT INTO `cx_auth` VALUES ('7', '101');
INSERT INTO `cx_auth` VALUES ('7', '114');
INSERT INTO `cx_auth` VALUES ('7', '115');
INSERT INTO `cx_auth` VALUES ('7', '116');
INSERT INTO `cx_auth` VALUES ('7', '117');
INSERT INTO `cx_auth` VALUES ('7', '118');

-- ----------------------------
-- Table structure for `cx_award`
-- ----------------------------
DROP TABLE IF EXISTS `cx_award`;
CREATE TABLE `cx_award` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL COMMENT '获奖人姓名',
  `award_name` varchar(100) DEFAULT NULL COMMENT '奖项名称',
  `award_rank` tinyint(6) DEFAULT NULL COMMENT '奖项级别 1：镇级 2：区级3：市级4：国家级5：全球级',
  `award_form` tinyint(6) DEFAULT NULL COMMENT '获奖形式 1：教师个人2：教师团体3：学生个人4：学生团体5：学生荣誉',
  `award_time` int(11) DEFAULT NULL COMMENT '获奖日期',
  `unit` text COMMENT '颁奖单位',
  `department` tinyint(4) DEFAULT NULL COMMENT '所属部门1：教务处2：体卫科艺3：政教处4：团体5：校办6：人事7：工会8：科研',
  `teacher_charge` text COMMENT '负责教师（可以是多位）',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_award
-- ----------------------------
INSERT INTO `cx_award` VALUES ('1', 'admin', '奖项一', '2', '1', '1513958400', '王毅,李浩,王杰', '2', '王毅,李浩 王杰', '1514023773');
INSERT INTO `cx_award` VALUES ('3', 'admin', '奖项2', '2', '2', '1514044800', '冯小刚,张艺谋', '2', '冯小刚,张艺谋', '1514085482');
INSERT INTO `cx_award` VALUES ('4', 'admin1', '奖项2', '2', '2', '1514044800', '冯小刚,张艺谋', '2', '冯小刚,张艺谋', '1514085505');

-- ----------------------------
-- Table structure for `cx_award_images`
-- ----------------------------
DROP TABLE IF EXISTS `cx_award_images`;
CREATE TABLE `cx_award_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `award_id` int(11) DEFAULT NULL COMMENT '奖项id',
  `award_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_award_images
-- ----------------------------
INSERT INTO `cx_award_images` VALUES ('38', '3', 'Uploads/2017-12-24/5a3f47c460b60.jpg');
INSERT INTO `cx_award_images` VALUES ('33', '1', 'Uploads/2017-12-24/5a3f1a27abd75.jpg');
INSERT INTO `cx_award_images` VALUES ('32', '1', 'Uploads/2017-12-24/5a3f1a27b462f.jpg');
INSERT INTO `cx_award_images` VALUES ('37', '3', 'Uploads/2017-12-24/5a3f47c4582a6.jpg');
INSERT INTO `cx_award_images` VALUES ('29', '4', 'Uploads/2017-12-24/5a3f453657c15.jpg');
INSERT INTO `cx_award_images` VALUES ('28', '4', 'Uploads/2017-12-24/5a3f45364f35c.jpg');

-- ----------------------------
-- Table structure for `cx_class`
-- ----------------------------
DROP TABLE IF EXISTS `cx_class`;
CREATE TABLE `cx_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL COMMENT '班级名称',
  `grate_id` int(11) DEFAULT NULL COMMENT '年级id',
  `grate_name` varchar(100) DEFAULT NULL COMMENT '年级名称',
  `sort` tinyint(6) DEFAULT NULL COMMENT '排序',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='班级';

-- ----------------------------
-- Records of cx_class
-- ----------------------------
INSERT INTO `cx_class` VALUES ('2', '二班', '6', null, '2', '1');
INSERT INTO `cx_class` VALUES ('3', '一班', '8', null, '1', '1');
INSERT INTO `cx_class` VALUES ('4', '二班', '8', null, '2', '1');

-- ----------------------------
-- Table structure for `cx_department`
-- ----------------------------
DROP TABLE IF EXISTS `cx_department`;
CREATE TABLE `cx_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `sort` tinyint(10) DEFAULT NULL,
  `status` tinyint(10) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_department
-- ----------------------------
INSERT INTO `cx_department` VALUES ('1', '教务处', '1', '1');
INSERT INTO `cx_department` VALUES ('2', '体卫科艺', '2', '1');
INSERT INTO `cx_department` VALUES ('3', '政教处', '3', '1');
INSERT INTO `cx_department` VALUES ('4', '团体', '4', '1');
INSERT INTO `cx_department` VALUES ('5', '校办', '5', '1');
INSERT INTO `cx_department` VALUES ('6', '人事', '6', '1');
INSERT INTO `cx_department` VALUES ('7', '工会', '7', '1');
INSERT INTO `cx_department` VALUES ('8', '科研', '8', '1');

-- ----------------------------
-- Table structure for `cx_discipline`
-- ----------------------------
DROP TABLE IF EXISTS `cx_discipline`;
CREATE TABLE `cx_discipline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(11) DEFAULT NULL COMMENT '学科名称',
  `sort` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `grate_id` tinyint(11) DEFAULT NULL COMMENT '年级id',
  `grate_name` varchar(50) DEFAULT NULL COMMENT '年级名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_discipline
-- ----------------------------
INSERT INTO `cx_discipline` VALUES ('6', '数学', '2', '1', '8', '八年级');
INSERT INTO `cx_discipline` VALUES ('2', '数学', '2', '1', '9', null);
INSERT INTO `cx_discipline` VALUES ('3', '语文', '1', '1', '6', null);
INSERT INTO `cx_discipline` VALUES ('4', '语文', '1', '1', '8', '八年级');
INSERT INTO `cx_discipline` VALUES ('5', '数学', '2', '1', '8', '八年级');

-- ----------------------------
-- Table structure for `cx_grate`
-- ----------------------------
DROP TABLE IF EXISTS `cx_grate`;
CREATE TABLE `cx_grate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grate_name` varchar(100) DEFAULT NULL COMMENT '年级名称',
  `sort` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_grate
-- ----------------------------
INSERT INTO `cx_grate` VALUES ('4', '七年级', '7', '1');
INSERT INTO `cx_grate` VALUES ('3', '六年级', '6', '1');
INSERT INTO `cx_grate` VALUES ('5', '八年级', '8', '1');
INSERT INTO `cx_grate` VALUES ('6', '九年级', '9', '1');

-- ----------------------------
-- Table structure for `cx_invite`
-- ----------------------------
DROP TABLE IF EXISTS `cx_invite`;
CREATE TABLE `cx_invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `rid` int(11) NOT NULL DEFAULT '0' COMMENT '邀请者id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '10' COMMENT '状态，1：邀请成功；0：已邀请未注册',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：运营销售邀请；2：搭配邀请；3：作品号邀请；4：客户邀请',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='邀请表';

-- ----------------------------
-- Records of cx_invite
-- ----------------------------

-- ----------------------------
-- Table structure for `cx_logistics`
-- ----------------------------
DROP TABLE IF EXISTS `cx_logistics`;
CREATE TABLE `cx_logistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT '0',
  `logistics_no` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `logistics_company` varchar(100) NOT NULL DEFAULT '' COMMENT '物流公司',
  `address` text COMMENT '地址信息',
  `designer_id` int(11) NOT NULL DEFAULT '0' COMMENT '设计师id',
  `craftsman_id` int(11) NOT NULL DEFAULT '0' COMMENT '工艺师id',
  `create_time` int(11) DEFAULT NULL COMMENT '时间',
  `company_no` varchar(50) DEFAULT NULL,
  `is_receipt` tinyint(1) DEFAULT '0' COMMENT '是否收到货',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cx_logistics
-- ----------------------------
INSERT INTO `cx_logistics` VALUES ('1', '68', '22233655', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '53', '154', '1465220839', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('2', '70', '18925503564', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465222432', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('3', '69', '18925503564', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465223226', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('4', '78', '403447781108', '中通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465286285', 'zto', '1');
INSERT INTO `cx_logistics` VALUES ('5', '79', '403447781108', '中通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465286515', 'zto', '1');
INSERT INTO `cx_logistics` VALUES ('6', '80', '403447781108', '中通', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '53', '48', '1465286597', 'zto', '1');
INSERT INTO `cx_logistics` VALUES ('7', '83', '12345678901', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465291034', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('8', '84', '12345678987', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465291419', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('9', '85', '12345678909', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465292267', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('10', '85', '123456789074', '韵达', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '0', '154', '1465293908', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('11', '84', '113245989', '申通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '0', '154', '1465294855', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('12', '83', '158886517778965', '顺丰', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '0', '154', '1465295028', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('13', '79', '156886858685', '圆通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '0', '154', '1465295398', 'yt', '1');
INSERT INTO `cx_logistics` VALUES ('14', '78', '1588688587558', '圆通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1465295965', 'yt', '1');
INSERT INTO `cx_logistics` VALUES ('15', '70', '1587854855885', '顺丰', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1465349984', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('16', '69', '464994946096', '韵达', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1465352008', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('17', '86', '1345972698569', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1465366903', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('18', '87', '403447781108', '中通', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '53', '48', '1465367267', 'zto', '1');
INSERT INTO `cx_logistics` VALUES ('19', '80', '403447781108', '中通', 'a:8:{s:2:\"id\";s:2:\"44\";s:3:\"lng\";s:9:\"118.14612\";s:3:\"lat\";s:8:\"24.48843\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:12:\"哩哩啦啦\";}', '53', '48', '1465368886', 'zto', '0');
INSERT INTO `cx_logistics` VALUES ('20', '86', '1575845552555', '顺丰', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1465369313', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('21', '87', '455845617', '顺丰', 'a:8:{s:2:\"id\";s:2:\"44\";s:3:\"lng\";s:9:\"118.14612\";s:3:\"lat\";s:8:\"24.48843\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:12:\"哩哩啦啦\";}', '53', '48', '1465371228', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('22', '93', '456789123', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '13', '48', '1465373216', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('23', '93', '456759123', '顺丰', 'a:8:{s:2:\"id\";s:2:\"46\";s:3:\"lng\";s:9:\"118.14615\";s:3:\"lat\";s:8:\"24.48830\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:3:\"wou\";}', '13', '48', '1465373240', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('24', '94', '123789456', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '13', '48', '1465376573', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('25', '94', '123789456', '顺丰', 'a:8:{s:2:\"id\";s:2:\"46\";s:3:\"lng\";s:9:\"118.14615\";s:3:\"lat\";s:8:\"24.48830\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:3:\"wou\";}', '13', '48', '1465376634', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('26', '95', '456123789', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '13', '48', '1465377538', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('27', '95', '456789123', '顺丰', 'a:8:{s:2:\"id\";s:2:\"46\";s:3:\"lng\";s:9:\"118.14615\";s:3:\"lat\";s:8:\"24.48830\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:3:\"wou\";}', '13', '48', '1465377573', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('28', '96', '789456123', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '13', '48', '1465377808', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('29', '96', '123456789', '顺丰', 'a:8:{s:2:\"id\";s:2:\"46\";s:3:\"lng\";s:9:\"118.14615\";s:3:\"lat\";s:8:\"24.48830\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:3:\"wou\";}', '13', '48', '1465377830', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('30', '140', '542698859966', '圆通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1466563978', 'yt', '1');
INSERT INTO `cx_logistics` VALUES ('31', '140', '484888555', '申通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1466563998', 'sto', '0');
INSERT INTO `cx_logistics` VALUES ('32', '141', '45853669855', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1466564782', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('33', '141', '5698666656', '申通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1466564808', 'sto', '0');
INSERT INTO `cx_logistics` VALUES ('34', '142', '45885666988', '申通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1466565161', 'sto', '1');
INSERT INTO `cx_logistics` VALUES ('35', '142', '5568866998556', '申通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1466565185', 'sto', '0');
INSERT INTO `cx_logistics` VALUES ('36', '143', '12345678910', '顺丰', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1466565479', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('37', '143', '98765432101', '韵达', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1466565547', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('38', '144', '123789789789', '顺丰', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1466565853', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('39', '144', '9999999999999', '申通', 'a:8:{s:2:\"id\";s:2:\"47\";s:3:\"lng\";s:10:\"118.145087\";s:3:\"lat\";s:9:\"24.488645\";s:7:\"address\";s:18:\"龙山南路101号\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:6:\"哈哈\";}', '54', '154', '1466565873', 'sto', '0');
INSERT INTO `cx_logistics` VALUES ('40', '147', '401338886521', '中通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '13', '154', '1466670345', 'zto', '1');
INSERT INTO `cx_logistics` VALUES ('41', '151', '807109595850', '圆通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '157', '154', '1466671743', 'yt', '1');
INSERT INTO `cx_logistics` VALUES ('42', '148', '4226666855255', '圆通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1466671991', 'yt', '1');
INSERT INTO `cx_logistics` VALUES ('43', '151', '154546469464', '申通', 'a:8:{s:2:\"id\";s:3:\"184\";s:3:\"lng\";s:9:\"118.14625\";s:3:\"lat\";s:8:\"24.48816\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:6:\"小吴\";}', '157', '154', '1466673972', 'sto', '0');
INSERT INTO `cx_logistics` VALUES ('44', '147', '554649766767', '顺丰', 'a:8:{s:2:\"id\";s:2:\"46\";s:3:\"lng\";s:9:\"118.14615\";s:3:\"lat\";s:8:\"24.48830\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"0\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:3:\"wou\";}', '13', '154', '1466673992', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('45', '152', '123456789', '圆通', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '157', '154', '1466674221', 'yt', '1');
INSERT INTO `cx_logistics` VALUES ('46', '153', '123456789', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '157', '48', '1466675030', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('47', '153', '123789456', '顺丰', 'a:8:{s:2:\"id\";s:3:\"184\";s:3:\"lng\";s:9:\"118.14625\";s:3:\"lat\";s:8:\"24.48816\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:6:\"小吴\";}', '157', '48', '1466675048', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('48', '157', '123456789', '顺丰', 'a:8:{s:2:\"id\";s:3:\"171\";s:3:\"lng\";s:9:\"118.14610\";s:3:\"lat\";s:8:\"24.48839\";s:7:\"address\";s:14:\"龙山中路16\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18600678647\";s:12:\"receipt_name\";s:9:\"罗丢丢\";}', '157', '48', '1466737900', 'sf', '1');
INSERT INTO `cx_logistics` VALUES ('49', '157', '987654321', '顺丰', 'a:8:{s:2:\"id\";s:3:\"184\";s:3:\"lng\";s:9:\"118.14625\";s:3:\"lat\";s:8:\"24.48816\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:6:\"小吴\";}', '157', '48', '1466737916', 'sf', '0');
INSERT INTO `cx_logistics` VALUES ('50', '194', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467601960', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('51', '194', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467602087', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('52', '196', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467602517', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('53', '152', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"184\";s:3:\"lng\";s:9:\"118.14625\";s:3:\"lat\";s:8:\"24.48816\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"18750937276\";s:12:\"receipt_name\";s:6:\"小吴\";}', '157', '154', '1467602760', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('54', '196', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467602777', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('55', '201', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467620784', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('56', '201', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467620807', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('57', '200', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467699798', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('58', '199', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467699812', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('59', '198', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467699825', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('60', '197', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467699835', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('61', '200', '1000702099293', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467701350', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('62', '199', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467701373', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('63', '198', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467701390', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('64', '197', '1000702099293', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467701405', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('65', '205', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467702657', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('66', '205', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467702679', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('67', '206', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703095', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('68', '206', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703121', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('69', '207', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703242', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('70', '207', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703263', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('71', '208', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703398', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('72', '208', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703416', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('73', '209', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703636', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('74', '209', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703653', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('75', '210', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703730', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('76', '210', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703748', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('77', '211', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703818', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('78', '211', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703836', 'yd', '0');
INSERT INTO `cx_logistics` VALUES ('79', '212', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"180\";s:3:\"lng\";s:10:\"118.146066\";s:3:\"lat\";s:9:\"24.488168\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15837115209\";s:12:\"receipt_name\";s:9:\"徐师傅\";}', '54', '154', '1467703897', 'yd', '1');
INSERT INTO `cx_logistics` VALUES ('80', '212', '1000702099263', '韵达', 'a:8:{s:2:\"id\";s:3:\"185\";s:3:\"lng\";s:10:\"118.145996\";s:3:\"lat\";s:9:\"24.488133\";s:7:\"address\";s:14:\"龙山中路10\";s:4:\"area\";s:27:\"福建省厦门市思明区\";s:10:\"is_default\";s:1:\"1\";s:6:\"mobile\";s:11:\"15037150825\";s:12:\"receipt_name\";s:9:\"高朝阳\";}', '54', '154', '1467703917', 'yd', '0');

-- ----------------------------
-- Table structure for `cx_logistics_data`
-- ----------------------------
DROP TABLE IF EXISTS `cx_logistics_data`;
CREATE TABLE `cx_logistics_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_no` varchar(10) NOT NULL DEFAULT '' COMMENT '物流公司简称',
  `logistical_no` varchar(50) NOT NULL DEFAULT '' COMMENT '物流订单号',
  `logistical_data` text COMMENT '物流数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='物流结束后存储的物流数据';

-- ----------------------------
-- Records of cx_logistics_data
-- ----------------------------

-- ----------------------------
-- Table structure for `cx_menu`
-- ----------------------------
DROP TABLE IF EXISTS `cx_menu`;
CREATE TABLE `cx_menu` (
  `menu_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `pid` smallint(6) NOT NULL COMMENT '父级id',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型 1:菜单 2:操作点',
  `module_name` varchar(20) NOT NULL COMMENT '模块名',
  `action_name` varchar(20) NOT NULL COMMENT '操作名',
  `class_name` varchar(20) DEFAULT NULL COMMENT '图标样式名',
  `data` varchar(120) NOT NULL COMMENT 'url参数',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `often` tinyint(1) NOT NULL DEFAULT '0',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0::禁用 1:启用',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台菜单表';

-- ----------------------------
-- Records of cx_menu
-- ----------------------------
INSERT INTO `cx_menu` VALUES ('1', '系统', '0', '1', '', '', null, '', '', '0', '50', '1');
INSERT INTO `cx_menu` VALUES ('2', '核心', '1', '1', '', '', 'ico-system-0', '', '', '0', '1', '1');
INSERT INTO `cx_menu` VALUES ('3', '个人信息', '2', '1', 'System', 'site_setting', '', '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('4', '后台菜单', '2', '1', 'menu', 'index', null, '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('5', '角色管理', '2', '1', 'role', 'index', null, '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('6', '管理员', '2', '1', 'admin', 'index', null, '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('27', '添加', '4', '0', 'Menu', 'add', '', '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('28', '删除', '4', '0', 'Menu', 'del', '', '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('29', '修改', '4', '0', 'Menu', 'edit', null, '', '', '0', '255', '1');
INSERT INTO `cx_menu` VALUES ('43', '内容', '0', '1', '', '', '', '', '', '0', '20', '1');
INSERT INTO `cx_menu` VALUES ('50', '业务', '0', '1', '', '', '', '', '商品管理', '0', '2', '1');
INSERT INTO `cx_menu` VALUES ('52', '会员', '0', '1', 'Member', 'list', ' ico-shop-1', 'pid=0&amp;id=3', '会员管理', '0', '3', '1');
INSERT INTO `cx_menu` VALUES ('70', '功能管理', '50', '1', 'Advert', '', 'ico-shop-1', '', '功能管理', '0', '30', '1');
INSERT INTO `cx_menu` VALUES ('71', '班级管理', '70', '1', 'class', 'index', '', '', '栏目管理', '0', '10', '1');
INSERT INTO `cx_menu` VALUES ('77', '提现管理', '73', '1', 'Acount', 'index', '', '', '提现管理', '0', '100', '1');
INSERT INTO `cx_menu` VALUES ('82', '用户反馈管理', '69', '1', 'User', 'userFeedback', '', '', '用户反馈管理', '0', '100', '1');
INSERT INTO `cx_menu` VALUES ('99', '用户管理', '52', '1', 'Member', 'index', '', '', '', '0', '0', '1');
INSERT INTO `cx_menu` VALUES ('100', '学生信息', '99', '1', 'user', 'student', '', '', '', '0', '100', '1');
INSERT INTO `cx_menu` VALUES ('101', '教师信息', '99', '1', 'user', 'teacher', '', '', '', '0', '100', '1');
INSERT INTO `cx_menu` VALUES ('114', '年级管理', '70', '1', 'grate', 'index', '', '', '', '0', '4', '1');
INSERT INTO `cx_menu` VALUES ('115', '学科管理', '70', '1', 'discipline', 'index', '', '', '', '0', '10', '1');
INSERT INTO `cx_menu` VALUES ('116', '获奖管理', '43', '1', 'Award', 'index', '', '', '', '0', '4', '1');
INSERT INTO `cx_menu` VALUES ('117', '获奖记录', '116', '1', 'Award', 'index', '', '', '', '0', '1', '1');
INSERT INTO `cx_menu` VALUES ('118', '部门管理', '70', '1', 'Department', 'index', '', '', '', '0', '10', '1');

-- ----------------------------
-- Table structure for `cx_message`
-- ----------------------------
DROP TABLE IF EXISTS `cx_message`;
CREATE TABLE `cx_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '客户id',
  `title` varchar(150) DEFAULT '' COMMENT '标题',
  `contents` text COMMENT '内容',
  `create_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '消息状态',
  `type` tinyint(1) DEFAULT '2' COMMENT '消息类型 1：用户私信；2：官方消息',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '是否已读',
  `adviser_id` smallint(5) DEFAULT '0' COMMENT '顾问id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='信息表';

-- ----------------------------
-- Records of cx_message
-- ----------------------------

-- ----------------------------
-- Table structure for `cx_news`
-- ----------------------------
DROP TABLE IF EXISTS `cx_news`;
CREATE TABLE `cx_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '标识id',
  `cate_id` int(10) unsigned DEFAULT '0' COMMENT '所属栏目(分类)id，0为游离状态',
  `title` varchar(200) NOT NULL COMMENT '文章标题',
  `summary` varbinary(150) DEFAULT NULL COMMENT '简介',
  `contents` text NOT NULL COMMENT '文章内容',
  `sort` tinyint(6) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0:不显示 1:显示',
  `update_time` varchar(13) DEFAULT NULL COMMENT '最后修改时间',
  `view_times` int(11) DEFAULT '100' COMMENT '浏览量',
  `pic` text COMMENT '缩略图',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='资讯表';

-- ----------------------------
-- Records of cx_news
-- ----------------------------
INSERT INTO `cx_news` VALUES ('14', '7', '客户管理', '', '客户管理新手帮助文档，资料整理中，将会尽快发布', '0', '1', '1479282758', '100', '');
INSERT INTO `cx_news` VALUES ('16', '11', '提现规则', '', '提现规则提现规则提现规则提现规则', '0', '1', '1479368402', '100', '');
INSERT INTO `cx_news` VALUES ('17', '12', '订购服务', '', '&lt;p&gt;\n	&lt;img src=&quot;/Public/Admin/kindeditor/attached/image/20161122/20161122144215_55094.jpg&quot; alt=&quot;&quot; /&gt;\n&lt;/p&gt;', '0', '1', '1479796941', '100', '');
INSERT INTO `cx_news` VALUES ('18', '0', '关于我们', '', '&lt;p style=&quot;text-align:center;&quot;&gt;\n	&lt;img src=&quot;/Public/Admin/kindeditor/attached/image/20161121/20161121121152_38639.png&quot; alt=&quot;&quot; width=&quot;300&quot; height=&quot;300&quot; title=&quot;&quot; align=&quot;&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	穿形 &amp;nbsp;\n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	时尚服饰创业者的赚钱法器和省钱利器\n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	减少顾客购衣决策时间和&lt;span style=&quot;vertical-align:baseline;&quot;&gt;穿衣品质美感的神器&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	&lt;span style=&quot;vertical-align:baseline;&quot;&gt;&lt;br /&gt;\n&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	&lt;span style=&quot;vertical-align:baseline;&quot;&gt;服饰创业者&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	&lt;span style=&quot;vertical-align:baseline;&quot;&gt;开店卖作品用穿形 服务老客户用穿形 &amp;nbsp;管理店铺用穿形&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	&lt;span style=&quot;vertical-align:baseline;&quot;&gt;&lt;br /&gt;\n&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	&lt;span style=&quot;vertical-align:baseline;&quot;&gt;即刻开始体验&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;font-size:15px;vertical-align:baseline;color:#333333;font-family:arial, sans-serif;background-color:#FFFFFF;&quot;&gt;\n	&lt;span style=&quot;vertical-align:baseline;&quot;&gt;让品牌更高效获得收益&lt;/span&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-align:center;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;', '0', '1', '1479714675', '100', '');
INSERT INTO `cx_news` VALUES ('19', '0', '收入管理', '', '&lt;div style=&quot;text-align:center;&quot;&gt;\n	收入管理\n&lt;/div&gt;', '0', '1', '1479701584', '100', '');

-- ----------------------------
-- Table structure for `cx_news_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `cx_news_attachment`;
CREATE TABLE `cx_news_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标志id',
  `nid` int(11) NOT NULL COMMENT '文章id',
  `path` text NOT NULL COMMENT '附件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cx_news_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `cx_news_category`
-- ----------------------------
DROP TABLE IF EXISTS `cx_news_category`;
CREATE TABLE `cx_news_category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '栏目id',
  `cat_name` varchar(50) NOT NULL COMMENT '栏目名称',
  `sort` tinyint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='资讯类目表';

-- ----------------------------
-- Records of cx_news_category
-- ----------------------------
INSERT INTO `cx_news_category` VALUES ('7', '新手帮助', '0');
INSERT INTO `cx_news_category` VALUES ('10', '注册协议', '0');
INSERT INTO `cx_news_category` VALUES ('11', '提现规则', '0');
INSERT INTO `cx_news_category` VALUES ('12', '订购服务', '0');
INSERT INTO `cx_news_category` VALUES ('13', '关于我们', '0');
INSERT INTO `cx_news_category` VALUES ('14', '收入管理', '0');

-- ----------------------------
-- Table structure for `cx_system`
-- ----------------------------
DROP TABLE IF EXISTS `cx_system`;
CREATE TABLE `cx_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `APP_key` varchar(255) NOT NULL COMMENT 'APPkey',
  `APP_secret` varchar(255) NOT NULL COMMENT 'APPsecret',
  `callback` varchar(255) DEFAULT NULL COMMENT 'callback',
  `type` tinyint(1) DEFAULT NULL COMMENT '类型 1：微信；2：支付；3：短信',
  `recharge_set` varchar(500) DEFAULT NULL COMMENT '充值设置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cx_system
-- ----------------------------
INSERT INTO `cx_system` VALUES ('1', '2', '2', '3', '3', '[{\"recharge_money\":\"1980\",\"recharge_days\":\"365\"},{\"recharge_money\":\"1\",\"recharge_days\":\"1\"}]');
INSERT INTO `cx_system` VALUES ('2', '3', '3', '3', '1', null);
INSERT INTO `cx_system` VALUES ('3', '4', '4', '4', '2', null);

-- ----------------------------
-- Table structure for `cx_teacher_class`
-- ----------------------------
DROP TABLE IF EXISTS `cx_teacher_class`;
CREATE TABLE `cx_teacher_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '教师id',
  `class_id` int(11) DEFAULT NULL COMMENT '任教班级id',
  `grate_id` int(11) DEFAULT NULL COMMENT '任教年级id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_teacher_class
-- ----------------------------
INSERT INTO `cx_teacher_class` VALUES ('1', '6', '1', '9');
INSERT INTO `cx_teacher_class` VALUES ('2', '6', '2', '9');
INSERT INTO `cx_teacher_class` VALUES ('3', '7', '2', '6');
INSERT INTO `cx_teacher_class` VALUES ('4', '7', '2', '8');
INSERT INTO `cx_teacher_class` VALUES ('5', '8', '1', '9');
INSERT INTO `cx_teacher_class` VALUES ('6', '8', '2', '9');
INSERT INTO `cx_teacher_class` VALUES ('7', '9', '1', '8');
INSERT INTO `cx_teacher_class` VALUES ('8', '9', '2', '8');
INSERT INTO `cx_teacher_class` VALUES ('9', '10', '1', '9');
INSERT INTO `cx_teacher_class` VALUES ('10', '10', '2', '9');
INSERT INTO `cx_teacher_class` VALUES ('11', '11', '1', '8');
INSERT INTO `cx_teacher_class` VALUES ('12', '11', '2', '8');

-- ----------------------------
-- Table structure for `cx_teacher_discipline`
-- ----------------------------
DROP TABLE IF EXISTS `cx_teacher_discipline`;
CREATE TABLE `cx_teacher_discipline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `grate_id` int(11) DEFAULT NULL COMMENT '年级id',
  `dis_id` int(11) DEFAULT NULL COMMENT '学科id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cx_teacher_discipline
-- ----------------------------
INSERT INTO `cx_teacher_discipline` VALUES ('1', '6', '9', '1');
INSERT INTO `cx_teacher_discipline` VALUES ('2', '6', '9', '2');
INSERT INTO `cx_teacher_discipline` VALUES ('3', '7', '8', '1');
INSERT INTO `cx_teacher_discipline` VALUES ('4', '7', '8', '2');
INSERT INTO `cx_teacher_discipline` VALUES ('5', '8', '9', '1');
INSERT INTO `cx_teacher_discipline` VALUES ('6', '8', '9', '2');
INSERT INTO `cx_teacher_discipline` VALUES ('7', '9', '8', '1');
INSERT INTO `cx_teacher_discipline` VALUES ('8', '9', '8', '2');
INSERT INTO `cx_teacher_discipline` VALUES ('9', '10', '9', '1');
INSERT INTO `cx_teacher_discipline` VALUES ('10', '10', '9', '2');
INSERT INTO `cx_teacher_discipline` VALUES ('11', '11', '8', '1');
INSERT INTO `cx_teacher_discipline` VALUES ('12', '11', '8', '2');

-- ----------------------------
-- Table structure for `cx_theme`
-- ----------------------------
DROP TABLE IF EXISTS `cx_theme`;
CREATE TABLE `cx_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '专题名称',
  `theme_img` varchar(255) DEFAULT NULL COMMENT '专题图片',
  `sort` smallint(5) DEFAULT '100' COMMENT '排序',
  `category` varchar(50) NOT NULL COMMENT '分类',
  `introduce` varchar(255) DEFAULT NULL COMMENT '专题简介',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `cate_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '状态 0：生成html；1：动态',
  `url` varchar(50) NOT NULL COMMENT '网址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cx_theme
-- ----------------------------
INSERT INTO `cx_theme` VALUES ('1', '裁缝邦', 'http://cfb01.wearmaker.cn/Uploads/Theme/2016/08/29/57c4055e5d727.jpg', '10', '小型企业', '正在发展的企业！', '1472464308', '0', '0', '');
INSERT INTO `cx_theme` VALUES ('3', '超凡试衣体验流程介', 'http://cfb01.wearmaker.cn/Uploads/Theme/2016/08/29/57c406312f519.png', '100', '小型企业', '完美', '0', '0', '0', '');
INSERT INTO `cx_theme` VALUES ('4', '华为荣耀', 'http://cfb01.wearmaker.cn/Uploads/Theme/2016/08/30/57c4e49149156.jpg', '100', '小型企业', '完美！', '0', '0', '0', 'www.lasilaisi.com');

-- ----------------------------
-- Table structure for `cx_type`
-- ----------------------------
DROP TABLE IF EXISTS `cx_type`;
CREATE TABLE `cx_type` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT '' COMMENT '类型名称',
  `type_img` varchar(255) DEFAULT '' COMMENT '类型图片',
  `sort` smallint(5) DEFAULT '10' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='类型管理';

-- ----------------------------
-- Records of cx_type
-- ----------------------------
INSERT INTO `cx_type` VALUES ('1', '穿衣场合', '', '10', '1');
INSERT INTO `cx_type` VALUES ('4', '肤色', '', '10', '1');
INSERT INTO `cx_type` VALUES ('5', '尺码', '', '10', '1');
INSERT INTO `cx_type` VALUES ('6', '颜色', '', '10', '1');
INSERT INTO `cx_type` VALUES ('7', '脸型', '', '10', '1');
INSERT INTO `cx_type` VALUES ('9', '风格', '', '10', '1');
INSERT INTO `cx_type` VALUES ('10', '体型', 'Uploads/Type/2016/10/12/2016-10-12/57fda626e2af6.png', '10', '1');
INSERT INTO `cx_type` VALUES ('12', '用户标签', '', '10', '1');
INSERT INTO `cx_type` VALUES ('13', '生活喜好', '', '10', '1');
INSERT INTO `cx_type` VALUES ('14', '模板', '', '10', '1');

-- ----------------------------
-- Table structure for `cx_user_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `cx_user_feedback`;
CREATE TABLE `cx_user_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户id',
  `contents` varchar(255) DEFAULT '' COMMENT '反馈内容',
  `contact` varchar(50) DEFAULT '' COMMENT '联系方式',
  `create_time` int(11) DEFAULT '0' COMMENT '反馈时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户反馈';

-- ----------------------------
-- Records of cx_user_feedback
-- ----------------------------
INSERT INTO `cx_user_feedback` VALUES ('1', '208', '46646446', '15037150825', '1477944548');
INSERT INTO `cx_user_feedback` VALUES ('2', '218', '好像还是你很喜欢的好的好的几点能到', '18600678647', '1480909160');
