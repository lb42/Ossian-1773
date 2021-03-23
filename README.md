# Ossian-1773
## A TEI transcription of the 1773 edition of the works of "Ossian"

Why would anyone want such a thing? I can't imagine, but here's how I made this one.
It turned out to be a six step process. 


### 1. Decide which PDF to work from

You might think that one library's digitized copy of "the 1773 edition of Ossian" would be much the same as another's. But no. Quite apart from variations in the physical state of the originals, different copies of this edition vary slightly in some crucial matters. I looked at two digitized copies: one preserved at the National Library of Scotland, and the other at the New York Public Library. The former is in a better state of preservation. Its digital images however, for some reason, don't include some of the half-titles present in the latter, though the page numbering and pagination are identical. A wild guess suggests that the half titles were printed (rather carelessly) as an afterthought, but I am waiting for someone who actually knows about this sort of thing to express an opion.

### 2. extract images from PDF, 

> $ pdfimages [filename.pdf] [outputPrefix]
> 
I am too lazy to install anything clever, so I use tried and tested ancient command line Unix tools, like pdfimages. Applying this to my two versions, I find that
each page from the NYPL PDF produces 5  PPM format images: one representing the page, three providing Google watermarks, and two NYPL watermarks. Each page from the NLS PDF produces three files: two in PPM format which appear to be masks, and one in grayscale representing the page, in negative form. Naturally, I prefer the latter, since it's easier to select just the page image and save it in my img folder, ready for the next stage. 


### 3. do OCR using medieval rules
  
> $ tesseract [inputfile] [outputfile] -l enm

As noted above, I have a preference for old fashioned command line Unix tools, and tesseract, once instructed to use an appropriate language model (enm, rather than eng), actually does a pretty good job of recognizing 18th century typography. It consistently fails on ligatured "ct" and a few other oddities, but is much better than I expected at distinguishing long-s from f. Most of its errors seem to be due to poor image quality.    
### 4. Hand-check, page by page, introducing minimal non xml markup

This leaves me with several hundred files, most of them containing plausible text, which I save in the `txt` folder. I then (and this is where the time goes) read each one, introducing some absolutely minimal markup, of my own invention. The cheatsheet reads as follows:

- introduce a -- line at start and end of text on page
- introduce a == line at start and end of note-text on page
- introduce a blank line between paras
- remove * or + sigla for notes and note  references; replacing them with @ and a sequence number
- use entity ref for long dash, accented letters etc
- use ``  for open double quotes 
- retain forme work on a single line
- delimit smallcaps with `{ ... }`
- delimit italicized phrases with  `{{ ... }}`
- use % to mark the start of a dramatic style speech 
- add \ at end of verse lines
- add $ at end of speech
- add `&end;` at end of an argument or other chunk

### 5. Transform and (slightly) reorganize the textfiles into  proper XML, one per text

> perl streamer.prl v1files.txt

This was not the most elegant or sanitary code I have ever written; it also took quite a few iterations to get it working reasonably well. It reads in a list of filenames, interspersed with flags to tell it when to start a new output file, and what its initial page number should be. Then it processes in succession each page of transcribed text, building up one string containing all the page text for that work, and another containing all the footnote text for that work. These strings are then output as XML `<div>` elements. Their contents also acquire some minimal XML tagging (`<pb/>`, `<hi>`, `<p>`, `<sp>` etc.) before they get flushed out. I gave up trying to overcome some inelegant results of this inelegant process. The code is in the `Scripts` folder of this repo for the morbidly curious. The results are in the `xml` folder: at least they are well-formed XML.

### 6. Run XSLT scripts to convert this stuff to kosher TEI documents and validate same.

Since this version is going to be my contribution to the "Ossian Online" project, it should probably follow that project's usage and TEI practices. Alas, they do not have an ODD to tell me what that should be, but they do have a reasonable amount of documentation, and enough files already available online for me to be able to construct an ODD automagically (take a bow `oddbyexample.xsl` --a well kept secret inside the TEI P5 Utilities repository) and thus a schema I can use to validate my TEI files when I have finished licking them into shape.





