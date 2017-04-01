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
            <xsl:apply-templates select="//person" />
        </list>
    </xsl:template>

    <!--


    -->
    <xsl:template match="person">
        <person>
            <xsl:attribute name="id" select="@id" />
            <xsl:apply-templates select="name" />
        </person>
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
        <name>
            <xsl:value-of select="concat($second, '!', $first)" />
        </name>
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
