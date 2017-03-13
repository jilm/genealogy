<?xml version="1.0" encoding="utf-8"?>

<!--

      Takes a person list, it means the xml file that is valid
      according to the personList.rnc schema and generates a xml
      that is valid according to the personTree.rnc schema.
      In other words it substitute a full person description
      in place of the person reference. The highest level person
      definition or definitions will be persons that are not
      parents of any other person in the input list.

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
    <xsl:template match="person" priority="4">
        <xsl:variable name="id" select="@id" />
        <person>
            <xsl:attribute name="id" select="$id" />
            <xsl:attribute name="sex" select="@sex" />
            <xsl:apply-templates select="name" />
            <xsl:next-match />
        </person>
    </xsl:template>

    <!-- The birth is specified directly inside the person element -->
    <xsl:template match="person[birth]">
	    <birth>
            <xsl:apply-templates select="birth/date" />
            <xsl:apply-templates select="birth/place" />
        </birth>
        <xsl:apply-templates select="father" />
        <xsl:apply-templates select="mather" />
    </xsl:template>

	<!-- The birth is specified outside the person element. -->
	<xsl:template match="person[contains(./@id, //birth/born/@href)]">
        <xsl:variable name="ref" select="@id" />
        <xsl:variable name="birth" select="//birth/born[@href = $ref]" />
        <birth>
            <xsl:apply-templates select="$birth/date" />
            <xsl:apply-templates select="$birth/place" />
        </birth>
        <xsl:apply-templates select="$birth/father" />
        <xsl:apply-templates select="$birth/mather" />
	</xsl:template>
	
    <xsl:template match="person" mode="content" >
        <xsl:variable name="id" select="@id" />
            <xsl:apply-templates select="wedding" />
            <xsl:apply-templates select="death" />
            <xsl:apply-templates select="father" />
            <xsl:apply-templates select="mather" />
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
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </death>
    </xsl:template>

    <xsl:template match="father">
        <xsl:variable name="ref" select="@href" />
        <father>
            <xsl:apply-templates select="//person[@id = $ref]" mode="content"/>
        </father>
    </xsl:template>

    <xsl:template match="mather">
        <xsl:variable name="ref" select="@href" />
        <mather>
            <xsl:apply-templates select="//person[@id = $ref]" mode="content"/>
        </mather>
    </xsl:template>

</xsl:stylesheet>
