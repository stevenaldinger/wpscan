#!/bin/sh

set -e

#!/bin/bash

# ----------------------- [START] set variable defaults ---------------------- #
set_variable_defaults () {
  agent='--random-agent'

  follow_redirection='--follow-redirection'

  update='/wpscan/wpscan.rb --update --verbose --no-color'

  url_without_protocol="${URL#*//}"

  hostname="${url_without_protocol%/}"

  log_path="/wpscan/logs/${hostname}"

  # log_file="${log_path}/$(date +%s)"
  log_file="${log_path}/1501932964"
  export LOG_FILE="${log_file}"

  extra_args=
}
# ------------------------- [END] set variable defaults ---------------------- #

# ------------------------ [START] check for user input ---------------------- #
check_for_user_input () {
  if [ ! -z "${USER_AGENT}" ]; then
    agent="--user-agent ${USER_AGENT}"
  fi

  if [ "${FOLLOW_REDIRECT}" == 'false' ]; then
    follow_redirection=
  fi

  if [ ! -z "${LOG_FILE}" ]; then
    log_file="${LOG_FILE}"
  fi

  if [ ! -z "${EXTRA_ARGS}" ]; then
    extra_args="${EXTRA_ARGS}"
  fi

  if [ "${UPDATE}" == 'false' ]; then
    update=
  fi
}
# ------------------------- [END] check for user input ----------------------- #

# ---------------------- [START] email the results logic --------------------- #
email_logs () {
  echo "Email logs?"
  export MAILGUN_SUBJECT="wpscan results: ${hostname}"
  export MAILGUN_BODY="$(cat ${log_file})"
  echo "Emailing ${MAILGUN_TO} logs from ${log_file}..."
  /docker/log_file_emailer/log_file_emailer.rb
}
# ----------------------- [END] email the results logic ---------------------- #

# ----------------------------- [START] main logic --------------------------- #
# set_variable_defaults
#
# check_for_user_input
#
# # make sure log directory exists
# mkdir -p "${log_path}"
#
# # update wpscan bef
# [ ! -z "${update}" ] && \
#   sh -c "${update}"
#
# # run the scanner and email if successful
# /wpscan/wpscan.rb "${agent}" --url "${URL}" "${follow_redirection}" --log "${log_file}" "${extra_args}" ||
#   echo ""
# echo "wp ended...."
# email_logs
# ------------------------------ [END] main logic ---------------------------- #
sh
