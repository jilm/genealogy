<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="/">
        <list>
            <xsl:apply-templates select="//person" />
        </list>
    </xsl:template>

    <xsl:template match="person">
        <person>
            <xsl:attribute name="id" select="@id" />
            <xsl:apply-templates select="name" />
            <birth>
                <xsl:apply-templates select="birth" />
                <xsl:apply-templates select="father" />
                <xsl:apply-templates select="mather" />
            </birth>
        </person>
    </xsl:template>

    <xsl:template match="name[empty(*)]">
        <xsl:variable name="splited" select="tokenize(text(), '\s')" />
        <xsl:variable name="given" select="$splited[1]" />
        <xsl:variable name="family" select="$splited[2]" />
        <name>
            <first><xsl:value-of select="$given" /></first>
            <second><xsl:value-of select="$family" /></second>
        </name>
    </xsl:template>

    <xsl:template match="father[@href]">
        <father>
            <xsl:attribute name="href" select="@href" />
        </father>
    </xsl:template>

    <xsl:template match="mather[@href]">
        <mather>
            <xsl:attribute name="href" select="@href" />
        </mather>
    </xsl:template>

    <xsl:template match="date">
        <xsl:sequence select="jilm:analyze-date(text())" />
    </xsl:template>

    <xsl:template match="place">
        <place>

        </place>
    </xsl:template>

</xsl:stylesheet>
