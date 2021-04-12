<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t"
 version="2.0">
 <xsl:output  omit-xml-declaration="yes" xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>

<xsl:template match="t:pb">
 <pb>
  <xsl:attribute name="xml:id" select="concat('P',@n)"/>
  <xsl:attribute name="facs" select="concat('../img/',@facs)"/>
 </pb>
</xsl:template>

 <xsl:template match="//t:front[not(*)]">
  <front>
   <titlePage><titlePart>
    <xsl:value-of select="following::t:head[1]"/>
   </titlePart></titlePage>
  </front>
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