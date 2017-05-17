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
    xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:import href="formHTMLCommonTemplates.xsl" />
    <xsl:import href="functions.xsl" />

    <xd:doc type="stylesheet">
    
    
    </xd:doc>

    <xsl:output method="html" encoding="utf-8" />

    <xsl:template match="/">
        <html>
            <head><link rel="stylesheet" href="list.css" /></head>
            <body>
                <table>
                    <xsl:apply-templates select="//person" >
                        <xsl:sort select="concat(name/second, ' ', name/first)" />
                    </xsl:apply-templates>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="person">
        <xsl:variable name="pid" select="@id" />
        <xsl:variable name="birth" select="jilm:getBirth($pid)" />
        <xsl:variable name="death" select="jilm:getDeath($pid)" />
        <xsl:variable name="wedding" select="jilm:getWedding($pid)" />
        <tr>
            <td><xsl:apply-templates select="name/first" /></td>
            <td><xsl:apply-templates select="name/second" /></td>
            <td><xsl:apply-templates select="$birth" /></td>
            <td><xsl:apply-templates select="$death" /></td>
            <td><xsl:apply-templates select="$wedding" /></td>
        </tr>
    </xsl:template>


</xsl:stylesheet>