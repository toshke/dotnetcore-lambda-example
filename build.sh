#!/bin/bash
WD=$PWD
cd lambda-hello-world
rm -rf bin
dotnet restore
dotnet publish
cd bin/Debug/netcoreapp1.0/publish && zip -r package.zip *
cd $WD

