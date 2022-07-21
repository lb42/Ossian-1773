# Notes for DK

As we discussed, Ossian Edition 6 (1773) was the first of the Ossian editions to have been delivered in two volumes. To keep things simple, I have pretended that each volume is a separate edition, naming the files `ossianedition6a` and `ossianedition6b`. 

In the `NUIG` folder, you will therefore find

(a) source TEI-XML files: ossianedition6a.xml  and ossianedition6b.xml 
(b) generated HTML files:  ossianedition6a.html  and ossianedition6b.html 
(c) page images (in .pbm format) : ossianedition6a.zip  and ossianedition6b.zip 

With saxon installed and a following wind you should be able to regenerate these files using the script `Scripts/ossianUp.sh`; however, this assumes you have cloned the whole of my Ossian directory from  `https://github.com/lb42/Ossian-1773`. You may find it easier just to tweak the HTML with your favourite editor. 

The only outstanding problem I am aware of is that the links to page images are not working properly. At the moment, the XML has links like this:

~~~~
<pb xml:id="P73100003" facs="../img/1773-020.pbm"/>
~~~~
which generates in the HTML a link like this:
~~~~
<img data-src="https://ossianonline.nuigalway.ie/storage/img/600_edition_6/../img/1773-020.pbm" class="facs-image" data-pagelink=""/>
~~~~

I have not tried to fix this because I didn't know what the URL should be, nor indeed whether you have better quality images you'd prefer to use. It also occurs to me now that you might prefer to use the @xml:id value to construct the link, since it is a little bit more transparent (e.g. "P73100003" means "third page of the first volume of the 1773 edition"). I can tweak the `ossianUp.xsl` script to do this if you like.

The only change I made to the "default.xsl" file you sent me was to add declarations for the parameters,  as recommended in your email of many months ago.










