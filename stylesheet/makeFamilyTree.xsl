<?xml version="1.0" encoding="utf-8"?>

<!--

    Wrap parents together with children 

-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="placeTemplate.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element and select only persons that are not parents.

    -->
    <xsl:template match="/">

	<xsl:variable name="parents">
            <xsl:value-of select="//mather/@href" />
            <xsl:value-of select="//father/@href" />
        </xsl:variable>

        <list> 
            <xsl:apply-templates
                           select="//person[not(contains($parents, @id))]" />
        </list>

    </xsl:template>

    <!--

        Keep the element person, but inside, elements must be in specific
        order. Moreover referenced information is resolved.

    -->
    <xsl:template match="person">
        <xsl:variable name="id" select="@id" />
        <xsl:variable name="father-ref" select="father/@href" />
        <xsl:variable name="mather-ref" select="mather/@href" />
        <family>
          <person>
            <xsl:attribute name="id" select="$id" />
            <xsl:attribute name="sex" select="@sex" />
	    <xsl:apply-templates select="name" />
	    <xsl:apply-templates select="birth" />
	    <xsl:apply-templates select="death" />
          </person>
          <xsl:apply-templates select="//person[@id = $father-ref]" />
          <xsl:apply-templates select="//person[@id = $mather-ref]" />
          <xsl:apply-templates select="//wedding[bride/@href = $mather-ref and bridegroom/@href = $father-ref]" />
        </family>
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

    <xsl:template match="birth">
        <birth>
            <xsl:attribute name="verified" select="@verified" />
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </birth>
    </xsl:template>

    <xsl:template match="date">
        <date>
            <xsl:apply-templates />
        </date>
    </xsl:template>
    
    <xsl:template match="wedding">
        <wedding>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </wedding>
    </xsl:template>

    <xsl:template match="death">
        <death>
            <xsl:attribute name="verified" select="@verified" />
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </death>
    </xsl:template>

</xsl:stylesheet>
