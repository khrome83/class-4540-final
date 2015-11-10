<?xml version="1.0" encoding="UTF-8"?>
<!--
    Name: Zane C. Milakovic
    Date: 11/10/2015
    File: aggregate.xsl
	Project: Final
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="1.0">
    <xsl:output method="html"/>

    <xsl:template match="pubDate">
        <div class="citation">
            <span class="context">published</span>
            <span class="author"><xsl:value-of select="."/></span>
        </div>
    </xsl:template>

    <xsl:template match="itunes:author">
        <div class="citation">
            <span class="context">by</span>
            <span class="author"><xsl:value-of select="."/></span>
        </div>
    </xsl:template>
    
    <xsl:template match="title">
        <h3><xsl:value-of select="."/></h3>
    </xsl:template>

    <xsl:template match="item">
        <div class="entry y{./year}">
            <xsl:apply-templates select="./title"/>
            <div class="img">
                <img src="{./itunes:image/@href}" />
            </div>
            <div class="info">
                <xsl:apply-templates select="itunes:author"/>
                <xsl:apply-templates select="pubDate"/>
            </div>
            <div class="linkbar">
                <a href="{./enclosure/@url}" title="listen">Listen</a> | 
                <a href="{./link}" title="source">Source</a>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="channel">
        <div class="content">
        <xsl:apply-templates select="//item"/>
        </div>
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <title>Web Development Podcast Aggregate</title>
                <script src="jquery.js" />
                <script src="main.js" />
                <link rel="stylesheet" href="main.css"/>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </head>
            <body>
                <h1>Web Development Podcast Aggregate</h1>
                <div class="infobar">
                    <xsl:variable name="sum11" select="count(//item/year[contains(., '2011')])" />
                    <xsl:variable name="sum12" select="count(//item/year[contains(., '2012')])" />
                    <xsl:variable name="sum13" select="count(//item/year[contains(., '2013')])" />
                    <xsl:variable name="sum14" select="count(//item/year[contains(., '2014')])" />
                    <xsl:variable name="sum15" select="count(//item/year[contains(., '2015')])" />
                    <xsl:variable name="sum" select="count(//item)" />
                    <div class="infobarcontent">
                        <div class="calc">
                            In <a class="filter" href="#2011">2011</a>: 
                            <span class="total"><xsl:value-of select="$sum11" /></span>
                        </div>
                        <div class="calc">
                            In <a class="filter" href="#2012">2012</a>: 
                            <span class="total y2012"><xsl:value-of select="$sum12" /></span>
                        </div>
                        <div class="calc">
                            In <a class="filter" href="#2013">2013</a>: 
                            <span class="total y2013"><xsl:value-of select="$sum13" /></span>
                        </div>
                        <div class="calc">
                            In <a class="filter" href="#2014">2014</a>: 
                            <span class="total y2014"><xsl:value-of select="$sum14" /></span>
                        </div>
                        <div class="calc">
                            In <a class="filter" href="#2015">2015</a>: 
                            <span class="total y2015"><xsl:value-of select="$sum15" /></span>
                        </div>
                        <div class="calc final">
                            <a class="filter" href="#all">Total</a> Episodes: <span class="total"><xsl:value-of select="$sum" /></span>
                        </div>
                    </div>        
                </div>
                <div class="desc">
                    <h4>About the Project</h4>
                    <p>This project takes four podcast feeds from different web development podcasts and aggregates them together. They are ordered by the original publish date. The filters at the top are provided to allow you to view a specific year. The site is responsive and is expected to work on a mobile device.</p>
                    <div class="sourcebar">
                        <a class="togglesource" href="#sources" title="Toggle Sources">Toggle Sources</a>
                    </div>
                    
                    <section class="sources" style="display: none;">
                        <dl>
                            <dt><a href="http://shoptalkshow.com/" title="Shop Talk Show">Shop Talk Show</a></dt>
                            <dd>
                                <p>Chris Coyer and Dave Rupert talk about web development, with featured guests and sound effects too. This is my absolute favorite podcast. Chris and Dave are very very funny. This podcast helped me level up.</p>
                            </dd>
                            <dt><a href="http://www.unfinished.bz/" title="Unfinished Business">Unfinished Business</a></dt>
                            <dd>
                                <p>Andy Clarke invites guests on to talk about Web Development and other things.</p>
                            </dd>
                            <dt><a href="http://backtofrontshow.com/" title="Back to Front">Back to Front</a></dt>
                            <dd>
                                <p>A weekly web industry podcast hosted by Keir Whitaker and Kieran Masterton.</p>
                            </dd>
                            <dt><a href="http://5by5.tv/webahead" title="The Web Ahead">The Web Ahead</a></dt>
                            <dd>
                                Jen Simmons hosts one of the longest running podcasts that features expert guests talking about what is next for the web.
                            </dd>
                        </dl>
                    </section>
                    <a class="close" href="#close" title="close">X</a>
                </div>
                <xsl:apply-templates select="//channel"/>
                <footer>by Zane C. Milakovic</footer>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>