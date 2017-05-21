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

    <xd:doc type="stylesheet">
    
    
    </xd:doc>

    <xsl:template match="date[interval]">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="interval[min and max]" priority="3">
        <xsl:value-of select="concat(min/year, '--', max/year)" />
    </xsl:template>

    <xsl:template match="interval[min]" priority="2">
        <xsl:value-of select="concat('&gt;', min/year)" />
    </xsl:template>
    
    <xsl:template match="interval[max]" priority="2">
        <xsl:value-of select="concat('&lt;', max/year)" />
    </xsl:template>

    <xsl:template match="date[day and month and year]" priority="5">
        <xsl:variable name="day" select="day" />
        <xsl:variable name="month" select="month" />
        <xsl:variable name="year" select="year" />
        <xsl:value-of select="concat($day, '.', $month, '.', $year)" />
    </xsl:template>

    <xsl:template match="date[year]" priority="4">
        <xsl:variable name="year" select="year" />
        <xsl:value-of select="$year" />
    </xsl:template>

    <xsl:template match="place[district and house-nr]" priority="3" >
        <xsl:value-of select="concat(parish/text(), ' ', house-nr/text(), ' okres ', district/text())" />
    </xsl:template>

    <xsl:template match="place[district]" priority="2" >
        <xsl:value-of select="concat(parish/text(), ' okres ', district/text())" />
    </xsl:template>

    <xsl:template match="place" priority="1">
        <xsl:value-of select="parish/text()" />
    </xsl:template>

    <!-- Birth -->

    <xsl:template match="birth[cite]" priority="3">
        <inline class="verified">
            <xsl:next-match />
        </inline>
    </xsl:template>

    <xsl:template match="birth[date and place]" priority="2">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat('* ', $date, ' ', $place)" />
    </xsl:template>

    <xsl:template match="birth[date]" priority="1">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat('* ', $date)" />
    </xsl:template>

    <xsl:template match="birth[place]" priority="1">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat('* ', $place)" />
    </xsl:template>

    <!-- Death -->

    <xsl:template match="death[cite]" priority="3">
        <inline class="verified">
            <xsl:next-match />
        </inline>
    </xsl:template>

    <xsl:template match="death[date and place]" priority="2">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat('+ ', $date, ' ', $place)" />
    </xsl:template>

    <xsl:template match="death[date]" priority="1">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat('+ ', $date)" />
    </xsl:template>

    <xsl:template match="death[place]" priority="1">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat('+ ', $place)" />
    </xsl:template>

    <!-- Wedding -->

    <xsl:template match="wedding[cite]" priority="3">
        <inline class="verified">
            <xsl:next-match />
        </inline>
    </xsl:template>

    <xsl:template match="wedding[date and place]" priority="2">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat('w ', $date, ' ', $place)" />
    </xsl:template>

    <xsl:template match="wedding[date]" priority="1">
        <xsl:variable name="date">
            <xsl:apply-templates select="date" />
        </xsl:variable>
        <xsl:value-of select="concat('w ', $date)" />
    </xsl:template>

    <xsl:template match="wedding[place]" priority="1">
        <xsl:variable name="place">
            <xsl:apply-templates select="place" />
        </xsl:variable>
        <xsl:value-of select="concat('w ', $place)" />
    </xsl:template>


</xsl:stylesheet>