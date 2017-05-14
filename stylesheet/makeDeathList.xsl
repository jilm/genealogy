<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="commonTemplates.xsl" />
    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <list> 
            <xsl:apply-templates select="//death" />
        </list>
    </xsl:template>

    <xsl:template match="matrika/death">
        <death>
            <xsl:call-template name="cite">
                <xsl:with-param name="event" select="." />
            </xsl:call-template>           
            <xsl:apply-templates select="died" />
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </death>
    </xsl:template>

    <xsl:template match="person/death">
        <xsl:variable name="ref" select="../@id" />
        <death>
            <died>
                <xsl:attribute name="href" select="$ref" />
            </died>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </death>
    </xsl:template>

    <xsl:template match="died" >
      <died>
        <xsl:attribute name="href" select="@href" />
      </died>
    </xsl:template>

</xsl:stylesheet>
