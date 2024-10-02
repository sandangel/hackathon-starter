import sys
import datetime

from google.cloud import storage
from vertexai.preview.caching import CachedContent
from vertexai.preview.generative_models import Part, Content

from genai.prompts import CODE_UNDERSTANDING_PROMPT

MODEL_ID = "gemini-1.5-pro-002"


def create_context_from_bucket(bucket_name: str) -> None:
    """Lists all the blobs in the bucket."""

    storage_client = storage.Client()

    # Note: Client.list_blobs requires at least package version 1.17.0.
    blobs = storage_client.list_blobs(bucket_name)

    parts = [
        Part.from_uri(f"gs://{bucket_name}/{blob.name}", "image/png" if ".png" in blob.name else "text/plain")
        for blob in blobs
    ]
    contents = [Content(role="user", parts=parts)]

    cached_content = CachedContent.create(
        model_name=MODEL_ID,
        system_instruction=Content(role="system", parts=[Part.from_text(CODE_UNDERSTANDING_PROMPT)]),
        ttl=datetime.timedelta(hours=24),
        contents=contents,
        display_name="hackathon-starter-coding-challenge",
    )

    print(cached_content.name)


if len(sys.argv) != 2:
    print("Usage: python genai/create_context.py <bucket_name>")
    sys.exit(1)

bucket_name = sys.argv[1]
create_context_from_bucket(bucket_name)
