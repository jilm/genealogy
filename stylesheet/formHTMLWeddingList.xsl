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

    <xsl:import href="formHTMLCommonTemplates.xsl" />

    <xd:doc type="stylesheet">
    
    
    </xd:doc>

    <xsl:output method="html" encoding="utf-8" />

    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <table>
                    <xsl:apply-templates select="//wedding" />
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="wedding">
        <tr>
            <td><xsl:apply-templates select="date" /></td>
            <td><xsl:apply-templates select="place" /></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>