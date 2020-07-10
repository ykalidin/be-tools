# Docker image for Helm Tests

This document details about creating custom docker image including shell script which is used for helm testing.

We will be creating custom docker image with curl and dos2unix installed, copying shell script in docker image.

Create a docker image

```
docker build -t ubuntu-curl:latest .
```

Add the created docker image name in BE helm charts values.yaml file under testframework->image.

## Test shell script

* How to write shell script is self documented in test.sh file
* In K8S cluster test.sh is being executed as follows. Arguments to test file were defined in values.yaml file before deploying the release.

```
./test.sh http://<be-service>:<be-service-port>
```

Note: U can use any shell script file name, this file name need to be added in values.yaml->testframework->testscript. 