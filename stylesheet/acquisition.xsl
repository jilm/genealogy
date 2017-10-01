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
    xmlns:xd="http://www.pnp-software.com/XSLTdoc" 
    xmlns:jilm="http://www.lidinsky.cz"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" >
  
    <xd:doc type="stylesheet">

        It takes all of the known information about one person.    
    
    </xd:doc>

    <xsl:function name="jilm:acquire">
        <xsl:param name="pid" as="xs:string" />

        <xsl:variable name="name" select="jilm:getPerson($pid)/name" />
        <xsl:variable name="birth" select="jilm:getBirth($pid)" />
        <xsl:variable name="death" select="jilm:getDeath($pid)" />
        <xsl:variable name="wedding" select="jilm:getWedding($pid)" />
        <!-- wedding date must be greater than the birth day -->
        <xsl:variable name="wedding-min-birth" select="birth/date/year" as="xs:integer?" />
        <xsl:variable name="wedding-max-death" select="death/date/year" as="xs:integer?" />

        <xsl:variable name="wedding-date">
            <xsl:choose>
                <xsl:when test="exists($wedding/date)">
                    <xsl:sequence select="$wedding/date" />
                </xsl:when>
                <xsl:otherwise>
                    <date>
                        <year><xsl:value-of select="concat($wedding-min-birth, '--', $wedding-max-death)" /></year>
                    </date>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

    </xsl:function>

    <xsl:function name="jilm:acquireWeddingDate">
        <xsl:param name="pid" as="xs:string" />

        <xsl:variable name="name" select="jilm:getPerson($pid)/name" />
        <xsl:variable name="birth" select="jilm:getBirth($pid)" />
        <xsl:variable name="death" select="jilm:getDeath($pid)" />
        <xsl:variable name="wedding" select="jilm:getWedding($pid)" />
        <!-- wedding date must be greater than the birth day -->
        <xsl:variable name="wedding-min-birth" select="$birth/date/year" as="xs:integer?" />
        <xsl:variable name="wedding-max-death" select="$death/date/year" as="xs:integer?" />

        <xsl:variable name="wedding-date">
            <xsl:choose>
                <xsl:when test="exists($wedding/date)">
                    <xsl:sequence select="$wedding/date" />
                </xsl:when>
                <xsl:otherwise>
                    <date>
                        <year><xsl:value-of select="concat($wedding-min-birth, '--', $wedding-max-death)" /></year>
                    </date>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:sequence select="$wedding-date" />
        <xsl:message select="$wedding-date" />
    
    </xsl:function>

</xsl:stylesheet>

