from bs4 import BeautifulSoup
import requests

url = "https://www.newegg.ca/gigabyte-geforce-rtx-4060-ti-gv-n406teagle-8gd/p/N82E16814932620"

result = requests.get(url)
# print(result.text)
doc = BeautifulSoup(result.text, "html.parser")
# print(doc.prettify())

prices = doc.find_all(string="$")
# print(prices)
parent = prices[0].parent
# print(parent)
strong = parent.find("strong")
print(strong.string)
