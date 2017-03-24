<?xml version="1.0" ?>

<!--

  Takes a list of persons and generate genealogy genealogytree graph

-->

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:my="http://www.lidinsky.cz" >

  <xsl:import href="placeFormat.xsl" />

  <xsl:output method="text" encoding="utf-8" />

  <xsl:variable name="birth-symbol" select="'\gtrsymBorn{}'" />
  <xsl:variable name="death-symbol" select="'\gtrsymDied{}'" />
  <xsl:variable name="married-symbol" select="'\gtrsymMarried{}'" />
  <xsl:variable name="ver-birth-symbol"
                select="concat('\gtrSymbolsSetDraw{red}', $birth-symbol)" />
  <xsl:variable name="ver-death-symbol"
                select="concat('\gtrSymbolsSetDraw{red}', $death-symbol)" />
  <xsl:variable name="ver-married-symbol"
                select="concat('\gtrSymbolsSetDraw{red}', $married-symbol)" />

  <xsl:template match="/">
    <xsl:variable name="root-persons" select="//person" />
    <xsl:for-each select="//person" >
      <xsl:result-document href="{./@id}_tree.tex" method="text" >
    

\documentclass[]{a0poster} 
\usepackage[czech]{babel}
\usepackage[T1]{fontenc}
\usepackage[all]{genealogytree}
\pdfpagewidth 1783mm
\pdfpageheight 420mm
 
    \begin{document} 
    \section{Rodokmen} 

        \begin{tikzpicture}\genealogytree[template=signpost, level size=3cm, box={width=2cm, height=3cm}]{
            parent{
    <xsl:apply-templates select="." />
            }
          } 
        \end{tikzpicture}
        \end{document}
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

  <!--
  
    Convert a person

  -->
  <xsl:template match="person[@sex='male']" priority="2" >
    g[male]{
      <xsl:next-match />
      }
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
  </xsl:template>

  <xsl:template match="person[@sex='female']" priority="2" >
    g[female]{
      <xsl:next-match />
      }
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
  </xsl:template>

  <xsl:template match="person | mather | father">
      <xsl:apply-templates select="name" />
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="birth" />
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="death" />
  </xsl:template>

  <xsl:template match="name">
    <xsl:variable name="first">
      <xsl:apply-templates select="first" />
    </xsl:variable>
    <xsl:variable name="second">
      <xsl:apply-templates select="second" />
    </xsl:variable>
    <xsl:value-of select="concat($first, ' ', $second, ' ')" />
  </xsl:template>

  <xsl:template match="first">
    <xsl:variable name="first">
      <xsl:apply-templates />
    </xsl:variable>
    <xsl:value-of select="concat('\pref{', $first, '}')" />
  </xsl:template>

  <xsl:template match="second">
    <xsl:variable name="first">
      <xsl:apply-templates />
    </xsl:variable>
    <xsl:value-of select="concat('\surn{', $first, '}')" />
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="my:escape(.)" />
  </xsl:template>

  <xsl:template match="birth[date and place]">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(my:get-birth-symbol(.), '~', $date, ', ', $place)" />
  </xsl:template>

  <xsl:template match="death[date and place]">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(my:get-death-symbol(.), '~', $date, ', ', $place)" />
  </xsl:template>

  <xsl:template match="birth[date and not(place)]">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:value-of select="concat(my:get-birth-symbol(.), '~', $date)" />
  </xsl:template>

  <xsl:template match="death[date and not(place)]">
    <xsl:variable name="date">
      <xsl:apply-templates select="date" />
    </xsl:variable>
    <xsl:value-of select="concat(my:get-death-symbol(.), '~', $date)" />
  </xsl:template>

  <xsl:template match="birth[not(date) and place]">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(my:get-birth-symbol(.), '~', $place)" />
  </xsl:template>

  <xsl:template match="death[not(date) and place]">
    <xsl:variable name="place">
      <xsl:apply-templates select="place" />
    </xsl:variable>
    <xsl:value-of select="concat(my:get-death-symbol(.), '~', $place)" />
  </xsl:template>

  <xsl:template match="date">
    <xsl:apply-templates />
  </xsl:template>
  
  <!--
  
  -->
  <xsl:template match="mather" priority="2">
    parent{
      g[male]{<xsl:next-match />}
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
    }
  </xsl:template>

  <xsl:template match="father" priority="2">
    parent{
      g[female]{<xsl:next-match />}
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
    }
  </xsl:template>

  <xsl:function name="my:get-birth-symbol">
    <xsl:param name="birth-element" />
    <xsl:choose>
      <xsl:when test="$birth-element[@verified = 'true']">
        <xsl:value-of select="$ver-birth-symbol" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$birth-symbol" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="my:get-death-symbol">
    <xsl:param name="death-element" />
    <xsl:choose>
      <xsl:when test="$death-element[@verified = 'true']">
        <xsl:value-of select="$ver-death-symbol" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$death-symbol" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="my:escape" >
    <xsl:param name="text" />
    <xsl:variable name="tempC" select='replace($text, "Č", "\\v{C}")' />
    <xsl:variable name="tempD" select='replace($tempC, "Ď", "\\v{D}")' />
    <xsl:variable name="tempN" select='replace($tempD, "Ň", "\\v{N}")' />
    <xsl:variable name="tempR" select='replace($tempN, "�?", "\\v{R}")' />
    <xsl:variable name="tempS" select='replace($tempR, "Š", "\\v{S}")' />
    <xsl:variable name="tempT" select='replace($tempS, "Ť", "\\v{T}")' />
    <xsl:variable name="tempZ" select='replace($tempT, "Ž", "\\v{Z}")' />
    <xsl:variable name="tempu" select='replace($tempZ, "ů", "\\r{u}")' />
    <xsl:variable name="tempz" select='replace($tempu, "ž", "\\v{z}")' />
    <xsl:variable name="tempc" select='replace($tempz, "č", "\\v{c}")' />
    <xsl:variable name="tempd" select='replace($tempc, "ď", "\\v{d}")' />
    <xsl:variable name="tempe" select='replace($tempd, "ě", "\\v{e}")' />
    <xsl:variable name="tempn" select='replace($tempe, "�?", "\\v{n}")' />
    <xsl:variable name="tempr" select='replace($tempn, "ř", "\\v{r}")' />
    <xsl:variable name="temps" select='replace($tempr, "š", "\\v{s}")' />
    <xsl:variable name="tempt" select='replace($temps, "ť", "\\v{t}")' />
    <xsl:variable name="tempa" select='replace($tempt, "á", "\\&apos;{a}")' />
    <xsl:variable name="tempee" select='replace($tempa, "é", "\\&apos;{e}")' />
    <xsl:variable name="tempi" select='replace($tempee, "í", "\\&apos;{i}")' />
    <xsl:variable name="tempy" select='replace($tempi, "ý", "\\&apos;{y}")' />
    <xsl:value-of select="$tempy" />
  </xsl:function>

</xsl:stylesheet>
