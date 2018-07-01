import tushare as ts
import pymysql

# 股票列表
# http://www.waditu.cn/fundamental.html
if __name__ == "__main__":
    # engine = create_engine('mysql://root:root@127.0.0.1:3306/s_trade?charset=utf8')
    conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='root', db='s_trade', charset='utf8')
    cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)

    df = ts.get_stock_basics()

    for code, row in df.iterrows():
        cursor.callproc('t_addStock', args=(code, row['name'], row['industry'], row['area'], row['pe'], row['outstanding'], row['totals'], row['totalAssets'], row['liquidAssets'], row['fixedAssets'], row['reserved'], row['reservedPerShare'], row['esp'], row['bvps'], row['pb'], row['timeToMarket'], row['undp'], row['perundp'], row['rev'], row['profit'], row['gpr'], row['npr'], row['holders']))

    # cols = ['code', 'name', 'industry', 'area', 'pe', 'outstanding', 'totals', 'totalAssets', 'liquidAssets', 'fixedAssets',
    #         'reserved', 'reservedPerShare', 'esp', 'bvps','bp', 'bptimeToMarket', 'undp', 'perundp', 'rev', 'profit', 'gpr', 'npr', 'holders']
    # cols = ['code', 'name']
    # df = df.ix[:, cols]
    # for i in df.index[::-1]:
    #     row = df.loc[i].copy()
    #     print(row)
    #
    # df.to_sql('t_stock', engine)
    conn.commit()
    cursor.close()
    conn.close()