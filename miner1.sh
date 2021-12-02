#!/bin/bash

echo "Enter your miner address:";
MINER_ADDRESS = "aleo1vq5y3zh0xjqa86j0kz0tu4fg28ua9u9n8l3psfrhycwpgf50e5yqrfz3c3"
#read MINER_ADDRESS

#if [ "${MINER_ADDRESS}" == "" ]
#then
 # MINER_ADDRESS="aleo1d5hg2z3ma00382pngntdp68e74zv54jdxy249qhaujhks9c72yrs33ddah"
#fi

COMMAND="cargo run --release -- --miner ${MINER_ADDRESS} --trial --verbosity 2"

for word in $*;
do
  COMMAND="${COMMAND} ${word}"
done

function exit_node()
{
    echo "Exiting..."
    kill $!
    exit
}

trap exit_node SIGINT

echo "Running miner node..."

while :
do
  echo "Checking for updates..."
  git stash
  STATUS=$(git pull)

  echo "Running the node..."

  if [ "$STATUS" != "Already up to date." ]; then
    cargo clean
  fi
  $COMMAND & sleep 1800; kill -INT $!

  sleep 2;
done
