To stop an EC2 instance during the night using AWS Lambda, you can create a Lambda function that is triggered by a CloudWatch Events rule at the desired time. The CloudWatch Events rule can be set up to trigger the Lambda function on a schedule, such as every night at a specific time.

Below is a Python Lambda function code that stops the EC2 instance based on a tag value. This code assumes that you have already tagged the instances you want to stop with a tag key-value pair, for example, "NightStop": "true".

```python
import boto3
import datetime

def lambda_handler(event, context):
    # Initialize the EC2 client
    ec2 = boto3.client('ec2')
    
    # Get the current hour in UTC time
    current_hour = datetime.datetime.now(datetime.timezone.utc).hour
    
    # Define the start and end hours for stopping the instances (in UTC time)
    stop_hour_start = 23  # 11 PM (adjust this based on your desired stop time)
    stop_hour_end = 7     # 7 AM (adjust this based on your desired start time)
    
    # Check if the current hour is within the stop range
    if stop_hour_start <= current_hour or current_hour < stop_hour_end:
        try:
            # Filter instances with the "NightStop" tag set to "true"
            instances = ec2.describe_instances(Filters=[{'Name': 'tag:NightStop', 'Values': ['true']}])
            
            # Stop each instance
            for reservation in instances['Reservations']:
                for instance in reservation['Instances']:
                    instance_id = instance['InstanceId']
                    ec2.stop_instances(InstanceIds=[instance_id])
                    print(f'Stopping instance: {instance_id}')
        except Exception as e:
            print(f'Error stopping instances: {e}')
    else:
        print('No instances to stop at the current time.')

    return {
        'statusCode': 200,
        'body': 'EC2 instances stopped successfully.'
    }
```

Make sure to adjust the `stop_hour_start` and `stop_hour_end` variables based on your local time or the time zone you want to use for stopping the instances. The code above uses the UTC time to determine when to stop the instances.

Remember to configure the CloudWatch Events rule to trigger this Lambda function on the desired schedule. The CloudWatch Events rule should have a schedule expression like `cron(0 23,0-7 ? * * *)`, which will trigger the Lambda function at 11 PM UTC and from 12 AM to 7 AM UTC every day. You can adjust the cron expression according to your requirements.

Also, ensure that your Lambda function has the necessary IAM permissions to describe and stop EC2 instances. The recommended approach is to create an IAM role for the Lambda function with the required permissions and attach it to the function.