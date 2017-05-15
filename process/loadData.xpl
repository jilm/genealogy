<?xml version="1.0" encoding="utf-8"?>

<p:declare-step version="1.0" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:jilm="http://www.lidinsky.cz"
    name="load-raw-data"
    type="jilm:raw-data-processing">

    <p:import href="common.xpl" />

    <p:documentation>

        It takes files of the directory and concatenates content of all of
        the files into one raw xml data file.

    </p:documentation>

    <p:output port="result" primary="true" />

    <!--

        Concatenate all of the xml files.

    -->

    <p:identity>
        <p:input port="source">
            <p:inline>
                <c:data content-type="text/plain">Hello, world!</c:data>
            </p:inline>
        </p:input>
            <p:log port="result" />
    </p:identity>

    <p:directory-list 
        name="raw-xml-data-filenames"
        include-filter=".*xml" >
        <p:with-option name="path" select="'../src/data'" />
    </p:directory-list>

    <p:viewport match="c:file">

        <jilm:load-and-validate />

    </p:viewport>

    <p:rename name="raw-data" match="c:directory" new-name="list" />

    <!-- Create a person list. -->

    <jilm:transform stylesheet="../stylesheet/makePersonList.xsl" />

    <p:validate-with-relax-ng assert-valid="false">
        <p:input port="schema" >
            <p:data href="../schema/personList.rnc" />
        </p:input>
    </p:validate-with-relax-ng>

    <p:sink />

    <!-- Create a wedding list. -->

    <p:xslt>
        <p:input port="source">
            <p:pipe step="raw-data" port="result" />
        </p:input>
        <p:input port="stylesheet" >
            <p:document href="../stylesheet/makeWeddingList.xsl" />
        </p:input>
        <p:input port="parameters" >
            <p:empty />
        </p:input>
    </p:xslt>

</p:declare-step> 
