#!/bin/bash

echo "Enter your miner address:";

MINER_ADDRESS="aleo1vq5y3zh0xjqa86j0kz0tu4fg28ua9u9n8l3psfrhycwpgf50e5yqrfz3c3"


COMMAND="cargo run --release -- --miner ${MINER_ADDRESS} --trial --verbosity 2"

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
  STATUS=$(git pull)

  echo "Running the node..."
  
  if [ "$STATUS" != "Already up to date." ]; then
    cargo clean
  fi
  $COMMAND & sleep 1800; kill $!

  sleep 2;
done
