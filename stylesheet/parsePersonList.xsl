<?xml version="1.0" encoding="utf-8" ?>

<!--

    Takes a list of persons in the form that follow and
    makes a person list in the xml.

-->

<xsl:stylesheet version="3.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xs="http://www.w3.org/2001/XMLSchema" 
      xmlns:jilm="http://www.lidinsky.cz" >

    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:variable name="text"
                  select="unparsed-text-lines('../src/data/persons.txt')" />
    <xsl:variable name="names"
                  select="doc('../build/names.xml')" />

    <xsl:template match="/">
        <list>
            <xsl:for-each select="$text">
                <xsl:sequence select="jilm:parse(normalize-space(.))" />
            </xsl:for-each>
        </list>
    </xsl:template>

    <!--

        Takes a string and returns xml representation.
        It recognize following:
        * Empty string, returns empty sequence
        * Comment string
        * Person definition

    -->
    <xsl:function name="jilm:parse">
        <xsl:param name="line" as="xs:string" />
        <xsl:variable name="tokens" select="tokenize($line)" />
        <xsl:sequence select="jilm:interpret($tokens)" />
    </xsl:function>

    <xsl:function name="jilm:interpret">
        <xsl:param name="tokens" as="xs:string*" />
        <xsl:choose>
            <xsl:when test="empty($tokens)" />
            <!-- person -->
            <xsl:when test="starts-with($tokens[1], '$')">
                <xsl:variable name="given-name" select="$tokens[2]" />
                <xsl:variable name="sex" select="$names//name[./text() eq $given-name]/@sex" />
                <person>
                    <xsl:attribute name="id" select="substring-after($tokens[1], '$')" />
                    <xsl:attribute name="sex" select="$sex" />
                    <name>
                        <first><xsl:value-of select="$tokens[2]" /></first>
                        <second><xsl:value-of select="$tokens[3]" /></second>
                    </name>
                    <xsl:sequence select="jilm:interpret(tail(tail(tail($tokens))))" />
                </person>
            </xsl:when>
            <!-- Birth -->
            <xsl:when test="starts-with($tokens[1], '*')">
                <birth>
                    <xsl:sequence select="jilm:interpretEvent(tail($tokens))" />
                </birth>
                <xsl:sequence select="jilm:interpret(jilm:findNext(tail($tokens)))" />
            </xsl:when>
            <!-- Death -->
            <xsl:when test="starts-with($tokens[1], '+')">
                <death>
                    <xsl:sequence select="jilm:interpretEvent(tail($tokens))" />
                </death>
            </xsl:when>
            <!-- comment -->
            <xsl:when test="starts-with($tokens[1], '#')">
            </xsl:when>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="jilm:interpretEvent" >
        <xsl:param name="tokens" as="xs:string*" />
        <xsl:choose>
            <xsl:when test="empty($tokens)" />
            <xsl:when test="matches($tokens[1], '\d{1,2}\.\d{1,2}\.[12]\d{3}')">
                <date><xsl:value-of select="$tokens[1]" /></date>
                <xsl:sequence select="jilm:interpretEvent(tail($tokens))" />
            </xsl:when>
            <xsl:when test="contains('*+#', $tokens[1])">
                <xsl:sequence select="jilm:interpret($tokens)" />
            </xsl:when>
            <xsl:otherwise>
                <place>
                    <xsl:value-of select="jilm:concatPlace($tokens)" />
                </place>
            </xsl:otherwise>
        </xsl:choose>    
    </xsl:function>

    <xsl:function name="jilm:concatPlace">
        <xsl:param name="tokens" as="xs:string*" />
        <xsl:choose>
            <xsl:when test="empty($tokens)" />
            <xsl:when test="contains('*+#', $tokens[1])" />
            <xsl:otherwise>
                <xsl:value-of select="concat($tokens[1], ' ', jilm:concatPlace(tail($tokens)))" />
            </xsl:otherwise>
        </xsl:choose>    
    </xsl:function>

    <xsl:function name="jilm:findNext">
        <xsl:param name="tokens" as="xs:string*" />
        <xsl:choose>
            <xsl:when test="empty($tokens)">
                <xsl:sequence select="$tokens" />
            </xsl:when>
            <xsl:when test="contains('*+#', $tokens[1])" >
                <xsl:sequence select="$tokens" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="jilm:findNext(tail($tokens))" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>
