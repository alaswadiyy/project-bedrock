import json
import os
import logging

logger = logging.getLogger()
logger.setLevel(os.getenv('LOG_LEVEL', 'INFO'))

def handler(event, context):
    logger.info(f"Event received: {json.dumps(event)}")
    
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        
        logger.info(f"Image received: {key} from bucket: {bucket}")
        print(f"Image received: {key}")
    
    return {
        'statusCode': 200,
        'body': json.dumps('Processing completed')
    }