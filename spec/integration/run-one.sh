#!/usr/bin/env sh

set -e

# The first arg is the subdir name to test.
subdir="$1"

# Change directory to the directory where this script is located.
cd -- "$(dirname -- "$0")"

# Confirm that a subdirectory was actually given.
if [ -z $subdir ]; then
  echo "FAIL (no subdirectory name given)"
  exit 2
fi

# Confirm that the given subdirectory name exists.
if ! [ -d $subdir ]; then
  echo "FAIL $subdir"
  echo "     (does not exist within $(pwd))"
  exit 2
fi

# Test that the output of running the compiler matches the expected errors.
test_run_output_yaml() {
  actual=$(cd $subdir && ./run.test.sh)
  expected=$(cat $subdir/run.output.yaml)
  if [ "$actual" != "$expected" ]; then
    echo "---"
    echo "---"
    echo
    echo "FAIL $subdir"
    echo
    echo "---"
    echo
    echo "EXPECTED $expected"
    echo
    echo "---"
    echo
    echo "ACTUAL $actual"
    echo
    echo "---"
    echo
    echo "DIFF:"
    echo "$actual" | diff --color -u $subdir/run.output.yaml -
    echo
    echo "---"
    echo "---"
    return 1
  fi
}

# If this subdirectory has a script and expected output file, use that strategy.
if [ -f "$subdir/run.test.sh" ] \
  && [ -f "$subdir/run.output.yaml" ]; then
  test_run_output_yaml

## NOTE: When adding new testing strategy, also add a description to the
##       integration testing documentation in `spec/integration/README.md`

# Otherwise, we have no test approaches left that can be tried.
else
  echo "FAIL $subdir"
  echo "     (missing files needed for integration testing)"
  echo "     (see spec/integration/README.md for more info)"
  exit 2
fi

echo "✓    $subdir"
echo
