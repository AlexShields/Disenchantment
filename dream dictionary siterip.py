pip install beautifulsoup4
pip install requests

import requests
from bs4 import BeautifulSoup

# URL of the dream dictionary page
url = "https://www.cafeausoul.com/oracles/dream-dictionary"

# Send a GET request to the URL
response = requests.get(url)
html_content = response.text

# Parse the HTML content using BeautifulSoup
soup = BeautifulSoup(html_content, "html.parser")

# Find all the h3 elements with the dream dictionary entries
entry_elements = soup.find_all("h3")

# Initialize an empty list to store the results
results = []

# Loop through each entry element and extract the entry and its definition
for entry_element in entry_elements:
    entry = entry_element.get_text()
    entry_link = entry_element.find("a")["href"]
    entry_url = f"https://www.cafeausoul.com{entry_link}"

    entry_response = requests.get(entry_url)
    entry_html_content = entry_response.text
    entry_soup = BeautifulSoup(entry_html_content, "html.parser")

    definition_element = entry_soup.find("p", class_="typography-module--paragraph---kHwl")
    if definition_element:
        definition = definition_element.get_text()
    else:
        definition = "Definition not found"

    results.append([entry, definition])

# Print the results
for entry, definition in results:
    print(f"Entry: {entry}")
    print(f"Definition: {definition}")
    print("=" * 40)