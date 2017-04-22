<?xml version="1.0" ?>



<!--

  Takes a list of persons and generate text form


-->



<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >

    <xsl:import href="formTextDate.xsl" />
    <xsl:import href="formTextPlace.xsl" />
    <xsl:import href="labels_CZ.xsl" />

  <xsl:output method="text" encoding="CP852" />

  <xsl:variable name="CR" select="codepoints-to-string((13))" />
  <xsl:variable name="LF" select="codepoints-to-string((10))" />
  <xsl:variable name="NL" select="concat($CR, $LF)" />

  <xsl:template match="/">
    <xsl:apply-templates select="//person">
      <xsl:sort select="@id" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="name">
    <xsl:value-of select="concat(second, ' ', first)" />
  </xsl:template>

    <xsl:template match="birth[date and place]">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat(' * ', $date, ', ', $place)" />
    </xsl:template>

  <xsl:template match="birth[date and not(place)]">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
    <xsl:value-of select="concat(' * ', $date)" />
  </xsl:template>

    <xsl:template match="birth[not(date) and normalize-space(place)]">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat(' * ', $place)" />
    </xsl:template>

    <xsl:template match="death[date and place]">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat(' + ', $date, ', ', $place)" />
    </xsl:template>

    <xsl:template match="death[date and not(place)]">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat(' + ', $date)" />
    </xsl:template>

    <xsl:template match="death[not(date) and place]">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat(' + ', $place)" />
    </xsl:template>

  <xsl:template match="father[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat($NL, '  Otec: ', $father-name)" />
  </xsl:template>

  <xsl:template match="mather[@href]">
    <xsl:variable name="id" select="@href" />
    <xsl:variable name="father-name" >
      <xsl:apply-templates select="//person[@id = $id]/name" />
    </xsl:variable>
    <xsl:value-of select="concat($NL, '  Matka: ', $father-name)" />
  </xsl:template>

    <xsl:template match="person">
        <xsl:variable name="name">
            <xsl:apply-templates select="name" />
        </xsl:variable>
        <xsl:variable name="birth">
            <xsl:apply-templates select="birth" />
        </xsl:variable>
        <xsl:variable name="death">
            <xsl:apply-templates select="death" />
        </xsl:variable>
        <xsl:value-of select="string-join(($name, $birth, $death), ' ')" />
        <xsl:value-of select="codepoints-to-string((13, 10))" />
    </xsl:template>

  <xsl:template match="text()" />

</xsl:stylesheet>
