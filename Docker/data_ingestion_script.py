# Import necessary libraries

import requests #Sending and receiving HTTP requests
from bs4 import BeautifulSoup #Parsing and navigation of HTML and XML web pages
import pandas as pd #Used for data manipulation and analysis

# URL for the webpage to be scraped
url = 'https://www.petsecure.com.au/pet-care/a-guide-to-worldwide-pet-ownership/'

# Send a request to the webpage
response = requests.get(url)

# Parse the HTML content using Beautiful Soup
soup = BeautifulSoup(response.content, 'html.parser')

# Find the table with class 'cat'
table = soup.find('table', {'class': 'cats'})

# Extract the table headers
headers = []
for th in table.find_all('th'):
    headers.append(th.text.strip())

# Extract the table data
data = []
for tr in table.find_all('tr'):
    row_data = []
    for td in tr.find_all('td'):
        row_data.append(td.text.strip())
    if len(row_data) > 0:
        data.append(row_data)

# Create a Pandas DataFrame for the table data
population_df = pd.DataFrame(data, columns=headers)

# Print the DataFrame
population_df

# Rename columns
population_df = population_df.rename(columns={population_df.columns[0]:'country',population_df.columns[1]:'cat_population'})

# Import necessary libraries
import requests
import pandas as pd

# URL for the Open Cage API
url = 'https://api.opencagedata.com/geocode/v1/json'

# API key for Open Cage
api_key = 'a34768ccd55d49cfa29fb5753e2d1486'

# Extract the list of countries from the DataFrame
countries = population_df['country'].tolist()

# Create a dictionary of the components data for each country
components_list = []

# Loop through each country and make a request to the Open Cage API
for country in countries:
    # Create the API request parameters
    params = {'q': country, 'key': api_key}

    # Send a request to the API
    response = requests.get(url, params=params)

    # Parse the JSON response
    json_data = response.json()

    # Extract the components data from the JSON response
    components = json_data['results'][0]['components']

    # Create a dictionary of the components data for this country
    country_components = {'country': country,
                          'country_code': components.get('country_code', ''),
                          'latitude': json_data['results'][0]['geometry']['lat'],
                          'longitude': json_data['results'][0]['geometry']['lng']}

    # Append the dictionary to a list of dictionaries
    components_list.append(country_components)

# Create a DataFrame for the components data
components_df = pd.DataFrame(components_list)
components_df


# Import necessary libraries
import pandas as pd
import PyGreSQL

# Connect to the database
host = 'localhost'
port = 5432
database = 'docker'
username = 'postgres'
password = '1234'
connection = PyGreSQL.connect(host=host, port=port, db=database, user=username, password=password)

# Retrieve data from the pet_stores table
query = "SELECT country,total_pet_store FROM pet_stores"
pet_stores_df = pd.read_sql(query, connection)
# # Close the database connection
connection.close()

pet_stores_df