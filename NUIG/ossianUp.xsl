<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:e="http://distantreading.net/eltec/ns" exclude-result-prefixes="xs e" version="2.0">
<!-- TODO
        remove comments and associated whitespace
        -->
    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

<xsl:template match="comment()"/>

    <xsl:template match="TEI/text/group">
        <!-- selects volumes -->        
        <xsl:apply-templates select="text"/>
    </xsl:template>
    <xsl:template match="TEI/text/group/text/group">
        <body xmlns="http://www.tei-c.org/ns/1.0">   
        <xsl:apply-templates/></body>
    </xsl:template>
    <xsl:template match="TEI/text/group/text/group/text">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="poem">
            <xsl:apply-templates select="body"/>
        </div>
    </xsl:template>
 
 <xsl:template match="body|group"><xsl:apply-templates/></xsl:template>
    <xsl:template match="@type[. eq 'translation']">
        <xsl:attribute name="type">maintext</xsl:attribute>
    </xsl:template>
    <xsl:template match="@rend[. eq 'sc']">
        <xsl:attribute name="rend">smallcaps</xsl:attribute>
    </xsl:template>
    <xsl:template match="@anchored"/>
    <xsl:template match="@part"/>
    <xsl:template match="note">
        <note xmlns="http://www.tei-c.org/ns/1.0" place="bottom">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
</xsl:stylesheet>
