# SurgeScrape - Scrape your surge.sh website's files

## Installation

+ `[sudo] gem install surgescrape` Download & install via RubyGems

## Usage

`sscrape website.surge.sh` A simple really, just specify a domain
and watch all the files download. Run each time you need to update your
directory, the tool won't download untouched files.

## What it lookes like

```
Installing new gem...
surgescrape (0.1.0) installed.
daniel@pancake:~/surgescrape$ sscrape 
Usage : `sscrape website.surge.sh`
daniel@pancake:~/Desktop/surge$ sscrape surge.sh
Scraping the files from https://surge.sh...
The website has different versions of your files and/or new files, your version of these will be overwritten : 
/css/index.css
/help/about-the-surge-cdn.html
[...]
/stickers/thanks.html
/tour.html 

Downloading 107 file(s)...
Downloaded /css/index.css
Downloaded /help/about-the-surge-cdn.html
[...]
Downloaded /stickers/thanks.html
Downloaded /tour.html
Finished!
daniel@pancake:~/Desktop/surge$ sudo serve 80
Serving on http://pancake:80
```

## MIT License