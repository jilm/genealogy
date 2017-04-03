<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:template match="birth[date and place]" mode="#all">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat($BIRTH-SYMBOL, $date, ', ', $place)" />
    </xsl:template>

</xsl:stylesheet>
