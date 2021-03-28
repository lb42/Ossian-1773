# Ossian-1773

<a title="Jean Auguste Dominique Ingres, Public domain, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Ossiansongs.JPG"><img width="512" alt="Ossiansongs" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Ossiansongs.JPG/512px-Ossiansongs.JPG"></a>

## A TEI transcription of the 1773 edition of James Macpherson's "translations" of the works of "Ossian"

Why would anyone want such a thing? I can't imagine, but here's how I made this one.

It turned out to be a seven step process. 

### 1. Decide which PDF to work from

You might think that one library's digitized copy of "the 1773 edition of Ossian" would be much the same as another's. But no. There are variations in the physical state of the originals, and the PDF format in which the digitization is made available may also vary. I downloaded three  different digitized versions from the Internet Archive, but mainly I used [the PDF version of the copy preserved at the National Library of Scotland](https://ia802302.us.archive.org/33/items/poemsofossiantra11macp/poemsofossiantra11macp.pdf).  I say "mainly" because that particular PDF file had a curious glitch in it which made some of the half-titles disappear when extracted as separate image files. I supplied the missing text from the PDF version of the New York Public Library's copy and speculated wildly about printing history before realising that this was just a dodgy PDF artefact. 

### 2. extract images from PDF 

> $ pdfimages [filename.pdf] [outputPrefix]
> 
I am too lazy to install anything clever, so I use tried and tested ancient command line Unix tools, like `pdfimages`. Applying this to my two versions, I find that
each page from the NYPL PDF produces 5  PPM format images: one representing the page, three providing Google watermarks, and two NYPL watermarks. Each page from the NLS PDF produces three files: two in PPM format which appear to be masks, and one in grayscale representing the page, in negative form. Naturally, I prefer the latter, since it's easier to select just the page image and save it in my img folder, ready for the next stage. 


### 3. do OCR using medieval rules
  
> $ tesseract [inputfile] [outputfile] -l enm

As noted above, I have a preference for old-fashioned command-line Unix tools, and `tesseract`, once instructed to use an appropriate language model (`enm`, rather than `eng`), actually does a pretty good job of recognizing 18th century typography. It consistently fails on ligatured "ct" and a few other oddities, but is much better than I expected at distinguishing long-s from f. Most of its errors seem to be due to poor image quality.    

### 4. Hand-check, page by page, introducing minimal non-xml markup

This leaves me with about eight hundred files, each corresponding with one page of the source, and most of them containing plausible text, which I save in the `txt` folder. I then (and this is where the time goes) proofread each one, introducing some absolutely minimal markup, of my own invention. The cheatsheet reads as follows:

- introduce a `--` line at start and end of text on page
- introduce a `==` line at start and end of note-text on page
- introduce a blank line between paras but otherwise retain linebreaks
- introduce an extra hyphen following end-of-line hyphens which are to be retained
- replace `*` or `+1` sigla for notes and note  references with @ and a sequence number
- use entity references for long dash, accented letters etc
- use "``"  for open double quotes 
- retain forme work on a single line
- delimit smallcaps with `{ ... }`
- delimit italicized phrases with  `{{ ... }}`
- use `%` to mark the start of a dramatic style speech 
- add `\` at end of verse lines
- add `$` at end of speech
- add `&end;` at end of an argument or other chunk

I made the corrections using, need you ask, `emacs` aided and abetted with some perl one-liners for bulk corrections. Reading Ossian is an odd way to pass time during lockdown, but no worse than some of the other sanity-preserving expedients one reads about on Twitter. A good soundtrack seems to be almost any Sibelius symphony. 

### 5. Transform and (slightly) reorganize the textfiles into  proper XML, one per text

> perl streamer.prl v1files.txt

This is not the most elegant or indeed sanitary code I have ever written; it also took quite a few iterations to get it working acceptably, which I defined as generating well-formed XML. It reads in a listof filenames, interspersed with flags to tell it when to start a new output file, and what its initial page number should be. Then it processes in succession each page of transcribed text, building up one string containing all the text chunks for a work, and another containing all the footnotes. Footnotes often span pages, of course. The resulting strings are then output as two separate XML `<div>` elements. Their contents also acquire some minimal XML tagging (`<pb/>`, `<hi>`, `<p>`, `<sp>` etc.) before they get flushed out. I gave up trying to overcome some inelegant results of not particularly elegant process. The code is in the `Scripts` folder of this repo for the morbidly curious; the results are in the `xml` folder: at least they are well-formed XML.

### 6. Run XSLT scripts to convert this stuff to kosher TEI documents and validate same.

Since this version is going to be my contribution to the "Ossian Online" project, it should probably follow that project's usage and TEI practices. Alas, they do not have an ODD to tell me what that should be, and their files are apparently validated against TEI-All. But they do have a reasonable amount of documentation, and enough files already available online for me to be able to construct an ODD automagically (take a bow `oddbyexample.xsl` --
[a well kept secret](http://teic.github.io/TCW/howtoGenerate.html) inside the TEI P5 Utilities repository) and thus a schema I can use to validate my TEI files when I have finished licking them into shape.

As ever, the fun part of the project is seeing how much of the remaining data-mungeing can be scripted in XSLT. Quite a lot, it transpires, though it remains necessary to hand-craft the details of titlepages, tables of contents etc. Another complete sweep through the text checking for miscellaneous things like the following is also needed:
 - words broken by a pagebreak but not properly reassembled (happens occasionally)
 - quotations not marked as such
 - verse lines not marked as such
 - code-switching
 - residual OCR errors (there are ***always*** residual OCR errors)

Before launching into that campaign, I checked the `<pb/>` elements introduced at stage 5 against the page numbering of the original as preserved in the paratextual comments of my transcription. Somewhat to my surprise, the page-numbering corresponded exactly with the number of such elements, enabling me to construct both a reliable reference system and reliable page image links as values for the `facs` attribute on each `<pb/>`. 

### 7.  Decide on the macrostructure

The Ossian Online project uses `<div>` elements for every subdivision of the 1773 edition, at whatever level, all the way down from its two volumes to the arguments of individual poems. It takes the perfectly reasonable view that every text can be organized as an ordered hierarchy of uniformly nested objects. As a consequence, the `@type` attribute for `<div>` has to do quite a lot of heavy lifting.  Odd_by_example enumerates its values as follows:
 - advertisement
 - argument
 - book
 - contents
 - dedication
 - dissertation
 - duan
 - fragment
 - maintext
 - poem
 - preface
 
This list combines types that have a structural function (fragment, duan, book) with others that are purely descriptive (advertisement, argument, poem). Nothing wrong with that, but I still find this "divs all the way down" approach somewhat problematic, and that for for two reasons. Firstly a `<div>` is supposedly something incomplete, which is true of (for example) the argument prefixed to each poem or book, but not of the book or poem itself. Secondly, the relation between the argument and the poem requires that the two be siblings within some larger entity, but the poem is not really an incomplete part of that entity in quite the same way as the argument. Furthermore, in the 1773 edition, we have some texts which are undivided (*Carricthura* for example) along with others which are divided variously into "duan"s (*Cathlona*) or "book"s (*Fingal*). Should each book of *Fingal* be treated as a single text? Should the whole of *Fingal* be treated as a single text? Can't we have both?

Values such as `maintext` and `poem` in the list above ring alarm bells indicating that these ontological issues are being evaded.  Since the TEI in its wisdom already provides a mechanism for coping with exactly this (not at all unusual) kind of macrostructure, why not use it? I refer of course to the element `<group>`. 

The Ossian Online version of the 1763 edition is encoded as a single <text> element. This is divided into a `<front>` which contains a `<titlePage>` and four `<div>`s of prefatory matter, and a `<body>` which contains everything else. The body is subdivided into seven `<div type="poem">`s, each corresponding with a work listed in the table of contents. Five of these "poem"s contain a `<div type="argument">` followed by a `<div type="maintext">`; in the other two (Fingal and Temora), these `argument` and `maintext` divisions are subdivisions of an intermediate `<div type="book">` or `<div type="luan">` respectively. 

My version of the 1773 edition, which contains essentially the same material but in a different order, prefers to treat each distinct work as a `<text>`, with a `<front>` containing a titlepage or half title and the argument, followed by a `<body>`, if the work is not further subdivided, or by a `<group>` if it is. A `<group>`, combines a number of lower-level `<text>` elements, each again with a `<front>` and a `<body>`. I also  treat each of the two volumes of the 1773 edition as a `<group>`. The file `driver.tei` embeds each file in the structure using xInclude; it is commented to explain what's going on (a bit).






