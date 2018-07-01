import tushare as ts



if __name__ == "__main__":
    df = ts.get_sina_dd('300139', date='2018-6-15')
    print (df)
