import datetime
import json
import requests
import os
from os.path import isfile, join, exists

YAURL = 'https://yastat.net/s3/milab/2020/podomam/data/index_data.json?ts=1586875226'

YADIR = r'YOURDIRECTORR'

timeexec= datetime.datetime.now().strftime('%Y%m%d%H%M')
print(timeexec)

page = requests.get(YAURL)
data = json.loads(page.content)

with open(os.path.join(YADIR, timeexec + '.json'), 'w') as json_file:
    json.dump(data, json_file)