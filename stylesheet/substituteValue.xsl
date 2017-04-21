<?xml version="1.0" encoding="utf-8"?>

<!--

    A template which place a value instead of the [value] element.
    The value element has the following form:

    [value href="" key="" form="" /]

    where key may be one of the following:

    person
    person.name
    person.name.first
    person.name.second
    person.birth
    person.birth.place
    person.birth.date
    person.birth.date.year
    person.death
    person.death.place
    person.death.date
    person.death.date.year
    person.wedding
    person.wedding.place
    person.wedding.date
    index

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >


    <xsl:template match="value[@key = 'person.name']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person/name" />
    </xsl:template>

    <xsl:template match="value[@key = 'person.name.first']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person/name/first" />
    </xsl:template>

    <xsl:template match="value[@key = 'person.name.second']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person/name/second" />
    </xsl:template>

    <xsl:template match="value[@key = 'person']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:apply-templates select="$person" mode="text" />
        <!--<xsl:variable name="birth" select="jilm:getBirth($ref)" />
        <xsl:variable name="name">
            <xsl:apply-templates select="$person/name" />
        </xsl:variable>
        <xsl:variable name="birth" select="jilm:getBirth($ref)" />
        <xsl:variable name="form-birth">
            <xsl:apply-templates select="$birth" />
        </xsl:variable>
        <xsl:value-of select="concat($name, ', ', $form-birth)" />-->
    </xsl:template>

    <xsl:template match="value[@key = 'index']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
        <xsl:value-of select="concat($person/name/second/text(), '!', $person/name/first/text())" />
    </xsl:template>

    <xsl:template match="value[@key = 'person.wedding.date']" priority="2" >
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="wedding" select="jilm:getWedding($ref)" />
        {\color{red}<xsl:apply-templates select="$wedding/date" mode="vmy" />}
    </xsl:template>

    <xsl:template match="value[@key = 'person-list']">
        <xsl:for-each select="$personList//person"  >
            <xsl:sort select="./name/second" />
            <xsl:apply-templates select="." mode="list" />\\
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="value[@key = 'graph']">
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="person" select="jilm:getPerson($ref)" />
\eject \pdfpagewidth=1783mm \pdfpageheight=420mm
\begin{tikzpicture}\genealogytree[template=signpost, level size=3cm, box={width=2cm, height=3cm}, label options={fill=white,node font=\footnotesize,inner sep=0.5mm,draw=green!30!black}]{
    parent{
        <xsl:apply-templates select="$person" mode="graph" />
    }
  }
\end{tikzpicture}
\eject \pdfpagewidth=210mm \pdfpageheight=297mm
    </xsl:template>

<!--
    <xsl:template match="value[@key = 'person.birth.date']" priority="2">
        <xsl:variable name="ref" select="@href" />
        <xsl:variable name="birth" select="jilm.getBirth($ref)" />
        <xsl:variable name="date" select="$birth/date" />
        <xsl:value-of select="$date" />
    </xsl:template>
-->

    <xsl:template match="value" >
        <xsl:message >Unknown value</xsl:message>
    </xsl:template>

</xsl:stylesheet>
