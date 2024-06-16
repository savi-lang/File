#!/usr/bin/env sh

set -e

# Change directory to the directory where this script is located.
cd -- "$(dirname -- "$0")"

# Start running integation tests.
echo "Running integration tests..."
echo
for subdir in $(find . -maxdepth 1 -mindepth 1 -type d | cut -b 3- | sort --ignore-case); do
  ./run-one.sh $subdir || did_fail="X"
done

# If any test failed, report overall failure here.
if [ -n "$did_fail" ]; then
  echo "INTEGRATION TESTS FAILED"
  exit 1
fi
