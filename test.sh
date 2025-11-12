#!/bin/bash

#delete old result folders
if [ -d ./test/case_1/result ]; then
    rm -rf ./test/case_1/result/dnp
fi

helm template --debug --namespace testing --release-name dnp  -f ./.test/case_1/values.yaml --output-dir ./.test/case_1/result ./
diff -r ./.test/case_1/expected ./.test/case_1/result