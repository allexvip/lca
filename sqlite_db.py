import logging
import sqlite3 as sq
import pandas as pd
from main import DB_FILE_NAME
from sqlalchemy import create_engine
import datetime


async def get_data(sql):
    try:
        cur.execute(sql)
        con.commit()
    except Exception as e:
        logging.info('SQL exception get_data(): ' + str(e))
    return cur.fetchall()

async def send_full_text(chat_id, info):
    if len(info) > 4096:
        for x in range(0, len(info), 4096):
            await bot.send_message(chat_id, info[x:x + 4096])
    else:
        await bot.send_message(chat_id, info)


async def get_df(sql):
    df = pd.read_sql(sql, create_engine(f'sqlite:///{DB_FILE_NAME}'))
    return df

def sql_start():
    global con, cur
    con = sq.connect(DB_FILE_NAME)
    cur = con.cursor()
    if con:
        print('DB connected')
    # con.execute('Create table if not exists menu(img TEXT, name TEXT PRIMARY KEY, description TEXT, price TEXT)')
    # con.commit()