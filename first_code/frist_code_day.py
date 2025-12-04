import os
from openai import OpenAI

# 1. Створюємо клієнта. Ключ автоматично береться зі змінної середовища
client = OpenAI()

print("Надсилаємо запит до моделі...")

# 2. Робимо API-запит
# "system" - дає інструкцію моделі (персона)
# "user" - це наш промпт
completion = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "system", "content": "Ти — експерт з AI-автоматизації."},
        {"role": "user", "content": "Поясни, що таке RAG простими словами."}
    ]
)

# 3. Виводимо відповідь
response = completion.choices[0].message.content
print("--- Відповідь ШІ ---")
print(response)
print("--------------------")