from bs4 import BeautifulSoup

with open("index.html", "r") as f:
    doc = BeautifulSoup(f, "html.parser")

# print(doc.prettify())

# tag = doc.title
# tags = doc.find_all("p")
tags = doc.find_all("p")[0]
# tag.string = "hello"

# print(tag.string)
# print(tags)
print(tags.find_all("b"))
