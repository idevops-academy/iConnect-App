#!/bin/bash

sleep 5
# Perform a smoke test with curl
if curl -s http://localhost | grep -q "iConnect"; then
    echo "Smoke test successful."
    exit 0
else
    echo "Smoke test failed."
    exit 1
fi