# BOSSMan -- Gem for interaction with the Yahoo BOSS web service

## Description

BOSSMan can be used to perform image, web and news searches against Yahoo's index. For more information about BOSS (Build your Own Search Service) please refer to http://developer.yahoo.com/search/boss/. 

This is an older project - these days I'd probably use HTTParty (http://github.com/jnunemaker/httparty) if I needed to access BOSS or other similar web services. 

## Bugs, Features, Feedback

Tickets can be submitted by using GitHub issues.

## Example Usage

### Setup

    require 'bossman'
    include BOSSMan

    BOSSMan.application_id = [Your Application ID]

### Web

    boss = BOSSMan::Search.web("prospect park", { :count => 5, :filter => "-hate" })
    
    puts Matches:
    puts
    
    boss.results.each { |result| puts "#{result.title} [#{result.url}]" }
        
    => Matches:

    <b>Prospect</b> <b>Park</b> Alliance [http://www.prospectpark.org/]
    <b>Prospect</b> <b>Park</b> (Brooklyn) - Wikipedia, the free encyclopedia [http://en.wikipedia.org/wiki/Prospect_Park_(Brooklyn)]
    About <b>Prospect</b> <b>Park</b> [http://www.prospectpark.org/about]
    <b>Prospect</b> <b>Park</b> Zoo [http://www.prospectparkzoo.com/]
    <b>Prospect</b> <b>Park</b> [http://www.prospectpark.net/]  

### News

    boss = BOSSMan::Search.news("brooklyn new york", { :age => "1h" })
    puts boss.results.first.title
    puts "-" * 80
    puts boss.results.first.abstract
    
    => Brooklyn Park Helps Homeless
    --------------------------------------------------------------------------------
    When people lose their homes, they often turn to shelters as a last resort. Now, the City of Broo...
		
### Images

    boss = BOSSMan::Search.images("brooklyn dumbo", { :dimensions => "large" })
    boss.results.map { |result| result.url }

    => ["http://static.flickr.com/71/216529430_bf36a6c40b.jpg", "http://static.flickr.com/3215/2771873360_7cf2d7e572.jpg", "http://static.flickr.com/149/360481219_3ab59470cc.jpg", "http://static.flickr.com/3136/2768629082_bc0dcb76a3.jpg", "http://www.wirednewyork.com/brooklyn/dumbo/dumbo_brooklyn_bridge_3march02.jpg", "http://www.wirednewyork.com/brooklyn/dumbo/dumbo_brooklyn_bridge_plymouth_4july03.jpg", "http://static.flickr.com/3611/3538565901_f81eb52825.jpg", "http://static.flickr.com/2145/3539377152_1fd629db12.jpg", "http://static.flickr.com/2082/2340123052_fb8afe43b6.jpg", "http://static.flickr.com/3617/3508763096_ec8c53c061.jpg"]
  
### Spelling

    boss = BOSSMan::Search.spelling("Diabretes")
    boss.suggestion 

    => Diabetes
	
## Output Objects

### Common

- search.responsecode         : HTTP response code
- search.nextpage             : REST URL to next page of search results
- search.count                : Number of search results contained in response
- search.start                : Search result from which output starts
- search.totalhits            : De-duplicated total number of results search yielded
- search.deephits             : Total number of results search yielded
- search.results[].clickurl   : Tracking URL of result; must be used in user-facing anchor tags by BOSS TOU
- search.results[].url			  : URL of result

### Web

- search.results[].abstract   : Description of result with keywords emboldened
- search.results[].title      : Document title with keywords emboldened
- search.results[].dispurl    : Display URL of result
- search.results[].size       : Size of result in bytes
- search.results[].date       : Date result was indexed

### News

- search.results[].abstract   : Description of news story
- search.results[].title      : Title of news story
- search.results[].language   : Language of news story
- search.results[].date       : Last publication date of news story
- search.results[].time       : Last publication time of news story
- search.results[].source     : Source of news story
- search.results[].sourceurl  : URL of source publication

### Images

- search.results[].abstract		    	: Description of image
- search.results[].filename		    	: Filename of image
- search.results[].size				      : Size of image
- search.results[].format			    	: Format of image
- search.results[].height			    	: Height of full-size image
- search.results[].date			  	    : Last modification date of image (yyyy/mm/dd)
- search.results[].mimetype			    : MIME type of image
- search.results[].refererclickurl	: Link to page where image was found
- search.results[].refererurl 		  : Link to page where image was found
- search.results[].title				    : Title of image (usually the filename)
- search.results[].width				    : Width of full-size image
- search.results[].thumbnail_url		: URL of thumbnail image
- search.results[].thumbnail_height	: Height of thumbnail image
- search.results[].thumbnail_width  : Width of thumbnail image

### Spelling

- search.suggestion					        : Returns spelling suggestion from BOSS

### Raw dump formats

Result sets can be dumped as JSON, XML and YAML by use of to_json, to_xml, to_yaml respectively.

- search.to_xml			          : dumps XML of the result set
- search.to_json	 			      : dumps JSON of the result set
- search.to_yaml				      : dumps YAML of the result set
- search.results[3]			      : dumps XML of one search result
- search.results[3].to_json 	: dumps JSON of one search result
- search.results[3].to_yaml	  : dumps YAML of one search result

## Installation

    jp@populuxe:~/code/ruby$ gem install gemcutter
    jp@populuxe:~/code/ruby$ gem tumble
    jp@populuxe:~/code/ruby$ gem install bossman

## Requirements

- Active Support >= 2.1
- FakeWeb (in order to run the specs)

## LICENSE:

(The MIT License)

Copyright (c) 2008 Jay Pignata

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
