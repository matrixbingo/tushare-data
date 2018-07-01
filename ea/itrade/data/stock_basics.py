# -*- coding: utf-8 -*-

import tushare as ts
from ea.itrade.db.mysql import *

# 股票列表
# http://www.waditu.cn/fundamental.html
if __name__ == "__main__":
    # engine = create_engine('mysql://root:root@127.0.0.1:3306/s_trade?charset=utf8')
    mysql = Mysql()
    cursor = mysql.getCursor()

    df = ts.get_stock_basics()

    for code, row in df.iterrows():
        try:
            cursor.callproc('t_addStock', args=(code, row['name'], row['industry'], row['area'], row['pe'], row['outstanding'], row['totals'], row['totalAssets'], row['liquidAssets'], row['fixedAssets'], row['reserved'], row['reservedPerShare'], row['esp'], row['bvps'], row['pb'], row['timeToMarket'], row['undp'], row['perundp'], row['rev'], row['profit'], row['gpr'], row['npr'], row['holders']))
        except:
            print (row)

    mysql.commit()
    mysql.close()

    # cols = ['code', 'name', 'industry', 'area', 'pe', 'outstanding', 'totals', 'totalAssets', 'liquidAssets', 'fixedAssets',
    #         'reserved', 'reservedPerShare', 'esp', 'bvps','bp', 'bptimeToMarket', 'undp', 'perundp', 'rev', 'profit', 'gpr', 'npr', 'holders']
    # cols = ['code', 'name']
    # df = df.ix[:, cols]
    # for i in df.index[::-1]:
    #     row = df.loc[i].copy()
    #     print(row)
    #
    # df.to_sql('t_stock', engine)
