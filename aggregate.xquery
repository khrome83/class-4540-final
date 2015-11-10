(:
    Name: Zane C. Milakovic
    Date: 11/10/2015
    File: aggregate.xquery
    Final Project
:)

declare copy-namespaces no-preserve, no-inherit;


(: Added comment block and xml-stylesheet defininition :)
<!--
    Name: Zane C. Milakovic
    Date: 11/10/2015
    File: aggregate.xml
    Final Project
-->,
<?xml-stylesheet type="text/xsl" href="aggregate.xsl"?>,
<rss version="2.0"
   	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:wfw="http://wellformedweb.org/CommentAPI/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
	xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
    xsi:noNamespaceSchemaLocation="rss-2_0.xsd">
	<channel>
	   <title>Web Development Podcast Aggregate</title>
	   <description>A aggregation of four web development podcasts, sorted by date published.</description>
       <link>http://zanemilakovic.com</link>
       {
        
            let $items := (
                doc("source/backToFront.xml")//item,
                doc("source/shopTalkShow.xml")//item,
                doc("source/theWebAhead.xml")//item,
                doc("source/unfinishedBusiness.xml")//item
            )
    
            for $x in $items
                (:
                    The follow borrows concepts from this site to format pubDate element in a way that can be ordered.
                    Input: Sat, 17 Jan 2015 09:17:03 +0000
                    Output: 2015-01-17T09:17:03-00:00
                    
                    Source: http://nativexmldatabase.com/2011/03/18/xquery-and-sqlxml-how-to-convert-a-date-that-is-not-a-date-into-a-date/
                :)
                
                let $date := string($x/pubDate)
                let $pieces := fn:tokenize($date, " ")
                let $map := <map><Jan>01</Jan><Feb>02</Feb><Mar>03</Mar><Apr>04</Apr><May>05</May><Jun>06</Jun><Jul>07</Jul><Aug>08</Aug><Sep>09</Sep><Oct>10</Oct><Nov>11</Nov><Dec>12</Dec></map>
                let $month := $map/*[name()=$pieces[3]]/text()
                let $timestamp := fn:concat($pieces[4],"-",$month,"-",$pieces[2],"T",$pieces[5])
    
                (: Order by the now correct timestamp, dateTime format :)
                order by xs:dateTime($timestamp)
                
                let $img := string($x/itunes:image/@href)
                
                return
                    <item>
                        <year>{$pieces[4]}</year>
                    {
                         $x/title,
                         $x/guid,
                         $x/link,
                         $x/pubDate,
                         $x/itunes:author,
                         $x/itunes:duration,
                         $x/enclosure
                    }
                    {
                       (:
                           Need to ensure we have some image as a default
                           only if field does not exist in original RSS
                       :)
                        if(fn:string-length($img) > 0)
                        then
                         <itunes:image href="{$img}"/>
                        else
                         <itunes:image href="default.jpg"/>
                    }
                    </item>
        }
    </channel>
</rss>
