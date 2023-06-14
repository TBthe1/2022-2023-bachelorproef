from bs4 import BeautifulSoup
import requests
import re
import csv

url = "https://www.coureurlocal.be/product/giant-tcr-advanced-pro-disc-0-axs/"
result = requests.get(url)
doc = BeautifulSoup(result.text, "html.parser")

# Ophalen prijs
price_element = doc.find(string="€")
if price_element:
    price_element = price_element
    price_value = price_element.parent.next_sibling.strip()
    print(price_value)
else:
    print("Prijs van artikel niet gevonden.")

# Wegschrijven prijs naar CSV-bestand
csv_filename = "article_information.csv"
with open(csv_filename, "w", encoding="utf-8", newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["Prijs"])
    writer.writerow([price_value])

print(f"De prijs is succesvol weggeschreven naar {csv_filename}.")
