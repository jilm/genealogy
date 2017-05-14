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

    <xsl:template name="cite">
        <xsl:param name="event" />
        <cite>
            <xsl:attribute name="href" select="$event/../@id" />
            <xsl:apply-templates select="$event/page" />
        </cite>
    </xsl:template>

    <xsl:template match="matrika/page">
        <xsl:apply-templates select="page" />
        <xsl:apply-templates select="scan" />
    </xsl:template>

    <xsl:template match="page/page" >
        <page><xsl:apply-templates /></page>
    </xsl:template>

    <xsl:template match="scan">
        <scan><xsl:apply-templates /></scan>
    </xsl:template>

    <xsl:template match="date">
        <xsl:sequence select="jilm:analyze-date(text())" />
    </xsl:template>

<!--

     A place could be entered as a chain of place elements which reference
     each other. This stylesheet collects all of the parts into the one
     place element. In other words it substitute referenced information
     on place of the reference.

-->

    <xsl:template match="place[text() and not(@href)]" priority="5">
        <place ><parish><xsl:apply-templates /></parish></place>
    </xsl:template>

    <xsl:template match="place[@href and not(@house-nr)]" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="referenced"  select="jilm:getPlace($ref)" />
        <place>
            <xsl:apply-templates select="$referenced/region" />
            <xsl:apply-templates select="$referenced/district" />
            <xsl:apply-templates select="$referenced/parish" />
            <xsl:apply-templates select="$referenced/coordinates" />
        </place>
    </xsl:template>

    <xsl:template match="place[@href and @house-nr]" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="referenced"  select="jilm:getPlace($ref)" />
        <xsl:variable name="house-nr" select="@house-nr" />
        <place>
            <xsl:apply-templates select="$referenced/region" />
            <xsl:apply-templates select="$referenced/district" />
            <xsl:apply-templates select="$referenced/parish" />
            <house-nr><xsl:value-of select="$house-nr" /></house-nr>
            <xsl:apply-templates select="$referenced/coordinates" />
        </place>
    </xsl:template>

    <xsl:template match="place/note" />

    <xsl:template match="parish">
        <parish>
            <xsl:apply-templates />
        </parish>
    </xsl:template>

    <xsl:template match="region">
        <region>
            <xsl:apply-templates />
        </region>
    </xsl:template>

    <xsl:template match="district">
        <district>
            <xsl:apply-templates />
        </district>
    </xsl:template>

    <xsl:template match="house-nr">
        <house-nr><xsl:apply-templates /></house-nr>
    </xsl:template>

    <xsl:template match="coordinates">
        <coordinates>
            <xsl:apply-templates />
        </coordinates>
    </xsl:template>

    <xsl:template match="lon">
        <lon><xsl:apply-templates /></lon>
    </xsl:template>

    <xsl:template match="lat">
        <lat><xsl:apply-templates /></lat>
    </xsl:template>

</xsl:stylesheet>
