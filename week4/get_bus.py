import requests
import sys
import time
import csv

ARTICLE_SEARCH_URL = 'https://api.nytimes.com/svc/search/v2/articlesearch.json'

if __name__=='__main__':
    for p in range(0,100):
        params = {'api-key': "31fdc13a618c4f6f96cd1fda2ad05463",
                  'fq': "section_name: business",
                  'sort': "newest",
                  'fl' : "section_name,web_url,pub_date,snippet",
                  'page' : p}
        r = requests.get(ARTICLE_SEARCH_URL, params)
        time.sleep(1.5)

        data = r.json()

        bus_data = open('bus.tsv', 'a')
        bus = csv.writer(bus_data, delimiter = '\t')
        for doc in data['response']['docs']:
            bus.writerow(doc.values())
        bus_data.close()
