#! /bin/sh

set -e

echo $SCHEDULE;

if [ -z "$SCHEDULE" ]; then
  sh backup.sh
else
  echo "Running backup with schedule: ${SCHEDULE}"
  exec go-cron "$SCHEDULE" /bin/sh backup.sh
fi