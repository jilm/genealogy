<?xml version="1.0" ?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="utf-8" />

  <xsl:template match="/">
    <xsl:apply-templates select="//person" />
  </xsl:template>

  <xsl:template match="person">
    <!-- name of the person -->
    <xsl:variable name="name">
      <xsl:call-template name="concat-name">
        <xsl:with-param name="name-element" select="name" />
      </xsl:call-template>
    </xsl:variable>
    <!-- birth date -->
    <xsl:variable name="birth">
      <xsl:call-template name="concat-event">
        <xsl:with-param name="event-element" select="birth" />
        <xsl:with-param name="prefix" select="string(', *')" />
      </xsl:call-template>
    </xsl:variable>
    <!-- death -->
    <xsl:variable name="death">
      <xsl:call-template name="concat-event">
        <xsl:with-param name="event-element" select="death" />
        <xsl:with-param name="prefix" select="string(', +')" />
      </xsl:call-template>
    </xsl:variable>
    <!-- sum it up -->
    <xsl:choose>
      <xsl:when test="string-length($birth) > 0 or string-length($death) > 0">
        <xsl:value-of select="concat('\newcommand{\fn', @id, '}{\footnote{', concat($name, $birth, $death), '}\', @id, '{}}')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('\newcommand{\fn', @id, '}{\', @id, '{}}')" />
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  


  <!--
        Format events like birth, death or wedding
  -->
  <xsl:template name="concat-event">
    <xsl:param name="event-element" />
    <xsl:param name="prefix" />
    <xsl:variable name="date" select="$event-element/date/text()" />
    <xsl:variable name="place" select="$event-element/place/text()" />
    <xsl:choose>
      <xsl:when test="string-length($date) > 0 and string-length($place) = 0">
        <xsl:value-of select="concat($prefix, '~', $date)" />
      </xsl:when>
      <xsl:when test="string-length($date) = 0 and string-length($place) > 0">
        <xsl:value-of select="concat($prefix, '~', $place)" />
      </xsl:when>
      <xsl:when test="string-length($date) > 0 and string-length($place) > 0">
        <xsl:value-of select="concat($prefix, '~', $date, ' ', $place)" />
      </xsl:when>
      <xsl:otherwise><text></text></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="concat-name">
    <xsl:param name="name-element" />
    <xsl:variable name="first" select="$name-element/first" />
    <xsl:variable name="second" select="$name-element/second" />
    <xsl:variable name="married" select="$name-element/married" />
      <xsl:choose>
        <xsl:when test="string-length($married) > 0">
          <xsl:value-of select="string-join(($first, $married, 'rozená', $second), ' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="string-join(($first, $second), ' ')" />
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
