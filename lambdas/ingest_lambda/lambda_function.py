import json
import boto3
import uuid
import os
from datetime import datetime

s3 = boto3.client("s3")

RAW_BUCKET = os.environ["RAW_BUCKET"]

def lambda_handler(event, context):
    try:
        body = json.loads(event["body"])

        record = {
            "id": str(uuid.uuid4()),
            "ingested_at": datetime.utcnow().isoformat(),
            "data": body
        }

        key = f"raw/{record['id']}.json"

        s3.put_object(
            Bucket=RAW_BUCKET,
            Key=key,
            Body=json.dumps(record),
            ContentType="application/json"
        )

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Event ingested successfully"})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }