<?xml version="1.0" ?>

<!--

  Takes a list of persons and generate genealogy genealogytree graph

-->

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:my="http://www.lidinsky.cz" >

  <xsl:output method="text" encoding="utf-8" />

  <xsl:template match="/">

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
    <xsl:apply-templates select="//person[1]" />
            }
          } 
        \end{tikzpicture}
        \end{document}
  </xsl:template>

  <!--
  
    Convert a person

  -->
  <xsl:template match="person[@sex='male']">
    g[male]{
      <xsl:apply-templates select="name" />
      }
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
  </xsl:template>

  <xsl:template match="person[@sex='female']">
    g[female]{
      <xsl:apply-templates select="name" />
      <xsl:apply-templates select="birth" />
      }
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
  </xsl:template>

  <xsl:template match="name">
    <xsl:apply-templates select="first" />
    <xsl:apply-templates select="second" />
  </xsl:template>

  <xsl:template match="first">
    \pref{<xsl:apply-templates />}
  </xsl:template>

  <xsl:template match="second">
    \surn{<xsl:apply-templates />}
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="my:escape(.)" />
  </xsl:template>

  <xsl:template match="birth[date and place]">
    \gtrsymBorn{}~
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="date">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="place">
    <xsl:apply-templates />
  </xsl:template>


  <!--
  
  -->
  <xsl:template match="mather">
    parent{
      g[male]{<xsl:apply-templates select="name" />}
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
    }
  </xsl:template>

  <xsl:template match="father">
    parent{
      g[female]{<xsl:apply-templates select="name" />}
      <xsl:apply-templates select="father" />
      <xsl:apply-templates select="mather" />
    }
  </xsl:template>

  <xsl:function name="my:escape" >
    <xsl:param name="text" />
    <xsl:variable name="tempC" select='replace($text, "Č", "\\v{C}")' />
    <xsl:variable name="tempD" select='replace($tempC, "Ď", "\\v{D}")' />
    <xsl:variable name="tempN" select='replace($tempD, "Ň", "\\v{N}")' />
    <xsl:variable name="tempR" select='replace($tempN, "Ř", "\\v{R}")' />
    <xsl:variable name="tempS" select='replace($tempR, "Š", "\\v{S}")' />
    <xsl:variable name="tempT" select='replace($tempS, "Ť", "\\v{T}")' />
    <xsl:variable name="tempZ" select='replace($tempT, "Ž", "\\v{Z}")' />
    <xsl:variable name="tempu" select='replace($tempZ, "ů", "\\r{u}")' />
    <xsl:variable name="tempz" select='replace($tempu, "ž", "\\v{z}")' />
    <xsl:variable name="tempc" select='replace($tempz, "č", "\\v{c}")' />
    <xsl:variable name="tempd" select='replace($tempc, "ď", "\\v{d}")' />
    <xsl:variable name="tempe" select='replace($tempd, "ě", "\\v{e}")' />
    <xsl:variable name="tempn" select='replace($tempe, "ň", "\\v{n}")' />
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
