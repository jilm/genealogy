<?xml version="1.0" encoding="utf-8" ?>

<!--

    Copyright 2017 Jiri Lidinsky

    This file is part of Genealogy project.

    Genealogy is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Genealogy is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Genealogy. If not, see http://www.gnu.org/licenses/.

-->

<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc" >

    <xsl:import href="substituteValue.xsl" />
    <xsl:import href="nameFormat.xsl" />
    <xsl:import href="latex.xsl" />
    <xsl:import href="formLatexBirth.xsl" />
    <xsl:import href="formLatexDeath.xsl" />
    <xsl:import href="functions.xsl" />
    <xsl:import href="formLatexDate.xsl" />
    <xsl:import href="formLatexPerson.xsl" />
    <xsl:import href="formLatexCite.xsl" />
    <xsl:import href="labels_CZ.xsl" />
    <xsl:import href="placeFormat.xsl" />
    <xsl:import href="formLatexMap.xsl" />
  
    <xd:doc type="stylesheet">
    
        Generates the latex source for the book. Following files are
        necessary, before this stylesheet may be used:
        personList.xml, birthList.xml, deathList.xml, weddingList.xml. 
    
    </xd:doc>

    <xsl:output method="text" encoding="utf-8" />

    <xd:doc>The title of the book.</xd:doc>
    <xsl:param name="title" />
    <xsl:variable name="index" select="doc('../build/index.xml')" />

    <xd:doc>
    
        Generates Latex book preambule.
    
    </xd:doc>
    <xsl:template match="/">

\documentclass[a4paper,11pt]{book}

\usepackage[czech]{babel}

\usepackage{xltxtra}
\usepackage{makeidx}
\usepackage[all]{genealogytree}
\usepackage[a4]{crop} 
\usepackage{color}

\title{<xsl:value-of select="/html/head/title/text()" />}
\author{}
\date{2014}

\makeindex

\begin{document}

\frontmatter

\maketitle

\tableofcontents

<xsl:apply-templates select="/html/body/chapter/*[../h1/text() = 'Úvod']" />

\mainmatter

<xsl:apply-templates select="/html/body/chapter/*[../h1/text() != 'Úvod']"/>

\appendix

<xsl:apply-templates select="/html/body/appendix/*"/>

\backmatter

\printindex

\bibliography{sources}{}
\bibliographystyle{plain}

\end{document}
  </xsl:template>



    <xd:doc>
  
        Just apply templates.      
  
    </xd:doc>
    <xsl:template match="body">
        <xsl:apply-templates />
    </xsl:template>

    <xd:doc>
  
        Just apply templates.      
  
    </xd:doc>
    <xsl:template match="head">
        <xsl:apply-templates />
    </xsl:template>

    <xd:doc>
  
        Transform a paragraph of text into the form of latex paragraph.
        It means, that a continuos block of text is created, and at the
        end the \par command is placed. This template also makes some
        substitution. Three dots are substitute by the \ldots command
        etc.      
  
    </xd:doc>
    <xsl:template match="p">
      <xsl:variable name="para">
          <xsl:apply-templates />
      </xsl:variable>
      <xsl:variable name="temp"
           select="replace($para, '\s+\\footnote', '\\footnote')" />
      <xsl:variable name="temp2"
           select="replace($temp, '\.{3}', '\\ldots{}')" />
      <xsl:variable name="temp3"
           select="replace($temp2, '\s+\.', '.')" />
      <xsl:variable name="temp4"
           select="replace($temp3, '\s+,', ',')" />
      <xsl:value-of select="normalize-space($temp4)"/>\par
    </xsl:template>

    <xd:doc>

        Transform the header of the chapter. It simply wraps a text content
        into the chapter command.  
  
    </xd:doc>
    <xsl:template match="h1">
        \chapter{<xsl:apply-templates />}
    </xsl:template>

    <xd:doc>

        A person, which is talked about at the place marked by the person
        element is placed into the index at the end of the book together
        with the proper page number.
  
    </xd:doc>
    <xsl:template match="person[@href]">
        <xsl:variable name="ref" select="@href" />
        <xsl:apply-templates />
        <xsl:value-of select="concat('\index{', $index//index-item[@id=$ref]/text(), '}')" />
    </xsl:template>

    <xd:doc>

        Makes a footnote.
        
    </xd:doc>
    <xsl:template match="footnote">
        \footnote{<xsl:apply-templates />}
    </xsl:template>

    <xd:doc>

        Place a word into the book index.
        
    </xd:doc>
    <xsl:template match="index">
        <xsl:apply-templates />\index{<xsl:value-of select="@item" />}
    </xsl:template>

</xsl:stylesheet>

