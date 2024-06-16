# Filesystem Integration Tests

This folder contains a collection of subdirectories, with each subdirectory being an integration test case.

Each subdirectory contains some testing-related files/folders to let the integration test runner know exactly what and how to test. The integration test runner will choose a testing strategy based on which testing-related files/folders are present. See the sections describing the different testing strategies below for more information.

## Check output YAML tests

If the test case subdirectory contains a `run.test.sh` file and a `run.output.yaml` file, then the `run.test.sh` file will be run as a shell script and the actual output (STDOUT) of the script will be compared to the expected output in the `run.output.yaml` file.
