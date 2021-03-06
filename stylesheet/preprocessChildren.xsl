<?xml version="1.0" encoding="utf-8" ?>

<!--

    Potřebuji stylesheet, který ke každé osobě doplní její děti.

-->

<xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="@*|node()" priority="0">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!--
    
        Výstupem je prostě seznam osob.

    -->
    <xsl:template match="/" priority="10">
        <list>
            <xsl:apply-templates select="//person | //wedding" />
        </list>
    </xsl:template>

    <xsl:template match="person" priority="10">
        <xsl:variable name="pid" select="@id" />
        <xsl:variable name="children" select="//person[birth/father/@href = $pid] | //person[birth/mather/@href = $pid]" />
        <person>
            <xsl:apply-templates select="@*|node()"/>
            <xsl:for-each select="$children">
                <child>
                    <xsl:attribute name="href" select="./@id" />
                </child>
            </xsl:for-each>
        </person>
    </xsl:template>


</xsl:stylesheet>
