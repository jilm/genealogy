<?xml version="1.0" encoding="utf-8"?>

<!--

    Language dependent labels and messages.

-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >

    <xsl:variable name="FATHER-LABEL" select="'otec'" />

    <xsl:variable name="MATHER-LABEL" select="'matka'" />

    <xsl:variable name="MONTH-LABELS-FULL"
                  select="('leden', 'únor', 'březen', 'duben', 'květen', 'červen', 'červenec', 'srpen', 'září', 'říjen', 'listopad', 'prosinec')" />

    <xsl:variable name="MONTH-LABELS-FULL-V"
                  select="('lednu', 'únoru', 'březnu', 'dubnu', 'květnu', 'červnu', 'červenci', 'srpnu', 'září', 'říjnu', 'listopadu', 'prosinci')" />

</xsl:stylesheet>
