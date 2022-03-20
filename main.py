import undetected_chromedriver as uc
from bs4 import BeautifulSoup
import pandas as pd
import time
import os


from dotenv import load_dotenv
load_dotenv()

DB_NAME = os.getenv('DB_NAME')

currents_path = os.getcwd() + '/pages/'


def load_data(url, file_path):
    driver = uc.Chrome()
    try:
        driver.get(url)
        time.sleep(3)

    except Exception as ex:
        print(ex)
    finally:
        driver.close()
        driver.quit()
    return driver.page_source

if __name__ == '__main__':
    # with open(currents_path + 'sudact_ru.txt', 'w', encoding='utf-8') as f:
    #     f.write(load_data('https://sudact.ru/practice/poryadok-obsheniya-s-rebenkom/'))

    with open(currents_path + 'sudact_ru.txt','r', encoding='utf-8') as ff:
        soup = BeautifulSoup(ff.read(), 'lxml')
        quotes0 = soup.find_all('h4')
        data_list = []
        data_dict = {}
        for q in quotes0:
            quote = str(q)
            #print(quote)
            #print(quote.split('"_blank">')[1])
            data_dict['name']=str(quote.split('"_blank">')[1].split('</a')[0])
            data_dict['url']=str(quote.split('"')[1])
            data_list.append(data_dict)
        print(data_list)



