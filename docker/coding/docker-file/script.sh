#!/usr/bin/env bash

run_nginx() {
  nginx -g 'daemon off;'
  echo "nginx is running..."
}

usage() {
  echo "Usage: $(basename ${0}) <word>"
}

#if [ $# -eq 1 ]; then
#  echo "Hello $1";
#  echo ""
  cat ${BASH_SOURCE[0]}
  run_nginx
#else
#  usage
#fi

exit 0
