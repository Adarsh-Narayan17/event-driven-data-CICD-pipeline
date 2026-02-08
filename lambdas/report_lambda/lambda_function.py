import boto3
import json
from datetime import datetime, timedelta

s3 = boto3.client("s3")

PROCESSED_BUCKET = "event-pipeline-processed-93d35f26"
REPORT_BUCKET = "event-pipeline-reports-93d35f26"

def lambda_handler(event, context):
    today = datetime.utcnow().date()
    prefix = f"processed/{today}"

    response = s3.list_objects_v2(
        Bucket=PROCESSED_BUCKET,
        Prefix="processed/"
    )

    total = 0
    actions = {}
    users = {}

    for obj in response.get("Contents", []):
        body = s3.get_object(
            Bucket=PROCESSED_BUCKET,
            Key=obj["Key"]
        )["Body"].read()

        record = json.loads(body)
        total += 1

        action = record["action"]
        user = record["user"]

        actions[action] = actions.get(action, 0) + 1
        users[user] = users.get(user, 0) + 1

    report = {
        "date": str(today),
        "total_events": total,
        "actions": actions,
        "users": users,
        "generated_at": datetime.utcnow().isoformat()
    }

    s3.put_object(
        Bucket=REPORT_BUCKET,
        Key=f"reports/{today}.json",
        Body=json.dumps(report, indent=2),
        ContentType="application/json"
    )

    return {"message": "Daily report generated"}
