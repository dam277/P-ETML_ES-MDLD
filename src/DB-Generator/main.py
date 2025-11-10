from database.Database import Database
from dotenv import load_dotenv
import json
from pprint import pprint

def main():
    db_instance = Database()
    print("Database instance created:", db_instance)

    with open("tables.json", "r") as file:
        tables = json.load(file)
        pprint(tables)

    for table, columns in tables.items():
        print(f"Table: {table}")
        pprint(f"Generating data for table: {columns}")
        # db_instance.generate(table, columns, num_rows=10)
        

if __name__ == "__main__":
    load_dotenv()
    main()