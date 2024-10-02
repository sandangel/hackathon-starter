import sys
import vertexai
from vertexai.preview import caching
from vertexai.preview.generative_models import Part, GenerativeModel

vertexai.init()

MODEL_ID = "gemini-1.5-pro-002"

# Get cached content ID from command line argument
if len(sys.argv) != 2:
    print("Usage: python genai/app.py <cached_content_id>")
    sys.exit(1)

cached_content_id = sys.argv[1]
cached_content = caching.CachedContent(cached_content_name=cached_content_id)


model = GenerativeModel.from_cached_content(cached_content)
chat = model.start_chat()


def main() -> None:
    while True:
        user_input = input("You: ")
        if user_input.lower() in ["exit", "quit"]:
            break
        print("AI: ", end="")
        responses = chat.send_message(Part.from_text(user_input), stream=True)
        for response in responses:
            print(response.text, end="")

        print("")


main()
