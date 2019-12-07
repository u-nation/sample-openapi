#!/bin/sh
set -e

export JAR_PATH=./openapi-generator/modules/openapi-generator-cli/target/openapi-generator-cli.jar

# Swagger validation
java -jar ${JAR_PATH} validate -i swagger.yaml

# remove old generated code
rm -rf kotlin-client kotlin-server swift4_api_client typescript go

# generate kotlin-server
java -jar ${JAR_PATH} generate -i swagger.yaml -g kotlin-spring --additional-properties useBeanValidation=true --enable-post-process-file -o kotlin-server
rm -rf ./kotlin-server/docs \
  ./kotlin-server/README.md \
  ./kotlin-server/build.gradle.kts \
  ./kotlin-server/pom.xml \
  ./kotlin-server/settings.gradle \
  ./kotlin-server/src/main/resources \
  ./kotlin-server/src/main/kotlin/org/openapitools/api \
  ./kotlin-server/src/main/kotlin/org/openapitools/Application.kt \
  ./kotlin-server/src/test
# generate kotlin-client
java -jar ${JAR_PATH} generate -i swagger.yaml -g kotlin -o kotlin-client
rm -rf ./kotlin-client/docs ./kotlin-client/README.md ./kotlin-client/src/main/kotlin/org/openapitools/client/infrastructure
# generate swift4_api_client
java -jar ${JAR_PATH} generate -i swagger.yaml -g swift4 -o swift4_api_client
# generate go
java -jar ${JAR_PATH} generate -i swagger.yaml -g go-gin-server -o go
# generate typescript
java -jar ${JAR_PATH} generate -i swagger.yaml -g typescript-axios -o typescript

git config --global user.name u-nation
git config --global user.email Endooooooo7@gmail.com

export GIT_BRANCH="$(git symbolic-ref HEAD --short 2>/dev/null)"
if [ "$GIT_BRANCH" = "" ] ; then
  GIT_BRANCH="$(git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }')";
  export GIT_BRANCH=${GIT_BRANCH#remotes/origin/};
fi

git remote set-url origin https://u-nation:${GITHUB_TOKEN}@github.com/u-nation/sample-openapi.git
git checkout $GIT_BRANCH
git branch -a
git add .
git commit -m "add generated code"
git push origin $GIT_BRANCH
