## My first .NET core lambda function

# Requirements

## Build

To build the project, you will need dotnetcore installed

## Deploy

To deploy create zip package you will need AWS cli installed

## Test

 For viewing lambda function log, you'll need `jq` and `base64` libraries
 installed (or you can view logs in CloudWatch logs)

# Quick Test

To quickly test application build, deployment and run, use `test.sh`
script from top-level directory, it's assuming that you have bash shell
installed

```
$ ./test.sh

```

# Generate app

```
 dotnet new classlib -n lambda-hello-world
 ```

# Define AWS NuGet dependencies

Add some dependency info in `lambda-hello-world/lambda-hello-world.csproj`

```
<ItemGroup>
  <PackageReference Include="Amazon.Lambda.Core" Version="1.0.0" />
  <PackageReference Include="Amazon.Lambda.Serialization.Json" Version="1.0.0" />
</ItemGroup>
```

# Write some code

Code in this example will print out Lambda Function metadata, and exit with "OK"
result

```
          Console.WriteLine("Hello world from Lambda function!");

          Console.WriteLine($"Function name: {context.FunctionName}");
          Console.WriteLine($"Function version: {context.FunctionVersion}");
          Console.WriteLine($"Function ARN: {context.InvokedFunctionArn}");

          Console.WriteLine($"Remaining lambda exection time: {context.RemainingTime.TotalMilliseconds}ms");

          return "OK";
```

# Install dependencies and build application code

```
$ dotnet restore && dotnet build
  Restoring packages for .../github/dotnetcore-lambda/lambda-hello-world/lambda-hello-world.csproj...
  Lock file has not changed. Skipping lock file write. Path: .../github/dotnetcore-lambda/lambda-hello-world/obj/project.assets.json
  Restore completed in 389.34 ms for .../github/dotnetcore-lambda/lambda-hello-world/lambda-hello-world.csproj.

  NuGet Config files used:
      .../.nuget/NuGet/NuGet.Config

  Feeds used:
      https://api.nuget.org/v3/index.json
Microsoft (R) Build Engine version 15.1.1012.6693
Copyright (C) Microsoft Corporation. All rights reserved.

  lambda-hello-world -> .../github/dotnetcore-lambda/lambda-hello-world/bin/Debug/netcoreapp1.0/lambda-hello-world.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:02.45

```

# Create lambda package

```
$ cd bin/Debug/netcoreapp1.0/publish/ && zip -r package.zip *
```

# Create lambda function

```
$ aws lambda create-function --function-name TestDotNetCore --runtime "dotnetcore1.0" --role $LAMDBA_ROLE_ARN --region ap-southeast-2 --handler  lambda-hello-world::example.lambda_hello_world.LambdaHandler::HelloWorld --zip-file fileb://./lambda-hello-world/bin/Debug/netcoreapp1.0/publish/package.zip
{
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "CodeSha256": "gcP319XLaFzv9ZOken0dS/b81EbrrschaHvMG8LDT9w=",
    "FunctionName": "TestDotNetCore",
    "CodeSize": 214306,
    "MemorySize": 128,
    "FunctionArn": "arn:aws:lambda:ap-southeast-2:334818472548:function:TestDotNetCore",
    "Version": "$LATEST",
    "Role": "arn:aws:iam::XXXXXX:role/lambda_basic_execution",
    "Timeout": 3,
    "LastModified": "2017-06-15T03:14:31.929+0000",
    "Handler": "lambda-hello-world::example.lambda_hello_world.LambdaHandler::HelloWorld",
    "Runtime": "dotnetcore1.0",
    "Description": ""
}

```

