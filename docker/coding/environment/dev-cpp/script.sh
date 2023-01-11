#!/usr/bin/env bash

echo "Dev C++"

cd ${HOME}
mkdir -p git-github && cd git-github && git clone https://github.com/doali/github.git && cd github && bash repo-pull-clone.sh
cd -

exec "$@"

# TEST
# ====
#docker build -t doali/dev-cpp:0.0.1 --build-arg UID=$(id -u) --build-arg GID=$(id -g) .
#docker run -it -v $(pwd)/data:/volume/data:z doali/dev-cpp:0.0.1