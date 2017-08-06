#!/bin/sh

set -e

if [ -f /usr/bin/custom_entrypoint ]; then
  chmod a+x /usr/bin/custom_entrypoint
  custom_entrypoint
else
  /wpscan/wpscan.rb "$@"
fi
