<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jilm="http://www.lidinsky.cz">


    <xsl:template match="date">
        <xsl:sequence select="jilm:analyze-date(text())" />
    </xsl:template>

</xsl:stylesheet>
