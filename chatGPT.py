import openai
import firebase_admin
from firebase_admin import db


#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

openai.api_key = "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"

def chat_with_chatgpt(prompt, system_prompt, model="gpt-3.5-turbo"):
    client = openai.OpenAI(api_key="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")
    response = client.chat.completions.create(
        model=model,
        messages = [
          {"role": "system", "content":     system_prompt},
          {"role": "user", "content": prompt}],
        max_tokens=500,
        n=1,
        stop=None,
        temperature=0.5,
    )

    message = response.choices[0].message.content
    result_json = eval(message)
    return result_json
def get_quiz(words):
    

    system_prompt = f"create a filing the blank quiz of 10 different words as a json format and use question, " \
                         f"options and answer for " \
                         'the label of the list of questions. eg. ' \
                         '[{"question": "The student went to ___ for classes, "answer":"school", ' \
                         '"options":["school", "ears", "world", "tennis"]}].' \
                         ' Please give me only the json format as an output and do' \
                         f" not write anything before or after the json format. " \
                         f"Do not use double quotes or single quotes when designing the quiz."
    result_json = chat_with_chatgpt(words, system_prompt)
    return result_json
