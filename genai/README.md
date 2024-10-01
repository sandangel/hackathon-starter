## Overview

This project is making use of GenAI heavily to:
- Understand the code base using Gemini Model from Google on Vertex AI
- Rewrite the take-home assignment in a way chat bot can easily understand
- Adding new code based on tasks in the requirements using AI coder tool installed as the python library.

Here is the list of changes I added, all the code is reviewed and some are tested by myself. Due to the timeline restriction
I was not able to test all the code and it might miss many things for it to start function properly.

- `terraform/` to provision VPC and EKS cluster (tested with `terraform init` and `terraform plan`)
- `.github/workflows/` to run CI/CD on PRs and merge, as well as manual trigger (not tested)
- `k8s/` manifests to deploy the application to the k8s cluster (tested with `kubectl kustomize k8s/overlays/dev` )
- `genai/` this is the code to help understand and interact with the code base (tested as below)
- `setup.sh` and `deploy.sh` for assignment, (not tested, I'm using NixOS unfortunately)
-  `Dockerfile` (tested with `docker build`)
- `controllers/`, `models/` and `app.js`, adding new blog post feature. (not tested)


## Upload Project Code to GCS Bucket

1. Ensure you have the Google Cloud SDK installed and authenticated.
1. Authenticate with Google Cloud using the following command:
   ```bash
   gcloud auth login
   ```

1. Use the following command to upload your project code to a GCS bucket:
   ```bash
   gsutil cp -r /path/to/your/project gs://your-bucket-name/
   ```

## Ask Questions About the Project

1. Once the project code is uploaded, you can use the following command load the project in to the Gemini cache:
   ```bash
   python genai/create_context.py <your-bucket-name>
   ```

1. After the project is loaded, you can see the cache ID for the project, copy it and provide it as input for the below command to start interacting with the code base:
   ```bash
   python genai/app.py <cached_content_id>
   ```

## Generate Code Using AI Coder

1. To generate code using AI coder, you can use the following command:
   ```bash
   rye run aicoder --model azure/gpt-4o
   ```

1. This AI coder will allow you to editing code and a lot more using GenAI. Please check [https://aider.chat/](https://aider.chat/) for more information.
