<?xml version="1.0" encoding="utf-8"?>

<p:library version="1.0" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:jilm="http://www.lidinsky.cz">

    <p:documentation>

        A library of steps that tranform raw data into the person, birth,
        death and wedding list.

    </p:documentation>

    <p:declare-step type="jilm:process-raw-data" name="process-raw-data" >
        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />
        <jilm:make-person-list name="person-list" >
            <p:input port="source">
                <p:pipe step="process-raw-data" port="source" />
            </p:input>
        </jilm:make-person-list>
        <jilm:make-birth-list name="birth-list" >
            <p:input port="source">
                <p:pipe step="process-raw-data" port="source" />
            </p:input>
        </jilm:make-birth-list>
        <jilm:make-death-list name="death-list" >
            <p:input port="source">
                <p:pipe step="process-raw-data" port="source" />
            </p:input>
        </jilm:make-death-list>
        <jilm:make-wedding-list name="wedding-list" >
            <p:input port="source">
                <p:pipe step="process-raw-data" port="source" />
            </p:input>
        </jilm:make-wedding-list>
        <p:pack wrapper="data">
            <p:input port="alternate">
                <p:pipe step="birth-list" port="result" />
            </p:input>
        </p:pack>
        <p:pack wrapper="data">
            <p:input port="alternate">
                <p:pipe step="death-list" port="result" />
            </p:input>
        </p:pack>
        <p:pack wrapper="data">
            <p:input port="alternate">
                <p:pipe step="person-list" port="result" />
            </p:input>
        </p:pack>
        <p:unwrap match="*/data" />
    </p:declare-step>

    <p:declare-step type="jilm:make-death-list" >

        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />

        <p:xslt>
            <p:input port="parameters"><p:empty /></p:input>
            <p:input port="stylesheet">
                <p:document href="../stylesheet/makeDeathList.xsl" />
            </p:input>
        </p:xslt>

        <p:rename match="list" new-name="death-list" />

    </p:declare-step>

    <p:declare-step type="jilm:make-birth-list" >

        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />

        <p:xslt>
            <p:input port="parameters"><p:empty /></p:input>
            <p:input port="stylesheet">
                <p:document href="../stylesheet/makeBirthList.xsl" />
            </p:input>
        </p:xslt>

        <p:rename match="list" new-name="birth-list" />

    </p:declare-step>

    <p:declare-step type="jilm:make-wedding-list" >

        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />

        <p:xslt>
            <p:input port="parameters"><p:empty /></p:input>
            <p:input port="stylesheet">
                <p:document href="../stylesheet/makeWeddingList.xsl" />
            </p:input>
        </p:xslt>

        <p:rename match="list" new-name="wedding-list" />

    </p:declare-step>

    <p:declare-step type="jilm:make-person-list" >

        <p:input port="source" primary="true" />
        <p:output port="result" primary="true" />

        <p:xslt>
            <p:input port="parameters"><p:empty /></p:input>
            <p:input port="stylesheet">
                <p:document href="../stylesheet/makePersonList.xsl" />
            </p:input>
        </p:xslt>

        <p:rename match="list" new-name="person-list" />

    </p:declare-step>

</p:library>
