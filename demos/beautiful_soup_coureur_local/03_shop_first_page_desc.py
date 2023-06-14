import csv
import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import re

# Definieer de URL van de website
base_shop_url = "https://www.coureurlocal.be/shop/"
base_product_url = "https://www.coureurlocal.be/product/"

# Maak een GET-verzoek naar de website
response = requests.get(base_shop_url)

# Parse de HTML-content van de website
soup = BeautifulSoup(response.content, "html.parser")

# Vind alle articles op de pagina
articles = soup.find_all("div", class_="product-small")

# Maak een set voor unieke combinaties van categorie, naam en prijs
unieke_combinaties = set()

# Open het csv-bestand in schrijfmodus en definieer de headers
with open("articles.csv", "w", newline="", encoding="utf-8") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=[
                            "Afbeeldingen", "Categorieën", "Naam", "Prijs", "Beschrijving"], delimiter=";")
    writer.writeheader()

    # Gebruik tqdm voor iteratie met voortgangsbalk
    for fiets in tqdm(articles, desc="Webscraping voortgang", unit="fiets"):
        afbeelding = fiets.find("img")["src"]
        categorie_elementen = fiets.find_all("p", class_="category")
        categorieën = []
        for categorie_element in categorie_elementen:
            categorie_text = categorie_element.text.strip()
            if " en " in categorie_text:
                categorieën.extend([categorie.strip() for categorie in categorie_text.split(" en ")])
            elif "," in categorie_text:
                categorieën.extend([categorie.strip() for categorie in categorie_text.split(",")])
            else:
                categorieën.append(categorie_text.strip())
        # Capitalize the first letter of each word in the category
        categorieën = [re.sub(r"(^|\s)(\w)", lambda m: m.group(1) + m.group(2).upper(), categorie) for categorie in categorieën]
        naam = fiets.find("p", class_="name").text.strip()
        prijs_span = fiets.find(string="€")
        prijs = prijs_span.parent.next_sibling.strip()

        # Controleer of de combinatie van afbeelding, categorieën, naam en prijs al eerder is toegevoegd
        combinatie = (afbeelding, tuple(categorieën), naam, prijs)
        if combinatie in unieke_combinaties:
            continue  # Sla deze fiets over als de combinatie al eerder is toegevoegd

        # Voeg de combinatie toe aan de set van unieke combinaties
        unieke_combinaties.add(combinatie)

        # Combineer de categorieën met een scheidingsteken
        categorieën_str = ", ".join(categorieën)

        # Maak het product-URL voor de specifieke productpagina
        product_url = base_product_url + "{}/".format(naam.lower().replace(" ", "-"))

        # Maak een GET-verzoek naar de productpagina
        product_response = requests.get(product_url)
        product_soup = BeautifulSoup(product_response.content, "html.parser")

        # Vind de productbeschrijving op de productpagina
        beschrijving_element = product_soup.select_one('div[class*="description"]')
        beschrijving = beschrijving_element.text.strip() if beschrijving_element else ""

        # Schrijf de gegevens naar het csv-bestand
        writer.writerow({
            "Afbeeldingen": afbeelding,
            "Categorieën": categorieën_str,
            "Naam": naam,
            "Prijs": prijs,
            "Beschrijving": beschrijving
        })

print("Het csv-bestand is succesvol aangemaakt.")
