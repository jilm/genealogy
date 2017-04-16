<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jilm="http://www.lidinsky.cz">

    <xsl:import href="placeTemplate.xsl" />
    <xsl:import href="dateTemplate.xsl" />
    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <list> 
            <xsl:apply-templates select="//birth" />
        </list>
    </xsl:template>

    <xsl:template match="date">
        <xsl:sequence select="jilm:analyze-date(text())" />
    </xsl:template>

    <xsl:template match="matrika/birth">
        <birth>
            <cite>
              <xsl:attribute name="href" select="../@id" />
              <xsl:apply-templates select="page" />
            </cite>
            <xsl:apply-templates select="born" />
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </birth>
    </xsl:template>

    <xsl:template match="matrika/page">
        <xsl:apply-templates select="page" />
        <xsl:apply-templates select="scan" />
    </xsl:template>

    <xsl:template match="page/page" >
        <page><xsl:apply-templates /></page>
    </xsl:template>

    <xsl:template match="scan">
        <scan><xsl:apply-templates /></scan>
    </xsl:template>

    <xsl:template match="person/birth">
        <xsl:variable name="ref" select="../@id" />
        <birth>
            <born>
                <xsl:attribute name="href" select="$ref" />
            </born>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </birth>
    </xsl:template>

    <xsl:template match="born" >
      <born>
        <xsl:attribute name="href" select="@href" />
      </born>
    </xsl:template>

</xsl:stylesheet>
