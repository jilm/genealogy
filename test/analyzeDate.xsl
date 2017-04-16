<?xml version="1.0" encoding="utf-8"?>

<!--


-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:import href="../stylesheet/functions.xsl" />

    <xsl:template match="/" priority="1">
        <xsl:message>Analyze date function test</xsl:message>
        <xsl:variable name="result" select="jilm:analyze-date('15.2.1869')" />
        <xsl:choose>
            <xsl:when test="$result/day/text()='15' and $result/month/text()='2' and $result/year/text()='1869'" >
                <xsl:message>PASSED</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">FAILED</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:sequence select="$result" />
        <xsl:next-match />
    </xsl:template>

    <xsl:template match="/" priority="2">
        <xsl:message>Analyze date function test2</xsl:message>
        <xsl:variable name="result" select="jilm:analyze-date('1869')" />
        <xsl:choose>
            <xsl:when test="not($result/day) and not($result/month) and $result/year/text()='1869'" >
                <xsl:message>PASSED</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">FAILED</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:sequence select="$result" />
        <xsl:next-match />
    </xsl:template>


</xsl:stylesheet>
