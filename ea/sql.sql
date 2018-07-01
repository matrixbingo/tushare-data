DROP TABLE IF EXISTS `t_stock`;
CREATE TABLE `t_stock` (
  `code` varchar(20) NOT NULL COMMENT '股票代码',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '股票名称',
  `industry` varchar(30) NOT NULL DEFAULT '' COMMENT '所属行业',
  `area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区',
  `pe` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '市盈率',
  `outstanding` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '流通股本(亿)',
  `totals` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '总股本(亿)',
  `totalAssets` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '总资产(万)',
  `liquidAssets` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '流动资产',
  `fixedAssets` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '固定资产',
  `reserved` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '公积金',
  `reservedPerShare` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '每股公积金',
  `esp` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '每股收益',
  `bvps` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '每股净资',
  `pb` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '市净率',
  `timeToMarket` bigint(20) DEFAULT NULL COMMENT '上市日期',
  `undp` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '未分利润',
  `perundp` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '每股未分配',
  `rev` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '收入同比(%)',
  `profit` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '利润同比(%)',
  `gpr` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '毛利率(%)',
  `npr` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '净利润率(%)',
  `holders` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '股东人数',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='`个股信息`';


DROP PROCEDURE IF EXISTS t_addStock;
create procedure t_addStock(in p_code varchar(20), in p_name varchar(20), in p_industry varchar(30), in p_area varchar(30), in p_pe decimal(8,2), in p_outstanding decimal(8,2), in p_totals decimal(8,2),
														in p_totalAssets decimal(15,2), in p_liquidAssets decimal(15,2), in p_fixedAssets decimal(15,2), in p_reserved decimal(15,2), in p_reservedPerShare decimal(8,2), in p_esp decimal(8,3), in p_bvps decimal(8,2), in p_pb decimal(8,2),
														in p_timeToMarket bigint(20), in p_undp decimal(15,2), in p_perundp decimal(8,2), in p_rev decimal(15,2), in p_profit decimal(8,2), in p_gpr decimal(8,2), in p_npr decimal(8,2), in p_holders decimal(15,2))
BEGIN

	declare v_cno int;
	declare v_max int;

	select code into v_cno from t_stock where code = p_code limit 1;
	IF (v_cno is null)  THEN
			replace into t_stock(code, name, industry, area, pe, outstanding, totals, totalAssets, liquidAssets, fixedAssets, reserved, reservedPerShare, esp, bvps, pb, timeToMarket, undp, perundp, rev, profit, gpr, npr, holders)
      VALUES(p_code, p_name, p_industry, p_area, p_pe, p_outstanding, p_totals, p_totalAssets, p_liquidAssets, p_fixedAssets, p_reserved, p_reservedPerShare, p_esp, p_bvps, p_pb, p_timeToMarket, p_undp, p_perundp, p_rev, p_profit, p_gpr, p_npr, p_holders);
	ELSE
      UPDATE t_stock SET name = p_name, industry = p_industry, area = p_area, pe = p_pe, outstanding = p_outstanding, totals = p_totals, totalAssets = p_totalAssets,
													liquidAssets = p_liquidAssets, fixedAssets = p_fixedAssets, reserved = p_reserved, reservedPerShare = p_reservedPerShare, esp = p_esp, bvps = p_bvps, pb = p_pb,
													timeToMarket = p_timeToMarket, undp = p_undp, perundp = p_perundp, rev = p_rev, profit = p_profit, gpr = p_gpr, npr = p_npr, holders = p_holders
      WHERE code = p_code;
  END IF;

END;