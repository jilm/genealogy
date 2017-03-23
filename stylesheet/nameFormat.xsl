<?xml version="1.0" encoding="utf-8"?>

<!--

    Format a name of the person. There are two variants:
    
    first second; Jiří Klepal
    
    second, first; Klepal Jiří
    
    Marie Skálová rozená Pavlíková
    
    Skálová Marie, rozená Pavlíková

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="name[first and second]" priority="5">
        <xsl:variable name="first">
            <xsl:apply-templates select="first" />
        </xsl:variable>
        <xsl:variable name="second">
            <xsl:apply-templates select="second" />
        </xsl:variable>
        <xsl:value-of select="concat($first, ' ', $second)" />
    </xsl:template>
    
    <xsl:template match="name[first and second]" priority="5" mode="reversed">
        <xsl:variable name="first">
            <xsl:apply-templates select="first" />
        </xsl:variable>
        <xsl:variable name="second">
            <xsl:apply-templates select="second" />
        </xsl:variable>
        <xsl:value-of select="concat($second, ' ', $first)" />
    </xsl:template>

    <xsl:template match="name[second]" priority="4" mode="#all">
        <xsl:variable name="second">
            <xsl:apply-templates select="second" />
        </xsl:variable>
        <xsl:value-of select="$second" />        
    </xsl:template>
    
    <xsl:template match="name[first]" priority="3" mode="#all">
        <xsl:variable name="first">
            <xsl:apply-templates select="first" />
        </xsl:variable>
        <xsl:value-of select="$first" />        
    </xsl:template>
    
    <xsl:template match="name" priority="2" mode="#all" >
        <xsl:apply-templates />
    </xsl:template>


</xsl:stylesheet>
