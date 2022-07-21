#change next line if local copy is elsewhere
cd /home/lou/Public/Ossian-1773/NUIG
saxon -xi driver-vol1.tei ossianUp.xsl >ossianedition6a.xml
xsltproc NUIG/myDefault.xsl ossianedition6a.xml > ed6.html
cat HTML-prefix.htm ed6.html HTML-suffix.htm > ossianedition6a.html
rm ed6.html
saxon -xi driver-vol2.tei ossianUp.xsl >ossianedition6b.xml
xsltproc NUIG/myDefault.xsl ossianedition6b.xml > ed6.html
cat HTML-prefix.htm ed6.html HTML-suffix.htm > ossianedition6b.html
