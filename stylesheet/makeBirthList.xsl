<?xml version="1.0" encoding="utf-8"?>

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
    xmlns:jilm="http://www.lidinsky.cz">

    <xsl:import href="commonTemplates.xsl" />
    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <list> 
            <xsl:apply-templates select="//birth" />
        </list>
    </xsl:template>

    <xsl:template match="matrika/birth">
        <birth>
            <xsl:call-template name="cite">
                <xsl:with-param name="event" select="." />
            </xsl:call-template>
            <xsl:apply-templates select="born" />
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
            <xsl:apply-templates select="mather" />
            <xsl:apply-templates select="father" />
        </birth>
    </xsl:template>

    <xsl:template match="person/birth">
        <xsl:variable name="ref" select="../@id" />
        <birth>
            <born>
                <xsl:attribute name="href" select="$ref" />
            </born>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
            <xsl:apply-templates select="../mather" />
            <xsl:apply-templates select="../father" />
        </birth>
    </xsl:template>

    <xsl:template match="born" >
      <born>
        <xsl:attribute name="href" select="@href" />
      </born>
    </xsl:template>

    <xsl:template match="father">
        <father>
            <xsl:attribute name="href" select="@href" />
        </father>
    </xsl:template>

    <xsl:template match="mather">
        <mather>
            <xsl:attribute name="href" select="@href" />
        </mather>
    </xsl:template>

</xsl:stylesheet>
