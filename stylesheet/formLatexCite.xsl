<?xml version="1.0" encoding="utf-8"?>

<!--

    Transform a reference to the birth or deatch record book.

-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jilm="http://www.lidinsky.cz" >

  <xsl:template match="cite[@href]" >
    viz \cite[<xsl:apply-templates />]{<xsl:value-of select="@href" />}
  </xsl:template>

  <xsl:template match="page" >
    <xsl:value-of select="concat('str.: ', text())" />
  </xsl:template>

  <xsl:template match="scan" >
    <xsl:value-of select="concat('sken: ', text())" />
  </xsl:template>

</xsl:stylesheet>
