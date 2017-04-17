<?xml version="1.0" encoding="utf-8"?>

<!--

    Substitute birth and death event directly into the person elements.
    Result XML document should contain only person and wedding elements.

-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="placeTemplate.xsl" />
    <xsl:import href="dateTemplate.xsl" />
    <xsl:import href="functions.xsl" />

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!--

        keep the root element

    -->
    <xsl:template match="/">
        <list> 
            <xsl:apply-templates select="//person" />
            <xsl:apply-templates select="//wedding" />
        </list>
    </xsl:template>

    <!--

        Keep the element person, but inside, elements must be in specific
        order. Moreover referenced information is resolved.

    -->
    <xsl:template match="person">
        <xsl:variable name="id" select="@id" />
        <person>
            <xsl:attribute name="id" select="$id" />
            <xsl:attribute name="sex" select="@sex" />
            <xsl:variable name="birth_verified"
                          select="//birth[born[@href = $id]]" />
            <xsl:variable name="birth" select="birth" />
            <!-- person name -->
            <xsl:apply-templates select="name" />
            <!-- birth details -->
            <xsl:choose>
                <xsl:when test="not(empty($birth_verified))">
                    <!-- get source -->
                    <xsl:variable name="source"
                         select="//matrika[contains(birth, $birth_verified)]" />
                    <xsl:variable name="scan"
                         select="$birth_verified/page/scan" />
                    <birth verified="true">
                        <xsl:attribute name="cite" select="$source/@id" />
                        <xsl:attribute name="scan" select="$scan" />
                        <xsl:apply-templates select="$birth_verified/date" />
                        <xsl:apply-templates select="$birth_verified/place" />
                    </birth>
                    <xsl:apply-templates select="$birth_verified/father" />
                    <xsl:apply-templates select="$birth_verified/mather" />
                </xsl:when>
                <xsl:when test="not(empty($birth))" >
                    <birth verified="false">
                        <xsl:apply-templates select="$birth/date" />
                        <xsl:apply-templates select="$birth/place" />
                    </birth>
                    <xsl:apply-templates select="father" />
                    <xsl:apply-templates select="mather" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="father" />
                    <xsl:apply-templates select="mather" />
                </xsl:otherwise>
            </xsl:choose>
            <!--<xsl:apply-templates select="wedding" />-->
            <xsl:apply-templates select="death" />
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

    <xsl:template match="birth">
        <birth>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </birth>
    </xsl:template>

    <xsl:template match="wedding">
        <wedding>
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
            <xsl:apply-templates select="bride" />
            <xsl:apply-templates select="bridegroom" />
        </wedding>
    </xsl:template>

    <xsl:template match="bride" >
      <bride>
        <xsl:attribute name="href" select="@href" />
      </bride>
    </xsl:template>

    <xsl:template match="bridegroom" >
      <bridegroom>
        <xsl:attribute name="href" select="@href" />
      </bridegroom>
    </xsl:template>

    <xsl:template match="death">
        <death verified="false" >
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="place" />
        </death>
    </xsl:template>

    <xsl:template match="father">
        <father>
            <xsl:attribute name="href" select="@href" />
        </father>
    </xsl:template>

    <xsl:template match="mather">
        <mather>
            <xsl:attribute name="href" select="@href" />
        </mather>
    </xsl:template>

</xsl:stylesheet>
