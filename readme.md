# Event-Driven Data Pipeline (AWS + Terraform + GitHub Actions)

## Architecture
- S3
- Lambda
- EventBridge
- Athena
- IAM
- GitHub Actions

## CI/CD Flow
GitHub Push → GitHub Actions → Terraform → AWS

## Data Flow
1. Raw events uploaded to S3
2. Ingest Lambda processes data
3. Process Lambda transforms data
4. Report Lambda generates analytics

## Tech Stack
- AWS Lambda
- S3
- EventBridge
- Terraform
- GitHub Actions
- Python

## How to Deploy
- Add AWS secrets
- Push to main branch
