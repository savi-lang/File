set -e

rm -rf /tmp/savi-watch-test
mkdir /tmp/savi-watch-test
../../../bin/savi-watch /tmp/savi-watch-test &
pid=$!

sleep 0.2
sleep 0.1; echo foo > /tmp/savi-watch-test/file1
sleep 0.1; echo bar >> /tmp/savi-watch-test/file1
sleep 0.1; touch /tmp/savi-watch-test/file1
sleep 0.1; touch /tmp/savi-watch-test/file2
sleep 0.1; rm /tmp/savi-watch-test/file2
sleep 0.1; mkdir /tmp/savi-watch-test/dir1; mkdir /tmp/savi-watch-test/dir2
sleep 0.1; touch /tmp/savi-watch-test/dir1
sleep 0.1; rm -r /tmp/savi-watch-test/dir1
sleep 0.2

kill $pid
