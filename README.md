# Lambda-Lab

Scenario-1: 
Write a Lambda Function to take data from event and write date into DynamoDB ?

Scenario-2:
Suppose an imgae populated in S3, Write a function in Lambda so to reduce the size of the iamge to 5MB ?

Scenario-3:
Suppose there is an API call which gives 2 nos, Write a Lambda function to generate a random nos between these 2 nos ?


Benefits of Lambda:

Serverless
Pay for use
No servers to manage
Continuous scaling
Millisecond metering
Increases innovation
Modernize your applications
Support for developers
Fewer lines of code
Sequential and Parallel execution support by passing behavior as an argument in methods
Can help you run your code whether it is for high computational infrastructure or it’s for low coding or any other type of management or monitoring of codes and servers.

Scenario-4:
How can you invoke a Lambda Function ? and what will happend when Lambda invoked ?
Sol:
Supose you have a single request, once Lambda invoked through any services (CW/S3/data/API) it automatically creates a container and handle to reduce suppose image size moving forward if request increases, container keep on increasing as per the calculation, moreover if there are 100 request then may be Lambda would have created 33-34 request and once the request decreases lambda automatically killed the containers as per load decreases, at the last if no data would arrive then there won't be any container and end uses no need to pay any cost.

Scenario-5:
Create a Lambda function through UI and Test it ?


Scenario-6:
Handler Function -> FILE_NAME.EXPORTED_FUNCTION_NAME -> Mandatory else error throws
Sol:
In AWS Lambda, the handler function is the entry point for your serverless function. When you invoke a Lambda function, AWS Lambda executes the handler function, passing the event data and context to it. The handler function must be defined in the code, and its signature depends on the programming language used.

Here's an example of a Lambda handler function in Python:

```python
import json

def lambda_handler(event, context):
    # Parse the input event data
    data = json.loads(event['body'])

    # Process the data or perform any desired operations
    result = process_data(data)

    # Return the response
    response = {
        'statusCode': 200,
        'body': json.dumps(result)
    }
    return response

def process_data(data):
    # Your custom logic to process the input data
    # For this example, let's just return the input data as it is
    return data
```

In this example, the Lambda function is written in Python. The `lambda_handler` function is the entry point and gets executed when the Lambda function is invoked. It takes two parameters: `event` and `context`.

- `event`: It is a dictionary containing the input data sent to the Lambda function. The format of the `event` data depends on the event source that triggers the Lambda function. In this example, we assume the input is in JSON format and extract the data from the `body` field.

- `context`: It provides information about the Lambda environment and function execution, such as the function name, memory limit, request ID, and execution time. It is not used in this simple example, but it can be helpful for more advanced use cases.

The `lambda_handler` function calls the `process_data` function to perform some custom logic on the input data. In this example, we just return the input data as it is, but you can add any desired processing or business logic to this function.

Finally, the `lambda_handler` function returns a response in the format of a dictionary containing the HTTP status code (`statusCode`) and the response data (`body`). In this example, we return a successful response with status code 200 and the processed data as the response body.

Note that the code structure and function names can vary based on the programming language used (e.g., Node.js, Java, Go, etc.), but the concept of the handler function as the entry point remains the same across different languages when using AWS Lambda.


Scenario-7:
event in lambda function with example
Sol:
In AWS Lambda, the `event` parameter is a dictionary that contains the input data sent to the Lambda function. The format of the `event` data depends on the event source that triggers the Lambda function. Different event sources, such as API Gateway, S3, DynamoDB, CloudWatch Events, etc., pass different data structures in the `event` parameter.

Let's look at an example of a Lambda function written in Python, and we'll explore how the `event` parameter can be used for different event sources:

```python
def lambda_handler(event, context):
    # Example 1: API Gateway Proxy Integration
    if 'httpMethod' in event and 'body' in event:
        # This is an API Gateway event with a proxy integration
        http_method = event['httpMethod']
        body = event['body']
        return {
            'statusCode': 200,
            'body': f'Received {http_method} request with body: {body}'
        }

    # Example 2: S3 Object Created Event
    if 'Records' in event and event['Records'][0]['eventName'] == 'ObjectCreated:Put':
        # This is an S3 object created event
        bucket_name = event['Records'][0]['s3']['bucket']['name']
        object_key = event['Records'][0]['s3']['object']['key']
        return {
            'statusCode': 200,
            'body': f'S3 object created in bucket {bucket_name} with key {object_key}'
        }

    # Example 3: Scheduled CloudWatch Event
    if 'source' in event and event['source'] == 'aws.events':
        # This is a scheduled CloudWatch event
        return {
            'statusCode': 200,
            'body': 'Scheduled CloudWatch event triggered'
        }

    # Example 4: Custom Event
    if 'customField' in event:
        # This is a custom event with a 'customField' key
        custom_value = event['customField']
        return {
            'statusCode': 200,
            'body': f'Custom event received with customField: {custom_value}'
        }

    return {
        'statusCode': 400,
        'body': 'Invalid event data'
    }
```

In this example, the `lambda_handler` function takes the `event` and `context` parameters. We check the `event` data for specific fields or keys to determine the type of event source that triggered the Lambda function. Based on the event type, we create a response with different messages.

1. Example 1: API Gateway Proxy Integration:
   The `event` data for an API Gateway proxy integration includes information about the HTTP method (`httpMethod`) and the request body (`body`). We use this data to generate a response indicating the received HTTP method and request body.

2. Example 2: S3 Object Created Event:
   The `event` data for an S3 object created event contains details about the created object in the 'Records' key. We extract the bucket name and object key from the event to create a response indicating the S3 object's creation.

3. Example 3: Scheduled CloudWatch Event:
   The `event` data for a scheduled CloudWatch event includes a 'source' field, which indicates the event source. We check for the presence of this field to identify the scheduled CloudWatch event and create a response accordingly.

4. Example 4: Custom Event:
   In this example, we demonstrate how you can create custom events with additional fields. We check for the presence of a custom field named 'customField' to identify a custom event and generate a response with the custom value.

These are just a few examples of how you can use the `event` parameter in a Lambda function. The actual structure and content of the `event` data depend on the specific event source that triggers the Lambda function.


Scenario-8:
Event in Lambda function ?
Sol:
event basically provides the runtime information of the lambda function 

In AWS Lambda, the `context` parameter provides information about the Lambda environment and function execution. It contains data such as the function name, request ID, execution time, memory limit, and more. The `context` parameter allows you to access contextual information about the Lambda invocation. Let's look at an example of a Lambda function written in Python to understand how to use the `context` parameter:

```python
import time

def lambda_handler(event, context):
    # Print the Lambda function name
    function_name = context.function_name
    print(f"Lambda function name: {function_name}")

    # Get the AWS request ID for this execution
    request_id = context.aws_request_id
    print(f"AWS request ID: {request_id}")

    # Get the memory limit allocated to the Lambda function
    memory_limit_mb = context.memory_limit_in_mb
    print(f"Memory limit (MB): {memory_limit_mb}")

    # Get the time the Lambda function started
    start_time = context.get_remaining_time_in_millis()
    print(f"Start time (ms): {start_time}")

    # Simulate some time-consuming operation
    time.sleep(2)

    # Get the time remaining before the Lambda function times out
    remaining_time = context.get_remaining_time_in_millis()
    print(f"Remaining time (ms): {remaining_time}")

    return {
        'statusCode': 200,
        'body': 'Lambda function executed successfully!'
    }
```

In this example, the `lambda_handler` function takes two parameters, `event` and `context`. We demonstrate how to access various properties and methods of the `context` object:

1. `context.function_name`: Provides the name of the Lambda function being executed.

2. `context.aws_request_id`: Contains the AWS request ID, a unique identifier for each Lambda function invocation.

3. `context.memory_limit_in_mb`: Indicates the memory allocation (in megabytes) configured for the Lambda function.

4. `context.get_remaining_time_in_millis()`: Returns the time remaining before the Lambda function times out. This can be used to track the execution time and avoid timeouts.

In the example, we simulate a time-consuming operation using `time.sleep(2)` to pause the Lambda function for 2 seconds. Before and after this operation, we use `context.get_remaining_time_in_millis()` to show the remaining time before the function times out.

The output of the Lambda function execution will display the various context properties:

```
Lambda function name: myLambdaFunction
AWS request ID: 12345678-1234-5678-1234-567890abcdef
Memory limit (MB): 128
Start time (ms): 10000
Remaining time (ms): 8000
```

Remember that the context properties and methods may vary depending on the programming language used to write the Lambda function. Additionally, the context provides other useful information, such as the CloudWatch log group and log stream names, which can be helpful for more advanced use cases.


Scenario-9:
List of context properties in lambda function ?
Sol:
In AWS Lambda, the `context` parameter provides several properties that offer information about the Lambda environment and function execution. These properties are accessible within the Lambda function and can be used to obtain useful details about the context in which the function is running. Here is a list of context properties available in a Lambda function:

1. `function_name`: The name of the Lambda function being executed.
2. `function_version`: The version or alias of the Lambda function.
3. `invoked_function_arn`: The Amazon Resource Name (ARN) of the Lambda function that was invoked.
4. `memory_limit_in_mb`: The amount of memory allocated to the Lambda function (in megabytes).
5. `aws_request_id`: A unique identifier assigned to the AWS request for this Lambda function invocation.
6. `log_group_name`: The name of the CloudWatch log group associated with the Lambda function.
7. `log_stream_name`: The name of the CloudWatch log stream associated with the Lambda function.
8. `identity`: Information about the caller identity (Cognito identity or IAM role) used in the invocation.
9. `client_context`: Contextual information about the client application invoking the Lambda function (when using the AWS Mobile SDK).
10. `remaining_time_in_millis()`: A method that returns the time remaining before the Lambda function times out.
11. `get_remaining_time_in_millis()`: A method that returns the time remaining before the Lambda function times out (same as the above method).
12. `function_version`: The version of the Lambda function.
13. `function_arn`: The ARN of the Lambda function.

Example Usage:
```python
import json

def lambda_handler(event, context):
    function_name = context.function_name
    function_version = context.function_version
    invoked_function_arn = context.invoked_function_arn
    memory_limit_mb = context.memory_limit_in_mb
    aws_request_id = context.aws_request_id
    log_group_name = context.log_group_name
    log_stream_name = context.log_stream_name

    response = {
        'statusCode': 200,
        'body': json.dumps({
            'function_name': function_name,
            'function_version': function_version,
            'invoked_function_arn': invoked_function_arn,
            'memory_limit_mb': memory_limit_mb,
            'aws_request_id': aws_request_id,
            'log_group_name': log_group_name,
            'log_stream_name': log_stream_name
        })
    }

    return response
```

This Lambda function extracts various context properties and returns them as part of the response body in JSON format. When this function is invoked, it will include information about the Lambda function, its version, ARN, memory limit, request ID, and the associated CloudWatch log group and log stream.


Scenario-10:
list of context methods in lambda function ?
Sol:
In AWS Lambda, the `context` parameter provides a few methods that allow you to access specific information about the Lambda environment and function execution. Here is a list of context methods available in a Lambda function:

1. `get_remaining_time_in_millis()`: Returns the time remaining before the Lambda function times out. This can be used to track the execution time and avoid timeouts.

Example Usage:
```python
def lambda_handler(event, context):
    remaining_time = context.get_remaining_time_in_millis()
    print(f"Remaining time (ms): {remaining_time}")
```

2. `log_stream_name`: The name of the CloudWatch log stream associated with the Lambda function. This method returns the log stream name.

Example Usage:
```python
def lambda_handler(event, context):
    log_stream_name = context.log_stream_name
    print(f"Log stream name: {log_stream_name}")
```

3. `log_group_name`: The name of the CloudWatch log group associated with the Lambda function. This method returns the log group name.

Example Usage:
```python
def lambda_handler(event, context):
    log_group_name = context.log_group_name
    print(f"Log group name: {log_group_name}")
```

Please note that the context object in AWS Lambda might have different methods and properties based on the programming language used (e.g., Python, Node.js, Java, etc.). The methods mentioned above are common in most Lambda runtime environments and can be used to access useful information during function execution.


Scenario-11:
callback function in lambda with example 
Sol:
In AWS Lambda, a callback function is a function that you can use to notify the Lambda runtime that your asynchronous function has completed its execution. This is typically used when you have an asynchronous operation in your Lambda function, such as writing to a database, making an API call, or processing a long-running task. By using a callback function, you can signal the Lambda runtime that the operation has finished and return the result.

Let's look at an example of how to use a callback function in a Lambda function written in Node.js:

```javascript
// Lambda function handler
exports.handler = (event, context, callback) => {
  // Perform some asynchronous operation, e.g., writing to a database or making an API call
  simulateAsyncOperation((err, result) => {
    if (err) {
      // If an error occurs during the operation, pass the error to the callback
      callback(err);
    } else {
      // If the operation is successful, pass the result to the callback
      callback(null, result);
    }
  });
};

// Simulate an asynchronous operation
function simulateAsyncOperation(callback) {
  // Simulate the operation by using a timeout
  setTimeout(() => {
    // For this example, we will pretend the operation is successful
    const result = { message: 'Operation completed successfully!' };
    callback(null, result);
  }, 2000); // 2 seconds delay
}
```

In this example, we define a Lambda function handler with three parameters: `event`, `context`, and `callback`. The `callback` parameter is a function that we can use to notify the Lambda runtime about the result of the asynchronous operation.

Inside the Lambda function, we perform a simulated asynchronous operation using the `simulateAsyncOperation` function. The operation takes some time to complete, so we use a `setTimeout` to simulate the delay.

When the operation is completed, we call the `callback` function to send the result to the Lambda runtime. If the operation encounters an error, we pass the error as the first argument to the `callback`. If the operation is successful, we pass the result as the second argument.

Once the callback is called, the Lambda function execution is complete, and the result or error is returned to the caller or event source (e.g., API Gateway, S3, etc.).

Using a callback function allows you to work with asynchronous operations in AWS Lambda, making it possible to perform tasks that take time to complete without blocking the execution of your function.


Scenario-11:
logging in lambda function ?
Sol:
In AWS Lambda, logging is essential for debugging, monitoring, and understanding the behavior of your functions. You can use various logging methods to record information within your Lambda function. The most common logging method is using the `console` object to log messages, which will appear in the Lambda function's CloudWatch logs.

Here's how you can log messages inside a Lambda function written in Node.js:

```javascript
exports.handler = async (event, context) => {
  // Log an informational message
  console.log('Processing Lambda function...');

  try {
    // Perform some logic or async operations
    const result = await performSomeLogic(event);

    // Log a success message along with the result
    console.log('Operation completed successfully:', result);

    return {
      statusCode: 200,
      body: JSON.stringify(result)
    };
  } catch (error) {
    // Log an error message if an exception occurs
    console.error('Error occurred:', error);

    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Internal Server Error' })
    };
  }
};

function performSomeLogic(event) {
  // Simulate some asynchronous operation or logic
  return new Promise((resolve) => {
    setTimeout(() => {
      const result = { message: 'Operation result' };
      resolve(result);
    }, 1000); // 1 second delay
  });
}
```

In this example, we have a Lambda function with an asynchronous `performSomeLogic` function that simulates an asynchronous operation. Inside the `handler` function, we use `console.log` and `console.error` to log informational and error messages, respectively.

When the Lambda function is invoked, the messages logged using `console.log` will be recorded in the CloudWatch logs for the function. Similarly, if an error occurs, the message logged using `console.error` will also be recorded in the logs.

By logging information, you can monitor the function's behavior and troubleshoot any issues that may arise during execution. It's essential to log relevant details about the function's inputs, outputs, and any errors that might occur. However, remember to avoid excessive logging, as it can generate unnecessary log data and add latency to the function's execution. Use logging judiciously to strike a balance between getting useful insights and minimizing unnecessary costs.


Scenario-12:
names of log functions in lambda 
Sol:
In AWS Lambda, you can use the following log functions to record information in your function's logs:

1. **console.log(message)**: Logs an informational message. The message will be recorded in the CloudWatch logs for the Lambda function.

2. **console.info(message)**: Same as `console.log()`, logs an informational message.

3. **console.warn(message)**: Logs a warning message. The message will be recorded in the CloudWatch logs with a warning indicator.

4. **console.error(message)**: Logs an error message. The message will be recorded in the CloudWatch logs with an error indicator.

5. **console.debug(message)**: Logs a debug message. Note that `console.debug()` is available in Node.js 12.x and later runtimes, and it behaves the same as `console.log()`.

6. **console.trace(message)**: Logs a stack trace. The stack trace will provide details about where the log function was called.

7. **context.log(message)**: This method is available in Python and is used to log messages. It is similar to `console.log()` in Node.js.

8. **context.info(message)**: This method is available in Python and is used to log informational messages. It is similar to `console.info()`.

9. **context.warn(message)**: This method is available in Python and is used to log warning messages. It is similar to `console.warn()`.

10. **context.error(message)**: This method is available in Python and is used to log error messages. It is similar to `console.error()`.

Please note that the availability of these log functions depends on the runtime and the programming language you are using in your Lambda function. The examples provided above are for Node.js and Python, which are two common languages used in Lambda functions. If you are using a different programming language, the log functions might have slightly different names or behaviors.


Scenario-13:
Create a Lambda function through CLI:

Refer to this code: 
https://github.com/xavyaly/Lambda-Lab/blob/main/2023-Lambda-Challenges/4-trigger-lambda-api-cli/1-lambda-create.sh



