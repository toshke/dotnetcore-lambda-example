using System;
using System.IO;
using System.Text;
using Amazon.Lambda.Core;

namespace example.lambda_hello_world
{
    public class LambdaHandler
    {

        public Stream HelloWorld(Stream input, ILambdaContext context)
        {

            context.Logger.Log("Hello world from Lambda function\n");

            context.Logger.Log($"Function name: {context.FunctionName}\n");
            context.Logger.Log($"Function version: {context.FunctionVersion}\n");
            context.Logger.Log($"Function ARN: {context.InvokedFunctionArn}\n");

            Console.WriteLine($"Remaining lambda exection time: {context.RemainingTime.TotalMilliseconds}ms");

            return new MemoryStream(Encoding.UTF8.GetBytes("OK"));

        }

    }
}
