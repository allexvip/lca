import logging
import undetected_chromedriver as uc
from bs4 import BeautifulSoup
import sqlite3 as sq
import pandas as pd
import random
import time
import os
import re
import urllib.request
from dotenv import load_dotenv
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)


DB_NAME = os.getenv('DB_NAME')
DB_FILE_NAME = os.getenv('DB_FILE_NAME')
DEBUG_FLAG = os.getenv('DEBUG_FLAG')
currents_path = os.getcwd() + '/pages/'
con = None
cur = None


def sql_start():
    global con, cur
    con = sq.connect(DB_FILE_NAME)
    cur = con.cursor()
    if con:
        print('DB connected')

def load_data(url):
    result = ''
    global driver
    try:
        driver.get(url)
        time.sleep(random.randint(3,7))
        result = driver.page_source
    except Exception as ex:
        print(ex)
    # finally:
    #     driver.close()
    #     driver.quit()
    return result

def take_result(url):
    text = load_data(url)
    if '<br><br>РЕШИЛ<br><br>' in text and '<div class="adv_inside_text">' in text:
        text = text.split('<br><br>РЕШИЛ<br><br>')[1].split('<div class="adv_inside_text">')[0]
    res = re.sub(r"<[^>]+>", "", str(text), flags=re.S)
    return res

def take_data(items):
    data_list = []
    for item in items:
        data_dict = {}
        item_str = str(item)
        data_dict['name'] = str(item_str.split('"_blank">')[1].split('</a')[0])
        data_dict['url'] = str(item_str.split('"')[1])
        data_dict['id'] = data_dict['url'].split('/')[-2]
        data_dict['result_all'] = load_data('https://sudact.ru/regular/doc/{0}/'.format(data_dict['id'])) #take_result('https://sudact.ru/regular/doc/{0}/'.format(data_dict['id']))
        data_list.append(data_dict)
        print(data_list)
    return data_list

def list_db(table_name,r):
    print(r)
    df = pd.DataFrame(r)
    if DEBUG_FLAG:
        print(df)
    df.to_sql(name=table_name, con=con,if_exists='append',index=False)

def get_page_links(table_name,page_text):
        soup = BeautifulSoup(page_text, 'lxml')
        source_list = soup.find_all('h4')
        data_list = take_data(source_list)
        list_db(table_name,data_list)
    #os.remove(currents_path + 'sudact_ru.txt')

def get_page_links_from_file():
    with open(currents_path + 'sudact_ru.txt', 'r', encoding='utf-8') as ff:
        soup = BeautifulSoup(ff.read(), 'lxml')
        source_list = soup.find_all('h4')
        data_list = take_data(source_list)
        list_db('table_name',data_list)
    #os.remove(currents_path + 'sudact_ru.txt')

if __name__ == '__main__':
    sql_start()
    driver = uc.Chrome()
    for page_number in range(3,51):
        print('Reading page:',page_number)
        if page_number>1:
            #https://sudact.ru/practice/poryadok-obsheniya-s-rebenkom/?page=2
            page_str = '?page='+str(page_number)
        else:
            page_str = ''

        try:
            driver.get('https://sudact.ru/practice/poryadok-obsheniya-s-rebenkom/{0}'.format(page_str))
            time.sleep(random.randint(3,7))
            page_text = driver.page_source
        except Exception as ex:
            print(ex)
        get_page_links('comm_order',page_text)

    #load_data('https://sudact.ru/regular/doc/52wA2ZpV3xlu/')
    # with open(currents_path + 'sudact_ru_52wA2ZpV3xlu.txt', 'w', encoding='utf-8') as f:
    #     f.write(load_data('https://sudact.ru/regular/doc/52wA2ZpV3xlu/'))

    # with open(currents_path + 'sudact_ru_52wA2ZpV3xlu.txt', 'r', encoding='utf-8') as f:
    #     ff = f.read()
    #     text = ff.split('<br><br>РЕШИЛ<br><br>')[1].split('<div class="adv_inside_text">')[0]
    #     res = re.sub(r"<[^>]+>", "", str(text), flags=re.S)
    #     print(res)
        #
    driver.close()
    driver.quit()

