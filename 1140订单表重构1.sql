-- ���������
CREATE TABLE xec_goods_order (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT UNIQUE KEY NOT NULL COMMENT '���ݱ��',
	serial_number BIGINT COMMENT '������ˮ��',
	pay_type TINYINT (1) NOT NULL COMMENT '֧����ʽ(0����,1�ֽ�,2����+�ֽ�)',
	buyer_id BIGINT NOT NULL COMMENT '���id',
	seller_id BIGINT NOT NULL COMMENT '����id',
	money_total DECIMAL (24,2) COMMENT '�ֽ��ܶ�',
	points_total DECIMAL (24,6)  COMMENT '�����ܶ�',
	order_status TINYINT NOT NULL DEFAULT 1 COMMENT '����״̬(1������,2������,3�ѷ���, 40��ȡ��, 50�����, 51�˿����)',
	has_comment TINYINT(1) NOT NULL DEFAULT 0 COMMENT '�Ƿ�����(0δ���� 1������)',
	has_deleted TINYINT (1) NOT NULL DEFAULT 0 COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��' 
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '��������';

-- ������Ʒ��
CREATE TABLE xec_order_commodity (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT NOT NULL COMMENT '���ݱ��',
	order_no BIGINT NOT NULL COMMENT '�������',
	refund_no BIGINT COMMENT '�˿���',
	sku_no BIGINT NOT NULL COMMENT '��Ʒsku���',
	spu_no BIGINT NOT NULL COMMENT '��Ʒspu���',
	integral_price DECIMAL(24,6) COMMENT '���ּ۸�',
	goods_price DECIMAL(24,2) COMMENT '�ֽ�۸�',
	quantity BIGINT NOT NULL COMMENT '��Ʒ����',
	goods_imgs VARCHAR(1024) COMMENT '��ƷͼƬ',
	goods_name VARCHAR(255) COMMENT '��Ʒ����',
	goods_attributes VARCHAR(255) COMMENT '��Ʒ����',
	shop_logo VARCHAR(255) COMMENT '��Ʒ��ͼ',
	delivery_type TINYINT(1) NOT NULL COMMENT '���ͷ�ʽ(1����,2����)',
	goods_type TINYINT(1) NOT NULL COMMENT '��Ʒ����(0��ͨ��Ʒ,1������Ʒ)',
	has_deleted TINYINT(1) NOT NULL COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��' 
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '������Ʒ��Ϣ';

-- �����û���Ϣ��
CREATE TABLE xec_order_user_info (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT NOT NULL COMMENT '���ݱ��',
	order_no BIGINT NOT NULL COMMENT '�������',
	`type` TINYINT(1) NOT NULL COMMENT '����(1���,2����)',
	`user_id` BIGINT NOT NULL COMMENT '�û�id',
	`user_name` VARCHAR(255) COMMENT '�û�����',
	user_phone VARCHAR(15) COMMENT '�û��ֻ���',
	delivery_phone VARCHAR(15) COMMENT '����ֻ���',
	remarks VARCHAR(255) COMMENT '��ע',
	has_deleted TINYINT(1) NOT NULL COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��',
	INDEX index_orderNo_userId(order_no,user_id)
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '�����û���Ϣ';

-- ��Ʒ�˿��
CREATE TABLE xec_commodity_refund (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT NOT NULL COMMENT '���ݱ��',
	courier_number VARCHAR(50) COMMENT '��ݵ���',
	courier_company_no BIGINT COMMENT '��ݹ�˾���(����xec_delivery_company)',
	refund_type TINYINT(1) NOT NULL COMMENT '�˿�����(1�˻��˿�,2���˿�)',
	merchant_processing TINYINT(1) NOT NULL DEFAULT 0 COMMENT '�̼Ҵ�����(0=������ 1=ͬ�� 2=�ܾ�)',
	platform_processing TINYINT(1) COMMENT DEFAULT NULL 'ƽ̨������(0=������ 1=ͬ�� 2=�ܾ�)',
	`refund_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '�˿�״̬(0=������ 1=ͬ�� 2=�ܾ�)'
	refund_deadline DATETIME NOT NULL COMMENT '�˿������',
	audit_time DATETIME COMMENT '���ʱ��',
	merchant_reviewer BIGINT COMMENT '�̼������',
	platform_reviewer BIGINT COMMENT 'ƽ̨�����',
	refund_price DECIMAL(24,2) COMMENT '�˿��ֽ�',
	refund_integral DECIMAL(24,6) COMMENT '�˿����',
	refund_quantity BIGINT NOT NULL COMMENT '�˿�����', 
	has_deleted TINYINT(1) NOT NULL COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '��Ʒ�˿���Ϣ';


-- ����������Ϣ��
CREATE TABLE xec_order_delivery (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT NOT NULL COMMENT '���ݱ��',
	order_no BIGINT NOT NULL COMMENT '�������',
	`type` TINYINT(1) NOT NULL COMMENT '���ͷ�ʽ(1����,2����)',
	courier_number VARCHAR(50) COMMENT '��ݵ���(���ͷ�ʽѡ������)',
	courier_company_no BIGINT COMMENT '��ݹ�˾���(����xec_delivery_company)',
	self_pickup_code VARCHAR(50) COMMENT '������(���ͷ�ʽѡ������)',
	has_deleted TINYINT(1) NOT NULL COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '����������Ϣ';

-- ������ַ��Ϣ
CREATE TABLE xec_order_address (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT NOT NULL COMMENT '���ݱ��',
	order_no BIGINT NOT NULL COMMENT '�������',
	addr_no BIGINT COMMENT '�û���ַ���',
	area_code VARCHAR(20) COMMENT '������',
	detail_address VARCHAR(255) COMMENT '��ϸ��ַ',
	consignee VARCHAR(50) COMMENT '�ջ���',
	consignee_phone VARCHAR(15) COMMENT '�ջ����ֻ���',
	has_deleted TINYINT(1) NOT NULL COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��'	
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '������ַ��Ϣ';

-- ���ﳵ����
CREATE TABLE xec_shopping_cart (
	id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '����',
	`no` BIGINT NOT NULL COMMENT '���ݱ��',
	sku_no BIGINT NOT NULL COMMENT '��Ʒsku���',
	spu_no BIGINT NOT NULL COMMENT '��Ʒspu���',
	`user_id` BIGINT NOT NULL COMMENT '΢���û�id',
	shop_no BIGINT NOT NULL COMMENT '���̱��',
	quantity BIGINT COMMENT '��Ʒ����',
	commodity_info JSON NOT NULL COMMENT '��Ʒ��Ϣ',
  version DECIMAL(3,3) NOT NULL COMMENT '�汾��',	
	has_deleted TINYINT(1) NOT NULL COMMENT '�Ƿ�ɾ��(0��,1��)',
	create_user BIGINT NOT NULL COMMENT '������',
	create_time DATETIME NOT NULL COMMENT '����ʱ��',
	update_user BIGINT COMMENT '������',
	update_time DATETIME COMMENT '����ʱ��'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci Row_FORMAT = DYNAMIC COMMENT = '���ﳵ����';














