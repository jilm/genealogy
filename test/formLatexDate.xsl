<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:import href="../stylesheet/functions.xsl" />
    <xsl:import href="../stylesheet/formLatexDate.xsl" />
    <xsl:import href="../stylesheet/labels_CZ.xsl" />

    <xsl:variable name="date">
        <list><date>25.2.1869</date></list>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:apply-templates select="$date//date" />
        <xsl:apply-templates select="$date//date" mode="year" />
        <xsl:apply-templates select="$date//date" mode="long" />
        <xsl:apply-templates select="$date//date" mode="vmy" />
    </xsl:template>

</xsl:stylesheet>
