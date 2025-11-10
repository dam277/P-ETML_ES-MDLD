import os
import csv
import random
from datetime import date, timedelta
from faker import Faker

fake = Faker('en_US') # Use US locale for realistic names, addresses, etc.

# --- Configuration ---
NUM_ROWS_PER_TABLE = 1000
NUM_ROWS_GAME = 10000

# Directory for output CSVs
output_dir = "realistic_data_csv"
os.makedirs(output_dir, exist_ok=True)

# Helper function to write data to CSV
def write_to_csv(filename, header, data):
    filepath = os.path.join(output_dir, filename)
    with open(filepath, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(data)
    print(f"Generated {len(data)} rows for {filename}")

# --- Data Generation Functions ---

def generate_person_data(num_rows):
    data = []
    headers = ["ID_PERSON", "PERNAME", "PERSURNAME", "PEREMAIL", "PERBIRTHDATE", "PERCREATIONDATE"]
    for i in range(1, num_rows + 1):
        id_person = i
        pername = fake.first_name()
        persurname = fake.last_name()
        peremail = fake.email()
        perbirthdate = fake.date_of_birth(minimum_age=18, maximum_age=70).strftime('%Y-%m-%d')
        percreationdate = fake.date_this_decade().strftime('%Y-%m-%d')
        data.append([id_person, pername, persurname, peremail, perbirthdate, percreationdate])
    return headers, data

def generate_language_data(num_rows):
    data = []
    headers = ["ID_LANGUAGE", "LANCODE", "LANNAME"]
    languages = [
        ("en", "English"), ("fr", "French"), ("de", "German"), ("es", "Spanish"),
        ("it", "Italian"), ("ja", "Japanese"), ("ko", "Korean"), ("zh", "Chinese (Simplified)"),
        ("pt", "Portuguese (Brazil)"), ("ru", "Russian"), ("ar", "Arabic"), ("hi", "Hindi")
    ]
    for i in range(min(num_rows, len(languages))):
        id_language = i + 1
        lancode, lanname = languages[i]
        data.append([id_language, lancode, lanname])
    # Add more generic ones if num_rows is larger than predefined
    for i in range(len(languages), num_rows):
        id_language = i + 1
        lancode = fake.lexify(text='??', letters='abcdefghijklmnopqrstuvwxyz')
        lanname = fake.word().capitalize() + " Language"
        data.append([id_language, lancode, lanname])
    return headers, data

def generate_user_data(num_rows, person_ids, language_ids):
    data = []
    headers = ["ID_PERSON", "ID_LANGUAGE", "USEPASSWORD", "USEDISPLAYNAME"]
    # Ensure unique person IDs for users if possible
    selected_person_ids = random.sample(person_ids, min(num_rows, len(person_ids)))
    for i, id_person in enumerate(selected_person_ids):
        id_language = random.choice(language_ids)
        usepassword = fake.sha256() # Simulates a hashed password
        usedisplayname = fake.user_name() + str(i)
        data.append([id_person, id_language, usepassword, usedisplayname])
    return headers, data

def generate_publisher_data(num_rows, person_ids):
    data = []
    headers = ["ID_PERSON"]
    selected_person_ids = random.sample(person_ids, min(num_rows, len(person_ids)))
    for id_person in selected_person_ids:
        data.append([id_person])
    return headers, data

def generate_developer_data(num_rows, person_ids):
    data = []
    headers = ["ID_PERSON"]
    selected_person_ids = random.sample(person_ids, min(num_rows, len(person_ids)))
    for id_person in selected_person_ids:
        data.append([id_person])
    return headers, data

def generate_product_data(num_rows):
    data = []
    headers = ["ID_PRODUCT", "PROTITLE", "PRODESCRIPTION", "PRORELEASEDATE", "PROPRICE", "PRODISCOUNT", "PROREWARDPERCENTAGE", "PROREFUNDABLE"]
    game_genres = ["Action", "Adventure", "RPG", "Strategy", "Simulation", "Sports", "Puzzle", "Horror", "Fighting", "Racing", "Platformer", "Indie", "Casual", "MMORPG", "Shooter"]
    for i in range(1, num_rows + 1):
        id_product = i
        protitle = f"{fake.catch_phrase()} - {random.choice(game_genres)} Game"
        prodescription = fake.paragraph(nb_sentences=3)
        proreleasedate = fake.date_between(start_date='-10y', end_date='today').strftime('%Y-%m-%d')
        proprice = round(random.uniform(4.99, 69.99), 2)
        prodiscount = round(random.uniform(0.00, 0.75), 2) if random.random() < 0.3 else 0.00 # 30% chance of discount
        prorewardpercentage = random.choice([0, 5, 10, 15, 20]) if random.random() < 0.6 else None
        prorefundable = random.choice([True, False])
        data.append([id_product, protitle, prodescription, proreleasedate, proprice, prodiscount, prorewardpercentage, prorefundable])
    return headers, data

def generate_game_data(num_rows, product_ids, publisher_ids, developer_ids):
    data = []
    headers = ["ID_PRODUCT", "ID_PUBLISHER", "ID_DEVELOPER", "ISDEMO"]
    # Ensure unique product IDs for games if num_rows <= len(product_ids)
    selected_product_ids = random.sample(product_ids, min(num_rows, len(product_ids)))

    for id_product in selected_product_ids:
        id_publisher = random.choice(publisher_ids)
        id_developer = random.choice(developer_ids)
        isdemo = random.choice([True, False])
        data.append([id_product, id_publisher, id_developer, isdemo])
    return headers, data

def generate_redeemcode_data(num_rows, product_ids):
    data = []
    headers = ["ID_REDEEMCODE", "ID_PRODUCT", "REDCODE", "REDEXPIRESAT", "REDREDEEMEDAT", "REDISACTIVE"]
    for i in range(1, num_rows + 1):
        id_redeemcode = i
        id_product = random.choice(product_ids)
        redcode = fake.md5() # Realistic-looking code
        redexpiresat = fake.date_between(start_date='today', end_date='+2y').strftime('%Y-%m-%d')
        redredeemedat = fake.date_between(start_date='-1y', end_date='today').strftime('%Y-%m-%d') if random.random() < 0.4 else '' # Null represented as empty string for CSV
        redisactive = random.choice([True, False])
        data.append([id_redeemcode, id_product, redcode, redexpiresat, redredeemedat, redisactive])
    return headers, data

def generate_paymentmethod_data(num_rows):
    data = []
    headers = ["ID_PAYMENTMETHOD", "PAYNAME", "PAYENABLED", "PAYFEEPERCENT"]
    method_names = ["Credit Card (Visa)", "Credit Card (Mastercard)", "PayPal", "Bank Transfer", "Steam Wallet", "Apple Pay", "Google Pay", "Crypto Payment"]
    for i in range(1, num_rows + 1):
        id_paymentmethod = i
        payname = random.choice(method_names) if i <= len(method_names) else f"Custom Method {i}"
        payenabled = random.choice([True, True, True, False]) # More likely to be enabled
        payfeepercent = round(random.uniform(0.00, 0.03), 2) if "Credit Card" in payname or "PayPal" in payname else 0.00
        data.append([id_paymentmethod, payname, payenabled, payfeepercent])
    return headers, data

def generate_purchase_data(num_rows, user_ids, payment_method_ids):
    data = []
    headers = ["ID_PURCHASE", "ID_PAYMENTMETHOD", "ID_PERSON", "PURPRICEPAID", "PURDATE"]
    for i in range(1, num_rows + 1):
        id_purchase = i
        id_paymentmethod = random.choice(payment_method_ids)
        id_person = random.choice(user_ids)
        purpricepaid = round(random.uniform(0.99, 150.00), 2)
        purdate = fake.date_between(start_date='-3y', end_date='today').strftime('%Y-%m-%d')
        data.append([id_purchase, id_paymentmethod, id_person, purpricepaid, purdate])
    return headers, data

def generate_engine_data(num_rows):
    data = []
    headers = ["ID_ENGINE", "ENGNAME"]
    engine_names = ["Unreal Engine", "Unity", "Godot Engine", "CryEngine", "Source Engine", "Frostbite", "REDengine", "In-house Engine (ABC)", "Custom 3D Engine"]
    for i in range(1, num_rows + 1):
        id_engine = i
        engname = random.choice(engine_names) if i <= len(engine_names) else f"Engine {i}"
        data.append([id_engine, engname])
    return headers, data

def generate_version_data(num_rows, game_ids, engine_ids):
    data = []
    headers = ["ID_VERSION", "ID_ENGINE", "ID_PRODUCT", "VERNAME", "VERCHANGELOG", "VERRELEASEDATE", "VERISMAJOR"]
    for i in range(1, num_rows + 1):
        id_version = i
        id_engine = random.choice(engine_ids)
        id_product = random.choice(game_ids)
        vername = f"{random.randint(1,5)}.{random.randint(0,9)}.{random.randint(0,9)}"
        verchangelog = fake.sentence(nb_words=10) if random.random() < 0.8 else '' # Optional changelog
        verreleasedate = fake.date_between(start_date='-2y', end_date='today').strftime('%Y-%m-%d')
        verismajor = random.choice([True, False, False, False]) # More likely to be minor
        data.append([id_version, id_engine, id_product, vername, verchangelog, verreleasedate, verismajor])
    return headers, data

def generate_genre_data(num_rows):
    data = []
    headers = ["ID_GENRE", "GENNAME"]
    genres = [
        "Action", "Adventure", "RPG", "Strategy", "Simulation", "Sports", "Puzzle", "Horror",
        "Fighting", "Racing", "Platformer", "Stealth", "Survival", "MMORPG", "Casual",
        "Open World", "FPS", "RTS", "Turn-Based", "Indie", "Party", "Educational", "Arcade"
    ]
    for i in range(1, num_rows + 1):
        id_genre = i
        genname = random.choice(genres) if i <= len(genres) else fake.word().capitalize() + " Genre"
        data.append([id_genre, genname])
    return headers, data

# --- Main Generation Process ---

print("Starting realistic data generation...")

# Generate core entities first to get IDs for foreign keys
headers_person, person_data = generate_person_data(NUM_ROWS_PER_TABLE * 3) # More persons to distribute among roles
person_ids = [row[0] for row in person_data]
write_to_csv("PERSON.csv", headers_person, person_data)

headers_language, language_data = generate_language_data(50) # A reasonable number of languages
language_ids = [row[0] for row in language_data]
write_to_csv("LANGUAGE.csv", headers_language, language_data)

headers_product, product_data = generate_product_data(NUM_ROWS_GAME + NUM_ROWS_PER_TABLE * 3) # Enough products for games, DLCs, bundles etc.
product_ids = [row[0] for row in product_data]
write_to_csv("PRODUCT.csv", headers_product, product_data)

# Game table needs specific large number of rows
headers_game, game_data = generate_game_data(NUM_ROWS_GAME, product_ids[:NUM_ROWS_GAME], publisher_ids, developer_ids) # Use first N products as games
game_ids = [row[0] for row in game_data] # These are the product IDs that are also games
write_to_csv("GAME.csv", headers_game, game_data)

# Remaining tables (1000 rows each)
headers_redeemcode, redeemcode_data = generate_redeemcode_data(NUM_ROWS_PER_TABLE, product_ids)
write_to_csv("REDEEMCODE.csv", headers_redeemcode, redeemcode_data)

headers_paymentmethod, paymentmethod_data = generate_paymentmethod_data(50) # Few payment methods are enough
payment_method_ids = [row[0] for row in paymentmethod_data]
write_to_csv("PAYMENTMETHOD.csv", headers_paymentmethod, paymentmethod_data)

headers_purchase, purchase_data = generate_purchase_data(NUM_ROWS_PER_TABLE, user_ids, payment_method_ids)
purchase_ids = [row[0] for row in purchase_data]
write_to_csv("PURCHASE.csv", headers_purchase, purchase_data)

headers_engine, engine_data = generate_engine_data(50) # Few engines are enough
engine_ids = [row[0] for row in engine_data]
write_to_csv("ENGINE.csv", headers_engine, engine_data)

headers_version, version_data = generate_version_data(NUM_ROWS_PER_TABLE, game_ids, engine_ids)
write_to_csv("VERSION.csv", headers_version, version_data)

headers_genre, genre_data = generate_genre_data(50) # Few genres are enough
genre_ids = [row[0] for row in genre_data]
write_to_csv("GENRE.csv", headers_genre, genre_data)

print("\nAll specified CSV data generated in the 'realistic_data_csv' directory.")
print("Remember to load data into parent tables (e.g., PERSON, PRODUCT) before child tables (e.g., USER, GAME) due to foreign key constraints.")