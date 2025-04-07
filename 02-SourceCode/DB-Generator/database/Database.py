from mysql.connector import connect, Error
from dotenv import load_dotenv, dotenv_values
import os
import random
import string
from pprint import pprint

class Database:
    instance: "Database" = None

    def get_instance(self) -> "Database":
        if not Database.instance:
            Database.instance = Database()
        return Database.instance
    
    def __init__(self):
        configs = dotenv_values(".env")
        self.host = configs["DB_HOST"]
        self.user = configs["DB_USER"]
        self.password = configs["DB_PASSWORD"]
        self.database = configs["DB_NAME"]
        self.port = configs["DB_PORT"]
        self.connection = connect(
            host=self.host,
            user=self.user,
            password=self.password,
            database=self.database,
            port=self.port
        )

    def generate(self, table: str, columns: dict, num_rows: int) -> None:
        cursor = self.connection.cursor()
        print("Columns:")
        pprint(columns)
        rows: list = []
        for i in range(num_rows):
            row = [self.generate_value(name, type) for name, type in columns.items()]
            rows.append(row)

        print(f"Generated {num_rows} rows for table {table}.")
        placeholders = ", ".join(["%s"] * len(columns))
        columns_names = ", ".join(columns.keys())
        sql = f"INSERT INTO {table} ({columns_names}) VALUES ({placeholders})"
        
        for row in rows:
            cursor.execute(sql, row)
        
        self.connection.commit()
        cursor.close()
        print(f"Inserted {num_rows} rows into table {table}.")

    def generate_value(self, name: str, type: str):
        if "id" in name.lower():
            return None

        match type:
            case "int":
                return self.generate_int()
            case "float":
                return self.generate_float()
            case "str":
                return self.generate_str()
            case "bool":
                return self.generate_bool()
            case _:
                raise ValueError(f"Unsupported type: {type}")

    def generate_int(self) -> int:
        return random.randint(0, 100)

    def generate_float(self) -> float:
        return random.uniform(0.0, 100.0)

    def generate_str(self) -> str:
        length = random.randint(5, 15)
        return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

    def generate_bool(self) -> bool:
        return random.choice([True, False])
    
        

