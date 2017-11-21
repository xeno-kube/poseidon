#!/bin/sh

echo "[$(date)] $1" >> /poseidon_activity.log

echo "[$(date)] --- starting Poseidon ---" >> /poseidon_activity.log

crond -b

tail -F /poseidon_activity.log
