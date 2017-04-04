<?xml version="1.0" encoding="utf-8"?>

<!--

    Templates that transform a person info into the form of latex source.

    text:

    footnote: [name], [birth], [death], [wedding]

    list: 

-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >

    <!--

        List of all of the persons together with the all of the awaylable information
        included bibliography citations.

    -->
    <xsl:template match="person[name]" mode="list" priority="3" >
        <xsl:variable name="name">
            <xsl:apply-templates select="name" mode="reverse" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="birth" mode="cite" />
        </xsl:variable>
        <xsl:variable name="death">
            <xsl:apply-templates select="death" mode="cite" />
        </xsl:variable>
        <xsl:value-of select="concat($name, ', ', $birth, ', ', $death)" />
    </xsl:template>

    <!--

        Person information that is placed into the footnote.

    -->
    <xsl:template match="person[name]" mode="text" priority="3" >
        <xsl:variable name="name">
            <xsl:apply-templates select="name" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="birth" mode="full" />
        </xsl:variable>
        <xsl:variable name="death">
            <xsl:apply-templates select="death" mode="full" />
        </xsl:variable>
        <xsl:value-of select="concat($name, ', ', $birth, ', ', $death)" />
    </xsl:template>

    <xsl:template match="person[name and birth and death]" mode="#all" priority="3" >
        <xsl:variable name="name">
            <xsl:apply-templates select="name" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="birth" />
        </xsl:variable>
        <xsl:variable name="death">
            <xsl:apply-templates select="death" />
        </xsl:variable>
        <xsl:value-of select="concat($name, ', ', $birth, ', ', $death)" />
    </xsl:template>

    <xsl:template match="person[name and birth]" mode="#all" priority="2" >
        <xsl:variable name="name">
            <xsl:apply-templates select="name" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="birth" />
        </xsl:variable>
        <xsl:value-of select="concat($name, $birth)" />
    </xsl:template>

    <xsl:template match="person[name]" mode="#all" priority="1" >
        <xsl:apply-templates select="name" />
    </xsl:template>

</xsl:stylesheet>
