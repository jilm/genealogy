<?xml version="1.0" encoding="utf-8"?>

<!--


-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <!--

        List of all of the persons together with the all of the awaylable information
        included bibliography citations.

    -->
    <xsl:template match="person[name]" mode="list" priority="5" >
        <xsl:variable name="name">
            <xsl:apply-templates select="name" mode="reversed" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="jilm:getBirth(@id)" mode="cite" />
        </xsl:variable>
        <xsl:variable name="death"> 
            <xsl:apply-templates select="jilm:getDeath(@id)" mode="cite" />
        </xsl:variable>
        <xsl:value-of select="concat($name, ' ', $birth, ' ', $death)" />
    </xsl:template>

    <!--

        Person information that is placed into the footnote.

    -->
    <xsl:template match="person[name]" mode="text" priority="3" >
        <xsl:variable name="name">
            <xsl:apply-templates select="name" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="birth" mode="text" />
        </xsl:variable>
        <xsl:variable name="death">
            <xsl:apply-templates select="death" mode="text" />
        </xsl:variable>
        <xsl:value-of select="concat($name, ', ', $birth, ', ', $death)" />
    </xsl:template>

    <xsl:template match="person[name and birth and death]" mode="#default" priority="3" >
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

    <xsl:template match="person[name and birth]" mode="#default" priority="2" >
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

    <xsl:template match="person[@sex='male']" priority="2" mode="graph" >
        g[male]{
            <xsl:apply-templates select="name" />
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="birth" mode="graph" />
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="death" mode="graph" />
        }
        <xsl:apply-templates select="father" mode="graph" />
        <xsl:apply-templates select="mather" mode="graph" />
    </xsl:template>

    <xsl:template match="person[@sex='female']" priority="2" mode="graph" >
        g[female]{
            <xsl:apply-templates select="name" />
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="birth" mode="graph" />
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="death" mode="graph" />
        }
        <xsl:apply-templates select="father" mode="graph" />
        <xsl:apply-templates select="mather" mode="graph" />
    </xsl:template>

    <xsl:template match="father | mather" mode="graph">
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:variable name="wedding" select="jilm:getWedding($person/mather/@href)" />
        parent[family label={<xsl:apply-templates select="$wedding" mode="graph" />}]{
            <xsl:apply-templates select="$person" mode="graph" />
        }
    </xsl:template>

</xsl:stylesheet>
