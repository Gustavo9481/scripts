from groq import Groq


client = Groq(api_key="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")

while True:
    response = input("\x1b[1;31m"+"Hola GUScode, en que puedo ayudarte?"+"\x1b[0m\n\n")
    if response.lower() == "salir":
        break

    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "user",
                "content": response,
            }
        ],
        model="llama3-8b-8192",
    )

    for choice in chat_completion.choices:
        print("\n\x1b[1;37m" + choice.message.content + "\x1b[0m\n")
