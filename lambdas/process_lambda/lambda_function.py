import json
import boto3
import os
from datetime import datetime

s3 = boto3.client("s3")

PROCESSED_BUCKET = os.environ["PROCESSED_BUCKET"]

def lambda_handler(event, context):
    for record in event["Records"]:
        bucket = record["s3"]["bucket"]["name"]
        key = record["s3"]["object"]["key"]

        # Read raw file
        response = s3.get_object(Bucket=bucket, Key=key)
        raw_data = json.loads(response["Body"].read())

        processed_record = {
            "event_id": raw_data["id"],
            "user": raw_data["data"].get("user"),
            "action": raw_data["data"].get("action"),
            "ingested_at": raw_data["ingested_at"],
            "processed_at": datetime.utcnow().isoformat(),
            "date": datetime.utcnow().strftime("%Y-%m-%d")
        }

        processed_key = key.replace("raw/", "processed/")

        s3.put_object(
            Bucket=PROCESSED_BUCKET,
            Key=processed_key,
            Body=json.dumps(processed_record),
            ContentType="application/json"
        )

    return {"status": "processed"}
