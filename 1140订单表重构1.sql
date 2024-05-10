-- 订单详情表
CREATE TABLE xec_goods_order (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT UNIQUE KEY NOT NULL COMMENT '数据编号',
	serial_number BIGINT COMMENT '交易流水号',
	pay_type TINYINT (1) NOT NULL COMMENT '支付方式(0积分,1现金,2积分+现金)',
	buyer_id BIGINT NOT NULL COMMENT '买家id',
	seller_id BIGINT NOT NULL COMMENT '卖家id',
	money_total DECIMAL (24,2) COMMENT '现金总额',
	points_total DECIMAL (24,6)  COMMENT '积分总额',
	order_status TINYINT NOT NULL DEFAULT 1 COMMENT '订单状态(1待付款,2待发货,3已发货, 40已取消, 50已完成, 51退款完成)',
	has_comment TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否评价(0未评价 1已评价)',
	has_deleted TINYINT (1) NOT NULL DEFAULT 0 COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间' 
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '订单详情';

-- 订单商品表
CREATE TABLE xec_order_commodity (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT NOT NULL COMMENT '数据编号',
	order_no BIGINT NOT NULL COMMENT '订单编号',
	refund_no BIGINT COMMENT '退款编号',
	sku_no BIGINT NOT NULL COMMENT '商品sku编号',
	spu_no BIGINT NOT NULL COMMENT '商品spu编号',
	integral_price DECIMAL(24,6) COMMENT '积分价格',
	goods_price DECIMAL(24,2) COMMENT '现金价格',
	quantity BIGINT NOT NULL COMMENT '商品数量',
	goods_imgs VARCHAR(1024) COMMENT '商品图片',
	goods_name VARCHAR(255) COMMENT '商品名称',
	goods_attributes VARCHAR(255) COMMENT '商品属性',
	shop_logo VARCHAR(255) COMMENT '商品主图',
	delivery_type TINYINT(1) NOT NULL COMMENT '配送方式(1物流,2自提)',
	goods_type TINYINT(1) NOT NULL COMMENT '商品类型(0普通商品,1虚拟商品)',
	has_deleted TINYINT(1) NOT NULL COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间' 
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '订单商品信息';

-- 订单用户信息表
CREATE TABLE xec_order_user_info (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT NOT NULL COMMENT '数据编号',
	order_no BIGINT NOT NULL COMMENT '订单编号',
	`type` TINYINT(1) NOT NULL COMMENT '类型(1买家,2卖家)',
	`user_id` BIGINT NOT NULL COMMENT '用户id',
	`user_name` VARCHAR(255) COMMENT '用户名称',
	user_phone VARCHAR(15) COMMENT '用户手机号',
	delivery_phone VARCHAR(15) COMMENT '提货手机号',
	remarks VARCHAR(255) COMMENT '备注',
	has_deleted TINYINT(1) NOT NULL COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间',
	INDEX index_orderNo_userId(order_no,user_id)
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '订单用户信息';

-- 商品退款表
CREATE TABLE xec_commodity_refund (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT NOT NULL COMMENT '数据编号',
	courier_number VARCHAR(50) COMMENT '快递单号',
	courier_company_no BIGINT COMMENT '快递公司编号(关联xec_delivery_company)',
	refund_type TINYINT(1) NOT NULL COMMENT '退款类型(1退货退款,2仅退款)',
	merchant_processing TINYINT(1) NOT NULL DEFAULT 0 COMMENT '商家处理结果(0=待处理 1=同意 2=拒绝)',
	platform_processing TINYINT(1) COMMENT DEFAULT NULL '平台处理结果(0=待处理 1=同意 2=拒绝)',
	`refund_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '退款状态(0=待处理 1=同意 2=拒绝)'
	refund_deadline DATETIME NOT NULL COMMENT '退款处理期限',
	audit_time DATETIME COMMENT '审核时间',
	merchant_reviewer BIGINT COMMENT '商家审核人',
	platform_reviewer BIGINT COMMENT '平台审核人',
	refund_price DECIMAL(24,2) COMMENT '退款现金',
	refund_integral DECIMAL(24,6) COMMENT '退款积分',
	refund_quantity BIGINT NOT NULL COMMENT '退款数量', 
	has_deleted TINYINT(1) NOT NULL COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '商品退款信息';


-- 订单配送信息表
CREATE TABLE xec_order_delivery (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT NOT NULL COMMENT '数据编号',
	order_no BIGINT NOT NULL COMMENT '订单编号',
	`type` TINYINT(1) NOT NULL COMMENT '配送方式(1物流,2自提)',
	courier_number VARCHAR(50) COMMENT '快递单号(配送方式选择物流)',
	courier_company_no BIGINT COMMENT '快递公司编号(关联xec_delivery_company)',
	self_pickup_code VARCHAR(50) COMMENT '自提码(配送方式选择自提)',
	has_deleted TINYINT(1) NOT NULL COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '订单配送信息';

-- 订单地址信息
CREATE TABLE xec_order_address (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT NOT NULL COMMENT '数据编号',
	order_no BIGINT NOT NULL COMMENT '订单编号',
	addr_no BIGINT COMMENT '用户地址编号',
	area_code VARCHAR(20) COMMENT '区编码',
	detail_address VARCHAR(255) COMMENT '详细地址',
	consignee VARCHAR(50) COMMENT '收货人',
	consignee_phone VARCHAR(15) COMMENT '收货人手机号',
	has_deleted TINYINT(1) NOT NULL COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间'	
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '订单地址信息';

-- 购物车详情
CREATE TABLE xec_shopping_cart (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
	`no` BIGINT NOT NULL COMMENT '数据编号',
	sku_no BIGINT NOT NULL COMMENT '商品sku编号',
	spu_no BIGINT NOT NULL COMMENT '商品spu编号',
	`user_id` BIGINT NOT NULL COMMENT '微信用户id',
	shop_no BIGINT NOT NULL COMMENT '店铺编号',
	quantity BIGINT COMMENT '商品数量',
	commodity_info JSON NOT NULL COMMENT '商品信息',
  version DECIMAL(3,3) NOT NULL COMMENT '版本号',	
	has_deleted TINYINT(1) NOT NULL COMMENT '是否删除(0否,1是)',
	create_user BIGINT NOT NULL COMMENT '创建人',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_user BIGINT COMMENT '更新人',
	update_time DATETIME COMMENT '更新时间'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '购物车详情';














