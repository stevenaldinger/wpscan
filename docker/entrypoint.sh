#!/bin/sh

set -e

# ----------------------------- [START] main logic --------------------------- #
. /docker/functions.sh

if [ "$#" -gt 1 ]; then
  /wpscan/wpscan.rb "$@"
else
  run_wpscan_with_env_vars
  cron -f
  # keep script from stopping
  # tail -f /dev/null
fi
# ------------------------------ [END] main logic ---------------------------- #
# sh
