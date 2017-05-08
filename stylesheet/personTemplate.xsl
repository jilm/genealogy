<?xml version="1.0" encoding="utf-8"?>

<!--

    Select only person elements, together with the name.

-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--

        Keep the element person, but inside, elements must be in specific
        order. Moreover referenced information is resolved.

    -->
    <xsl:template match="person">
        <xsl:variable name="id" select="@id" />
        <person>
            <xsl:attribute name="id" select="$id" />
            <xsl:attribute name="sex" select="@sex" />
            <!-- person name -->
            <xsl:apply-templates select="name" />
        </person>
    </xsl:template>

    <!--

        Person name.

    -->
    <xsl:template match="name">
        <name>
            <xsl:apply-templates select="first" />
            <xsl:apply-templates select="second" />
        </name>
    </xsl:template>

    <xsl:template match="first">
        <first>
            <xsl:apply-templates />
        </first>
    </xsl:template>

    <xsl:template match="second">
        <second>
            <xsl:apply-templates />
        </second>
    </xsl:template>

</xsl:stylesheet>
