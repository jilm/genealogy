<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="placeTemplate.xsl" />
    <xsl:import href="dateTemplate.xsl" />
    <xsl:import href="functions.xsl" />


    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <list> 
            <xsl:apply-templates select="//wedding" />
        </list>
    </xsl:template>

    <xsl:template match="matrika/wedding">
        <wedding>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
            <xsl:apply-templates select="bride" />
            <xsl:apply-templates select="bridegroom" />
        </wedding>
    </xsl:template>

    <xsl:template match="person/wedding">
        <wedding>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
            <bride>
                <xsl:attribute name="href" select="../@id" />
            </bride>
        </wedding>
    </xsl:template>

    <xsl:template match="bride" >
      <bride>
        <xsl:attribute name="href" select="@href" />
      </bride>
    </xsl:template>

    <xsl:template match="bridegroom" >
      <bridegroom>
        <xsl:attribute name="href" select="@href" />
      </bridegroom>
    </xsl:template>

</xsl:stylesheet>
