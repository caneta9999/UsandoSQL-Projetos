#Credits: ChatGPT
import pandas as pd
import pyperclip
import re

insert_statements = ''


def clean_string(text):
    text_without_linebreaks = re.sub(r'[\n\r\f\v]+', ' ', text)
    text_without_quotes = re.sub(r"[\"']", '', text_without_linebreaks)
    return text_without_quotes

def generate_insert_statements(excel_file, table_name):
    df = pd.read_excel(excel_file)
    if 'AnswerText' in df.columns:
        df['AnswerText'] = df['AnswerText'].astype(str)
        df['AnswerText'] = df['AnswerText'].map(clean_string)
    if 'questiontext' in df.columns:
        df['questiontext'] = df['questiontext'].astype(str)
        df['questiontext'] = df['questiontext'].map(clean_string)
    
    insert = ''
    for index, row in df.iterrows():
        
        columns = ', '.join([f"[{col}]" for col in row.index])
        values = ', '.join([str(value) if 'ID' in str(col) else f"'{value}'" for col, value in zip(row.index, row)])
        insert += f"INSERT INTO {table_name} ({columns}) VALUES ({values})\n"
    return insert

excel_file = 'Question.xlsx'
table_name = 'Question'

insert_statements = generate_insert_statements(excel_file, table_name)
pyperclip.copy(insert_statements)
