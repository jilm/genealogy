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


</xsl:stylesheet>