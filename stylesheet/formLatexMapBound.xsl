<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xd="http://www.pnp-software.com/XSLTdoc"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:jilm="http://www.lidinsky.cz">

    <xsl:output method="text" encoding="utf-8" />

    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <xsl:apply-templates select="//svg:path" />
    </xsl:template>

    <xsl:template match="svg:path">
        <xsl:variable name="d" select="@d" />
        <xsl:value-of select="jilm:process($d, (0.0, 0.0), (0.0, 0.0))" />
    </xsl:template>
    
    <xsl:function name="jilm:process" as="xs:string">
        <xsl:param name="d" as="xs:string" />
        <xsl:param name="last-coord" as="xs:double*" />
        <xsl:param name="first-coord" as="xs:double*" />
            <xsl:variable name="code" select="substring($d, 1, 1)" />
            <xsl:choose>
                <xsl:when test="string-length($d) = 0">
                    <xsl:value-of select="''" />
                </xsl:when>
                <xsl:when test="substring($d, 1, 1) = 'M'">
                    <xsl:variable name="next-d" select="substring($d, 2)" />
                    <xsl:variable name="coord" select="jilm:getCoordinates($next-d)" />
                    <xsl:value-of select="concat('\draw', jilm:formCoordinates($coord), jilm:next($next-d, $coord, $coord))" />
                </xsl:when>
                <xsl:when test="substring($d, 1, 1) = 'L'">
                    <xsl:variable name="next-d" select="substring($d, 2)" />
                    <xsl:variable name="coord" select="jilm:getCoordinates($next-d)" />
                    <xsl:value-of select="concat('--', jilm:formCoordinates($coord), jilm:next($next-d, $coord, $first-coord))" />
                </xsl:when>
                <xsl:when test="substring($d, 1, 1) = 'z'">
                    <xsl:variable name="next-d" select="substring($d, 2)" />
                    <xsl:value-of select="concat('--', jilm:formCoordinates($first-coord), ';', jilm:process($next-d, (0.0, 0.0), (0.0, 0.0)))" />
                </xsl:when>
                <xsl:when test="substring($d, 1, 1) = 'l'">
                    <xsl:variable name="next-d" select="substring($d, 2)" />
                    <xsl:variable name="coord" select="jilm:getCoordinates($next-d)" />
                    <xsl:variable name="x" select="$coord[1] + $last-coord[1]" />
                    <xsl:variable name="y" select="$coord[2] + $last-coord[2]" />
                    <xsl:value-of select="concat('--', jilm:formCoordinates(($x, $y)), jilm:next($next-d, ($x, $y), $first-coord))" />
                </xsl:when>
            </xsl:choose>    
    </xsl:function>
    
    <xsl:function name="jilm:getCoordinates" as="xs:double*">
        <xsl:param name="d" as="xs:string" />
        <xsl:message select="$d" />
        <xsl:analyze-string select="$d" regex="^([0-9\-]*\.?[0-9]*),([\-0-9]*\.?[0-9]*)([MLlz].*$)">
            <xsl:matching-substring>
                <xsl:variable name="x" select="number(regex-group(1)) * 0.01" as="xs:double" />
                <xsl:variable name="y" select="number(regex-group(2)) * 0.01" as="xs:double" />
                <xsl:sequence select="($x, $y)" />
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
    <xsl:function name="jilm:formCoordinates" as="xs:string">
        <xsl:param name="coord" as="xs:double*" />
        <xsl:value-of select="concat('(', substring(string($coord[1]), 1, 4), ',', substring(string($coord[2] - 4.0),1, 4), ')')" />
    </xsl:function>
    
    <xsl:function name="jilm:next" as="xs:string">
        <xsl:param name="d" as="xs:string" />
        <xsl:param name="last-coord" as="xs:double*" />
        <xsl:param name="first-coord" as="xs:double*" />
        <xsl:choose>
        <xsl:when test="string-length($d) gt 0">
        <xsl:analyze-string select="$d" regex="^[0-9\.,\-]+([MLlz].*)$">
            <xsl:matching-substring>
                <xsl:value-of select="jilm:process(regex-group(1), $last-coord, $first-coord)" />
            </xsl:matching-substring>
        </xsl:analyze-string>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="''" />
        </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



</xsl:stylesheet>
