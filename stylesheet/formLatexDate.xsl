<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:template match="date">
        <xsl:variable name="date" select="jilm:analyze-data(text())" />
        <xsl:value-of select="$date/year" />
    </xsl:template>

</xsl:stylesheet>
