<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t"
 version="2.0">
 <xsl:output  omit-xml-declaration="yes" xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>

<xsl:template match="*:body">
 <text xmlns="http://www.tei-c.org/ns/1.0">
  <front>  </front>
  <body><xsl:apply-templates/></body>
 </text>
</xsl:template>
 
 <xsl:template match="*:sc">
 <hi rend="sc"><xsl:apply-templates/></hi>
</xsl:template> 
 
 <xsl:template match="*:ptr">
  <xsl:variable name="target">
   <xsl:value-of select="substring-after(@target,'#')"/>
  </xsl:variable>
  <xsl:apply-templates select="//*:note[@xml:id eq $target]"/>
  <xsl:if test="not(//*:note[@xml:id eq $target])">
   <xsl:message>Unable to find matching note for <xsl:value-of select="$target"/></xsl:message>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="*:div[@type='notes']"/>
 <xsl:template match="//*:note/@xml:id"/>
 <xsl:template match="note">
  <note place="foot">
   <xsl:apply-templates/>
  </note>
 </xsl:template>
 <xsl:template match="* | @* | processing-instruction() | comment()">
  <xsl:copy>
   <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
  </xsl:copy>
 </xsl:template>
 <xsl:template match="text()">
  <xsl:value-of select="."/>
  <!-- could normalize() here -->
 </xsl:template>
</xsl:stylesheet>