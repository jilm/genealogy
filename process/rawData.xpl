<?xml version="1.0" encoding="utf-8"?>

<p:declare-step version="1.0" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jilm="http://www.lidinsky.cz"
    name="raw-data"
    type="jilm:raw-data-processing">

    <p:documentation>

        It takes files of the directory and concatenates content of all of
        the files into one raw xml data file.

    </p:documentation>

    <p:output port="result" primary="true" />

    <p:option name="src-dir" select="'../src/data'" />

    <!--

        Concatenate all of the xml files.

    -->

    <p:directory-list 
        name="raw-xml-data-filenames"
        include-filter=".*xml" >
        <p:with-option name="path" select="$src-dir" />
    </p:directory-list>

    <p:xslt name="raw-xml-data">
        <p:with-param name="path" select="$src-dir" />
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="2.0" >
                    <xsl:param name="path" />
                    <xsl:template match="/">
                        <list>
                            <xsl:apply-templates />
                        </list>
                    </xsl:template>
                    <xsl:template match="c:file">
                        <xsl:variable name="filename"
                     select="concat($path, '/', @name)" />
                        <xsl:copy-of
                            select="doc($filename)" />
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>

    <!--

        Parse text data.

    -->

    <p:directory-list 
        name="raw-text-data-filenames"
        include-filter=".*txt" >
        <p:with-option name="path" select="$src-dir" />
    </p:directory-list>

    <p:xslt name="raw-text-data">
        <p:input port="parameters"><p:empty /></p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="3.0" >
                    <xsl:import href="../stylesheet/parsePersonList.xsl" />
                    <xsl:template match="/" priority="10">
                        <list>
                            <xsl:apply-templates />
                        </list>
                    </xsl:template>
                    <xsl:template match="c:file">
                        <xsl:variable name="text" select="unparsed-text-lines(concat('../src/data/', @name))" />
                        <xsl:for-each select="$text">
                      <xsl:sequence select="jilm:parse(normalize-space(.))" />
                        </xsl:for-each>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>

    <!--

        Merge xml data together with the parsed text data.

    -->

    <p:pack wrapper="list">
        <p:input port="source">
            <p:pipe step="raw-xml-data" port="result" />
        </p:input>
        <p:input port="alternate">
            <p:pipe step="raw-text-data" port="result" />
        </p:input>
    </p:pack>

    <!--

        Get rid of unnecessary list elements.

    -->

    <p:unwrap match="*/list" />


</p:declare-step>
