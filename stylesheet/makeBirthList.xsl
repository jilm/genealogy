<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="placeTemplate.xsl" />

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
        <date>
            <xsl:apply-templates />
        </date>
    </xsl:template>

    <xsl:template match="matrika/birth">
        <birth>
            <xsl:apply-templates select="born" />
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </birth>
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
