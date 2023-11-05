#Credits: ChatGPT

import sqlite3
from openpyxl import Workbook
import os

def export_sqlite_file_to_excel(sqlite_filename, table_name, excel_filename):
    conn = sqlite3.connect(sqlite_filename)

    cursor = conn.cursor()

    cursor.execute(f"PRAGMA table_info({table_name})")
    column_info = cursor.fetchall()
    column_names = [col[1] for col in column_info]

    cursor.execute(f"SELECT * FROM {table_name}")
    data = cursor.fetchall()

    workbook = Workbook()
    sheet = workbook.active
    sheet.append(column_names)

    for row in data:
        sheet.append(row)

    workbook.save(excel_filename)

    cursor.close()
    conn.close()

sqlite_filename = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'mental_health.sqlite')
tables = ['Answer', 'Question', 'Survey']  

for table in tables:
    excel_filename = f"{table}.xlsx"
    export_sqlite_file_to_excel(sqlite_filename, table, excel_filename)
