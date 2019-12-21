#!/bin/sh
set -eu

# git setting
git config --global user.name github-actions
git config --global user.email noreply@github.com

export GIT_BRANCH="$(git symbolic-ref HEAD --short 2>/dev/null)"
if [ "$GIT_BRANCH" = "" ] ; then
  GIT_BRANCH="$(git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }')";
  export GIT_BRANCH=${GIT_BRANCH#remotes/origin/};
fi

git remote set-url origin https://team-lab:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git checkout $GIT_BRANCH

# OpenAPI Generate
export JAR_PATH=./pkg-openapi-generator/code-gen/openapi-generator-cli.jar
## validation
java -jar ${JAR_PATH} validate -i swagger.yaml
## remove old generated code
rm -rf kotlin-client kotlin-server swift typescript go-gin
## generate kotlin-server
java -jar ${JAR_PATH} generate -i swagger.yaml -g kotlin-spring --additional-properties useBeanValidation=true --enable-post-process-file -o kotlin-server
rm -rf kotlin-server/docs \
  kotlin-server/build.gradle.kts \
  kotlin-server/pom.xml \
  kotlin-server/settings.gradle \
  kotlin-server/src/main/resources \
  kotlin-server/src/main/kotlin/org/openapitools/api \
  kotlin-server/src/main/kotlin/org/openapitools/Application.kt \
  kotlin-server/src/test
## generate kotlin-client
java -jar ${JAR_PATH} generate -i swagger.yaml -g kotlin -o kotlin-client
rm -rf kotlin-client/docs kotlin-client/src/main/kotlin/org/openapitools/client/infrastructure
## generate swift
java -jar ${JAR_PATH} generate -i swagger.yaml -g swift4 -o swift
## generate go
java -jar ${JAR_PATH} generate -i swagger.yaml -g go-gin-server -o go-gin
## generate typescript
java -jar ${JAR_PATH} generate -i swagger.yaml -g typescript-axios -o typescript
## remove all README.md
find kotlin-client kotlin-server swift typescript go-gin -name "README.md" | xargs rm

# push if diff exists
set +e
git diff --exit-code --quiet
if [ $? -eq 1 ]; then
  git add .
  git commit -m "add generated code"
  git push origin $GIT_BRANCH
else
  echo "nothing to commit"
fi
