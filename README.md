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


