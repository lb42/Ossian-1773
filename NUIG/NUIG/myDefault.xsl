<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="1.0">
	
	<xsl:param name="display">entire</xsl:param>
	<xsl:param name="section">body</xsl:param>
	<xsl:param name="url">https://ossianonline.nuigalway.ie/edition/6/</xsl:param>
	<xsl:param name="imagePath">https://ossianonline.nuigalway.ie/storage/img/600_edition_6/</xsl:param>
	
	<xsl:param name="start">1</xsl:param>
	<xsl:param name="end">2</xsl:param>
<!-- params as per email from david kelly on 25/4
    display: 'entire'
    section: 'body'
    url: https://ossianonline.nuigalway.ie/edition/6/
    imagePath:  https://ossianonline.nuigalway.ie/storage/img/600_edition_6/
    start: '1'
    end: '2'
-->
	<!-- https://addons.omeka.org/svn/plugins/TeiDisplay/trunk/libraries/default.xsl -->
	<!-- include component.xsl, created by CDL for XTF -->
	<xsl:include href="includes/bootstrap-component.xsl"/>

	<xsl:template match="/">
		<div class="navbar navbar-default" id="edition-top-nav-wrapper">
			<div class="container">
			 	<div class="col-xs-8 col-sm-6">
				 	<div class="navbar-header">
				      <button type="button" class="navbar-toggle navbar-left" data-toggle="collapse" data-target="#edition-top-nav">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"><span class="text-hide">Dropdown</span></span>
				        <span class="icon-bar"><span class="text-hide">Dropdown</span></span>
				        <span class="icon-bar"><span class="text-hide">Dropdown</span></span>
				      </button>
				    </div>

				 	<div class="collapse navbar-collapse" id="edition-top-nav">
	      				
		                <div class="tei_toc">
		                	<!-- <h4>Table of Contents</h4> -->
		                	<ul class="nav navbar-nav">
								<xsl:call-template name="toc"/>
							</ul>
						</div>
		            </div>
		    	</div>

		    	<div class="col-xs-4 col-sm-6">
		            <ul class="nav navbar navbar-right">
	                	<li class="dropdown">
				          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
				           Options 
				          	<b class="caret">
				          		<span class="text-hide">Dropdown</span>
				          	</b>
				          </a>
				          <ul class="dropdown-menu">
			                	<li><a href="{$url}">View Entire Document</a></li>
			                    <li><a href="{$url}/?type=xml">View TEI XML</a></li>
			                    <li><a href="{$url}/?type=xml&amp;download=1">Download XML File</a></li>
			                    <li><a href="{$url}/?type=text">Download Plain Text</a></li>
			                    <li><a id="toggle-page-numbers" href="#">Show/Hide Page Numbers</a></li>
			              </ul>
			            </li>
	                </ul>
	            </div>
	        </div>
        </div>

		<div id="tei_display" class="row">

			<xsl:choose>
				<xsl:when test="$display = 'entire'">
					<div class="col-xs-6" id="tei-content-wrapper">
						<xsl:apply-templates select="//*[local-name()='text']"/>

                        <!-- Add notes to footer of document to avoid causing line breaks
                        when hidden elements are added to paragraphs -->
                        <xsl:apply-templates select="//*[local-name()='note']" mode="notebody" />

					</div>
				</xsl:when>
				<xsl:when test="$display='segmental'">
					
    					<div class="col-xs-6">

	    					<xsl:choose>
								<xsl:when test="string($section)">
									<xsl:apply-templates select="descendant::node()[concat(count(ancestor::node()), '0000', count(preceding::node()))=$section]"/>
								</xsl:when>
								<xsl:otherwise>
									<p>
										<b>Select a section from the table of contents on the left.</b>
									</p>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:apply-templates select="//*[local-name()='note']" mode="notebody" />
	                    </div>
					
				</xsl:when>
			</xsl:choose>
			
			<div id="side-matter-wrapper" class="col-xs-5 col-xs-offset-0 col-sm-offset-1">
				<div  id="side-matter">
					
				</div>
			</div>
				
		</div>
	</xsl:template>

<!-- 	
	This is working pagination (when start/end pages are given)
	...needs to be integrated with the above.
	

	<xsl:template match="tei:pb"> 
	  <xsl:if test="@n=$start"> 
	    <xsl:copy-of select="."/> 
	  </xsl:if> 
	</xsl:template>  

	<xsl:template match="text()"> 
	  <xsl:choose> 
	    <xsl:when test="preceding::tei:pb[@n=$end]"> 
	    </xsl:when> 
	    <xsl:when test="following::tei:pb[@n=$start]"> 
	    </xsl:when> 
	    <xsl:otherwise> 
	      <xsl:copy-of select="."/> 
	    </xsl:otherwise> 
	  </xsl:choose> 
	</xsl:template>  

	<xsl:template match="*"> 
	  <xsl:choose> 
	    <xsl:when test=".//tei:pb[@n=$start or @n=$end]"> 
	      <xsl:copy> 
		    <xsl:copy-of select="@*"/> 
		    <xsl:apply-templates/> 
	      </xsl:copy> 
	    </xsl:when> 
	    <xsl:when test="following::tei:pb[@n=$end] and preceding::tei:pb[@n=$start]"> 
	      <xsl:copy-of select="."/> 
	    </xsl:when> 
	  </xsl:choose> 
	</xsl:template>  -->

	<xsl:template name="toc">
		<xsl:if test="//*[local-name()='front']">
			
				<xsl:apply-templates
					select="descendant::*[local-name()='front']/*[local-name()='div1'] | descendant::*[local-name()='front']/*[local-name()='div']"
					mode="toc"/>
			
		</xsl:if>


			<xsl:apply-templates
				select="descendant::*[local-name()='body']/*[local-name()='div1'] | descendant::*[local-name()='body']/*[local-name()='div']"
				mode="toc"/>

	</xsl:template>

	<xsl:template match="*[local-name()='div'] | *[local-name()='div1'] | *[local-name()='div2']"
		mode="toc">
		<li>
			<!-- 
			<xsl:if test="@type">
				<span class="toc_type">
					<xsl:value-of select="@type"/>
				</span>
				<xsl:text>: </xsl:text>
			</xsl:if> -->
			
			<xsl:variable name="title">
				<xsl:choose>
					<xsl:when test="string(normalize-space(*[local-name()='head']))">
							
					 <!--<xsl:value-of select="normalize-space(*[local-name()='head'][1])"/> 
					-->	
						<xsl:value-of select="normalize-space(*[local-name()='head'][1]/text())"></xsl:value-of>
				</xsl:when>
					<xsl:otherwise>[No Title]</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="$section=concat(count(ancestor::node()), '0000', count(preceding::node()))">
					<b>
						<xsl:value-of select="$title"/>
					</b>
				</xsl:when>
				<xsl:otherwise>
					<a href="?section={concat(count(ancestor::node()), '0000', count(preceding::node()))}">
						<xsl:value-of select="$title"/>
					</a>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if
				test="child::*[local-name()='div2'] or (child::*[local-name()='div'] and (parent::*[local-name()='front'] or parent::*[local-name()='body']))">
				<xsl:variable name="ids">
					<xsl:for-each select="child::*[local-name()='div2'] | child::*[local-name()='div']">
						<xsl:value-of select="concat('|',concat(count(ancestor::node()), '0000', count(preceding::node())),'|')"/>
					</xsl:for-each>
				</xsl:variable>
				<!-- <a class="toggle_toc">Â±</a> -->
				<xsl:choose>
					<xsl:when test="string($section) and contains($ids, concat('|',$section,'|'))">
						<ul class="toc_sub">
							<xsl:apply-templates
								select="*[local-name()='div'] | *[local-name()='div2']" mode="toc"/>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						<ul class="toc_sub" style="display:none;">
							<xsl:apply-templates
								select="*[local-name()='div'] | *[local-name()='div2']" mode="toc"/>
						</ul>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template
		match="*[local-name()='div1'] | *[local-name()='div'][parent::*[local-name()='body']] | *[local-name()='div'][parent::*[local-name()='front']]">
		<div class="tei_section">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template
		match="*[local-name()='div2'] | *[local-name()='div'][parent::*[local-name()='body']]/*[local-name()='div'] | *[local-name()='div'][parent::*[local-name()='front']]/*[local-name()='div']">
		<div class="tei_subsection">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- disable teiHeader from public display, by default.  pertinent metadata is display with DC fields -->
	<xsl:template match="*[local-name()='teiHeader']"/>

</xsl:stylesheet>