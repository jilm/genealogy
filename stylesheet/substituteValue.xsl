<?xml version="1.0" encoding="utf-8"?>

<!--

    A template which place a value instead of the [value] element.
    The value element has the following form:

    [value href="" key="" form="" /]

    where key may be one of the following:

    person
    person.name
    person.name.first
    person.name.second
    person.birth
    person.birth.place
    person.birth.date
    person.birth.date.year
    person.death
    person.death.place
    person.death.date
    person.death.date.year
    person.wedding
    person.wedding.place
    person.wedding.date
    index

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >


    <xsl:template match="value[@key = 'person.name']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person/name" />
    </xsl:template>

    <xsl:template match="value[@key = 'person.name.first']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person/name/first" />
    </xsl:template>

    <xsl:template match="value[@key = 'person.name.second']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person/name/second" />
    </xsl:template>

    <xsl:template match="value[@key = 'person']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <!--<xsl:variable name="birth" select="jilm:getBirth($ref)" />-->
        <xsl:apply-templates select="$person/name" />
    </xsl:template>

    <xsl:template match="value[@key = 'index']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:value-of select="concat($person/name/second/text(), '!', $person/name/first/text())" />
    </xsl:template>

    <xsl:template match="value[@key = 'person.wedding.date']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="wedding" select="jilm:getWedding($ref)" />
        <xsl:apply-templates select="$wedding/date" />
    </xsl:template>

<!--
    <xsl:template match="value[@key = 'person.birth.date']" priority="2">
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="birth" select="jilm.getBirth($ref)" />
        <xsl:variable name="date" select="$birth/date" />
        <xsl:value-of select="$date" />
    </xsl:template>
-->

    <xsl:template match="value" >
        <xsl:message >Unknown value</xsl:message>
    </xsl:template>

</xsl:stylesheet>
