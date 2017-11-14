<?xml version="1.0" encoding="utf-8" ?>

<!--

    Potřebuji stylesheet, který ke každé osobě doplní manzela, manzelku

-->

<xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!--
    
        Výstupem je prostě seznam osob.

    -->
    <xsl:template match="/" priority="10">
        <list>
            <xsl:apply-templates select="//person" />
        </list>
    </xsl:template>

    <xsl:template match="person" priority="10">
        <xsl:variable name="pid" select="@id" />
        <xsl:variable name="weddings" select="//wedding[man/@href = $pid]/wife | //person[wife/@href = $pid]/man" />
        <person>
            <xsl:apply-templates select="@*|node()"/>
            <xsl:apply-templates select="$weddings" />
        </person>
    </xsl:template>


</xsl:stylesheet>
