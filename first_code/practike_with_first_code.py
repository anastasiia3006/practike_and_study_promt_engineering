#test openai library and code
# цей код підключається до Gemini і працює з цим штучним інтелектом

import os
from google import genai
from google.genai import types

# 1. Налаштовуємо клієнта. Ключ автоматично береться зі змінної середовища
client = genai.Client()

print("Надсилаємо запит до моделі Gemini...")

# 2. Робимо API-запит
prompt = "Поясни, що таке RAG простими словами."

completion = client.models.generate_content(
    model='gemini-2.5-flash',
    contents=[
        # Увага: тут ми просто передаємо текст промпту,
        # а не обгортаємо його у складні структури types.Content та types.Part.
        # Це найпростіший спосіб для chat-моделей.
        prompt
    ]
)

# 3. Виводимо відповідь
response = completion.text
print("--- Відповідь ШІ Gemini ---")
print(response)
print("----------------------------")