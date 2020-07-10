#!/bin/bash

BASEURL=$1
URLCOUNT=0
#define request paths in URLPATH with double quotes separated by comma
URLPATH=({"Channels/HTTP/AllOps?_ns_=www.tibco.com%2Fbe%2Fontology%2FEvents%2FCreateAccount&_nm_=CreateAccount&AccountId=Bobbyyyy&Balance=20000&AvgMonthlyBalance=11000&_httprequestid_=1592213282402","Channels/HTTP/AllOps?_ns_=www.tibco.com%2Fbe%2Fontology%2FEvents%2FCreateAccount&_nm_=CreateAccount&AccountId=Bobby2&Balance=20000&AvgMonthlyBalance=11000&_httprequestid_=1592213282402"})
URLCOUNT="${#URLPATH[@]}"

echo inferenceUrl is $1 and curl requests count is $URLCOUNT

# for loop for testing curl requests. If RESPONSE is not equal to 200 then the test will be failed
for (( i=0; i<"$URLCOUNT";i++));
do
    URL="$BASEURL/${URLPATH[$i]}"
    RESPONSE[$i]=$(curl -X GET $URL -H 'Upgrade-Insecure-Requests:1' --write-out '%{http_code}' --silent --output /dev/null)
    echo ${RESPONSE[$i]}
    if [ ${RESPONSE[$i]} != 200 ]; then
        echo RESPONSE code received is ${RESPONSE[$i]}
        exit 1;
    fi    
done