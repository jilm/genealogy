<?xml version="1.0" ?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="utf-8" />

  <xsl:variable name="index" select="doc('../index.xml')//index" />

  <xsl:template match="/html">
\documentclass[a4paper,11pt]{book}

\usepackage[czech]{babel}

\usepackage{xltxtra}
\usepackage{makeidx}
\usepackage[a4]{crop} 

\title{Ohlédnutí po předcích}

\author{}

\date{2014}

\makeindex

\begin{document}

\frontmatter

\maketitle

\tableofcontents

%Terezie
\newcommand{\wwii}{\index{Druhá světová válka}}

\input{index.tex}
\input{footnotes.tex}
\input{alias.tex}
    <xsl:apply-templates />
\backmatter

\printindex

\bibliography{src/sources}{}
\bibliographystyle{plain}

\end{document}
  </xsl:template>

  <xsl:template match="body">
      <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="head">
      <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="p">
      <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="h1">
    \chapter{<xsl:apply-templates />}
  </xsl:template>

  <xsl:template match="person">
    <xsl:variable name="ref" select="@href" />
    <xsl:apply-templates />
    <xsl:copy-of select="concat('\index{', $index[@id=$ref]/text(), '}')" />
  </xsl:template>

</xsl:stylesheet>
