<?xml version="1.0" encoding="utf-8"?>

<!--

     A place could be entered as a chain of place elements which reference
     each other. This stylesheet collects all of the parts into the one
     place element. In other words it substitute referenced information
     on place of the reference.

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="place[text() and not(@href)]" priority="5">
        <place ><parish><xsl:apply-templates /></parish></place>
    </xsl:template>

    <xsl:template match="place[@href and not(@house-nr)]" >
        <xsl:variable name="ref" select="@href" />
        <place>
            <xsl:apply-templates select="jilm:getPlace($ref)/*" />
        </place>
    </xsl:template>

    <xsl:template match="place[@href and @house-nr]" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="house-nr" select="@house-nr" />
        <place>
            <house-nr><xsl:value-of select="$house-nr" /></house-nr>
            <xsl:apply-templates select="jilm:getPlace($ref)/*" />
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

</xsl:stylesheet>
