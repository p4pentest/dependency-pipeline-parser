import bs4
import sys

from bs4 import BeautifulSoup as bs
content = []

report = str(sys.argv[1:][0])
findsev = str(sys.argv[2:][0])

with open(report, "r") as file:

    content = file.readlines()

    content = "".join(content)
    bs_content = bs(content, "xml")

    count = 0
    tot = 0
    for vul in bs_content.find_all('vulnerability'):
	for sev in vul.findAll('severity', {"class": None}, recursive=False):
    		if sev.text == findsev:
    			count = count + 1
    		tot = tot + 1
    print(count)
    print(tot)
