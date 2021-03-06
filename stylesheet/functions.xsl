<?xml version="1.0" encoding="utf-8"?>

<!--

    General purpose functions

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" >

    <xsl:variable name="personList" select="doc('../build/personList.xml')" />
    <xsl:variable name="weddingList" select="doc('../build/weddingList.xml')" />
    <xsl:variable name="birthList" select="doc('../build/birthList.xml')" />
    <xsl:variable name="deathList" select="doc('../build/deathList.xml')" />
    <xsl:variable name="placeList" select="doc('../resources/places.xml')" />

    <xsl:function name="jilm:getPerson">
        <xsl:param name="ref" />
        <xsl:variable name="person" select="$personList//person[@id = $ref]" />
        <xsl:if test="empty($person)">
            <xsl:message>
                A person with given id was not found.
                <xsl:value-of select="$ref" />
            </xsl:message>
        </xsl:if>
        <xsl:sequence select="$person" />
    </xsl:function>

    <xsl:function name="jilm:getWedding">
        <xsl:param name="ref" />
        <xsl:variable name="wedding"
                      select="$weddingList//wedding[bride/@href = $ref or bridegroom/@href = $ref]" />
        <xsl:sequence select="$wedding" />
    </xsl:function>

    <xsl:function name="jilm:getBirth">
        <xsl:param name="ref" />
        <xsl:variable name="birth"
                      select="$birthList//birth[born/@href = $ref]" />
        <xsl:sequence select="$birth" />
    </xsl:function>

    <xsl:function name="jilm:getDeath">
        <xsl:param name="ref" />
        <xsl:variable name="death"
                      select="$deathList//death[died/@href = $ref]" />
        <xsl:sequence select="$death" />
    </xsl:function>

    <xsl:function name="jilm:getPlace">
        <xsl:param name="ref" />
        <xsl:variable name="place"
                      select="$placeList//place[@id = $ref]" />
        <xsl:sequence select="$place" />
    </xsl:function>

    <xsl:function name="jilm:concat">
        <xsl:param name="arg1" />
        <xsl:param name="arg2" />
        <xsl:param name="delimiter" />
        <xsl:variable name="len1" 
                              select="string-length(normalize-space($arg1))" />
        <xsl:variable name="len2"
                              select="string-length(normalize-space($arg2))" />
        <xsl:choose>
            <xsl:when test="$len1 gt 0 and $len2 gt 0">
                <xsl:value-of select="concat($arg1, $delimiter, $arg2)" />
            </xsl:when>
            <xsl:when test="$len1 gt 0">
                <xsl:value-of select="$arg1" />
            </xsl:when>
            <xsl:when test="$len2 gt 0">
                <xsl:value-of select="$arg2" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''" />
            </xsl:otherwise>
        </xsl:choose>
    
    </xsl:function>

    <xsl:function name="jilm:analyze-date">
        <xsl:param name="date" />
        <xsl:variable name="uncertain"
                      select="contains($date, '?')"
                      as="xs:boolean" />
        <xsl:variable name="temp"
                      select="replace($date, '\?+', '')"
                      as="xs:string" />
        <xsl:variable name="tokenized"
                      select="reverse(tokenize($temp, '\.'))" />
        <xsl:variable name="year" select="$tokenized[1]" />
        <xsl:variable name="month" select="$tokenized[2]" />
        <xsl:variable name="day" select="$tokenized[3]" />
        <date>
            <xsl:if test="not(empty($year))">
                <year><xsl:value-of select="$year" /></year>
            </xsl:if>
            <xsl:if test="not(empty($month))">
                <month><xsl:value-of select="$month" /></month>
            </xsl:if>
            <xsl:if test="not(empty($day))">
                <day><xsl:value-of select="$day" /></day>
            </xsl:if>
        </date>
    </xsl:function>

</xsl:stylesheet>
