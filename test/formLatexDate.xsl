<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:import href="../stylesheet/functions.xsl" />
    <xsl:import href="../stylesheet/formLatexDate.xsl" />
    <xsl:import href="../stylesheet/labels_CZ.xsl" />

    <xsl:output indent="yes" />

    <xsl:variable name="date">
        <list><date>25.2.1869</date></list>
    </xsl:variable>

    <xsl:template match="/">
        <list>
        <xsl:apply-templates select="//test" />
        </list>
    </xsl:template>

    <xsl:template match="test">
        <xsl:variable name="input" select="input/child::*[1]" />
        <xsl:variable name="expected" select="expected" />
        <xsl:variable name="result">
            <xsl:apply-templates select="$input" />
        </xsl:variable>
        <input><xsl:sequence select="$input" /></input>
        <xsl:sequence select="$expected" />
        <result><xsl:sequence select="$result" /></result>
    </xsl:template>

</xsl:stylesheet>
