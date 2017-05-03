<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xd="http://www.pnp-software.com/XSLTdoc">
                
    <xd:doc type="stylesheet">
    
        Generates the geographical map of places where ancestors were born.
    
    </xd:doc>
                
                
    <xsl:template match="value[@key = 'map']">
        \begin{tikzpicture}[scale=0.05]
        <xsl:call-template name="makePlaceMap">
            <xsl:with-param name="places" select="$personList//place" />
        </xsl:call-template>
        \end{tikzpicture}
    </xsl:template>            

    <xsl:template name="makePlaceMap">

        <xsl:param name="places" />
    
        <xsl:variable name="width" as="xs:decimal" select="482.5" />
        <xsl:variable name="height" as="xs:decimal" select="278" />
        <xsl:variable name="north" as="xs:decimal" select="51.0555556" />
        <xsl:variable name="south" as="xs:decimal" select="48.5525" />
        <xsl:variable name="west" as="xs:decimal" select="12.0913889" />
        <xsl:variable name="east" as="xs:decimal" select="18.8588889" />
    
        <xsl:for-each select="doc('../resources/places.xml')//place">
            <xsl:variable name="parish" select="parish" />
            <xsl:variable name="district" select="district" />
            <xsl:variable name="c" select="count($places[parish = $parish and district = $district])" />
            <xsl:if test="$c gt 0">
                <xsl:variable name="coord" select="coordinates" />
                <xsl:variable name="x" select="($coord/lon/text() - $west) * $width div ($east - $west)" />
                <xsl:variable name="y" select="($coord/lat/text() - $north) * $height div ($south - $north)" />
                <xsl:variable name="r" select="math:sqrt($c div math:pi()) * 2.0" />
                \draw (<xsl:value-of select="$x" />,<xsl:value-of select="$y" />) circle [radius=<xsl:value-of select="$r" />];                        
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>