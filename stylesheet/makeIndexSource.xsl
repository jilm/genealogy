<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="placeTemplate.xsl" />
    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <list> 
            <xsl:apply-templates select="//person" />
        </list>
    </xsl:template>

    <!--


    -->
    <xsl:template match="person">
        <index-item>
            <xsl:attribute name="id" select="@id" />
            <xsl:apply-templates select="name" />
        </index-item>
    </xsl:template>

    <!--

        Person name.

    -->
    <xsl:template match="name">
        <xsl:variable name="first">
            <xsl:apply-templates select="first" />
        </xsl:variable>
        <xsl:variable name="second">
            <xsl:apply-templates select="second" />
        </xsl:variable>
        <xsl:value-of select="concat($second, '!', $first)" />
    </xsl:template>

    <xsl:template match="first">
        <first>
            <xsl:apply-templates />
        </first>
    </xsl:template>

    <xsl:template match="second">
        <second>
            <xsl:apply-templates />
        </second>
    </xsl:template>

</xsl:stylesheet>
