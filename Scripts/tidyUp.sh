#cd ../V1/xml
#for f in *.xml; do echo $f; saxon $f ../../Scripts/tidyUp.xsl > ../tei/$f; done
cd ../V2/xml
for f in *.xml; do echo $f; saxon $f ../../Scripts/tidyUp.xsl > ../tei/$f; done
	 
