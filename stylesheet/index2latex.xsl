<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="placeTemplate.xsl" />

    <xsl:output method="text" encoding="utf-8" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <xsl:apply-templates select="//index-item" />
    </xsl:template>

    <!--


    -->
    <xsl:template match="index-item">
        <xsl:value-of 
            select="concat('\newcommand{\', @id, '}{\index{', text(), '}}')" />
    </xsl:template>

</xsl:stylesheet>
