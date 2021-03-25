cd ../V1/tei
for f in *.xml; do echo $f; mv -n $f $f.tmp; saxon $f.tmp ../../Scripts/tidyup2.xsl > $f; done
cd ../../V2/tei
for f in *.xml; do echo $f; mv -n $f $f.tmp; saxon $f.tmp ../../Scripts/tidyup2.xsl > $f; done
	 
