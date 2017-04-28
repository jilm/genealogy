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

    <xsl:param name="validate">none</xsl:param>

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xd:doc>
    
    
    </xd:doc>
    <xsl:template match="/">
        <project>

            <xsl:choose>
                <xsl:when test="$validate = 'jing'">
                    <taskdef name="jing"
                        classname="com.thaiopensource.relaxng.util.JingTask" />
                </xsl:when>
            </xsl:choose>

            <!-- Check data files validity, but only if the jing is
                     available. -->
            <target name="validate-data">
                <xsl:if test="$validate = 'jing'">
                    <jing rngfile="../schema/schema.rnc"
                        compactsyntax="true" >
                        <fileset dir="../src/data" includes="*.xml" />
                    </jing>
                </xsl:if>
            </target>

        </project>
    </xsl:template>

</xsl:stylesheet>

