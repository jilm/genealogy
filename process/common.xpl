<?xml version="1.0" encoding="utf-8"?>

<p:library version="1.0" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jilm="http://www.lidinsky.cz">

    <p:documentation>


    </p:documentation>

    <p:declare-step type="jilm:transform" name="transform" >
        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />
        <p:option name="stylesheet" required="true" />

        <p:load name="stylesheet" >
            <p:with-option name="href" select="$stylesheet" />
        </p:load>

        <p:xslt>
            <p:input port="source">
                <p:pipe port="source" step="transform" />
            </p:input>
            <p:input port="stylesheet">
                <p:pipe port="result" step="stylesheet" />
            </p:input>
            <p:input port="parameters">
                <p:empty />
            </p:input>
        </p:xslt>
    </p:declare-step>

    <p:declare-step type="jilm:load-and-validate" name="load-and-validate">

        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />

        <p:xslt>
            <p:input port="source"><p:pipe step="load-and-validate" port="source" /></p:input>
            <p:input port="parameters"><p:empty/></p:input>
            <p:input port="stylesheet">
                <p:inline>
                    <xsl:stylesheet version="2.0">
                    <xsl:template match="c:file">
                        <xsl:sequence select="doc(concat('../src/data/', @name))" />
                    </xsl:template></xsl:stylesheet>
                </p:inline>
            </p:input>
        </p:xslt>

  <!--
        <p:validate-with-relax-ng>
            <p:input port="schema" >
                <p:data href="../schema/schema.rnc" />
            </p:input>
        </p:validate-with-relax-ng>
  -->
    </p:declare-step>



</p:library> 
