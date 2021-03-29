#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for zcored"

  set -- zcored "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "zcored" ]; then
  mkdir -p "$KICKSOCCER_DATA"
  chmod 700 "$KICKSOCCER_DATA"
  chown -R zcore "$KICKSOCCER_DATA"

  echo "$0: setting data directory to $KICKSOCCER_DATA"

  set -- "$@" -datadir="$KICKSOCCER_DATA"
fi

if [ "$1" = "zcored" ] || [ "$1" = "zcore-cli" ] || [ "$1" = "zcore-tx" ]; then
  echo
  exec gosu zcore "$@"
fi

echo
exec "$@"