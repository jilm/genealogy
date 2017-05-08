<p:declare-step version="1.0" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:jilm="http://www.lidinsky.cz"
    name="make-book">

    <p:import href="rawData.xpl" />
    <p:import href="rawDataProcessing.xpl" />

    <p:input port="source" />
    <p:output port="result" />

    <jilm:raw-data-processing name="raw-data" />

    <jilm:process-raw-data name="data" />

    <!--

        Connect data together with the book.

    -->

    <p:pack wrapper="book" >
        <p:input port="alternate" >
            <p:pipe port="source" step="make-book" />
        </p:input>
    </p:pack>


</p:declare-step>
