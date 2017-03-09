<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

        Keep the element person, but inside, elements must be in specific
        order. Moreover referenced information is resolved.

    -->
    <xsl:template match="person">
        <person>
            <xsl:attribute name="id" select="@id" />
            <xsl:attribute name="sex" select="@sex" />
            <xsl:apply-templates select="name" />
            <xsl:apply-templates select="birth" />
            <xsl:apply-templates select="wedding" />
            <xsl:apply-templates select="death" />
            <xsl:apply-templates select="father" />
            <xsl:apply-templates select="mather" />
        </person>
    </xsl:template>

    <!--

        Person name.

    -->
    <xsl:template match="name">
        <name>
            <xsl:apply-templates select="first" />
            <xsl:apply-templates select="second" />
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

    <xsl:template match="birth">
        <birth>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </birth>
    </xsl:template>

    <xsl:template match="date">
        <date>
            <xsl:apply-templates />
        </date>
    </xsl:template>
    
    <xsl:template match="place">
        <place>
            <xsl:apply-templates />
        </place>
    </xsl:template>

    <xsl:template match="wedding">
        <wedding>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </wedding>
    </xsl:template>

    <xsl:template match="death">
        <death>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </death>
    </xsl:template>

    <xsl:template match="father">
        <father>
            <xsl:attribute name="href" select="@href" />
        </father>
    </xsl:template>

    <xsl:template match="mather">
        <mather>
            <xsl:attribute name="href" select="@href" />
        </mather>
    </xsl:template>

</xsl:stylesheet>
