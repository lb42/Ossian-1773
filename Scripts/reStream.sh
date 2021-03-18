# shell script to convert txt to xml
# run this from Scripts directory
cd ../V1/txt
perl ../../Scripts/streamer.prl ../../Scripts/V1-files.txt
#fix croma
cd ../../V2/txt
perl ../../Scripts/streamer.prl ../../Scripts/V2-files.txt
 