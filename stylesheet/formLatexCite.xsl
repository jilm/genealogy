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
    str.: <xsl:value-of select="text()" />
  </xsl:template>

  <xsl:template match="scan" >
    sken: <xsl:value-of select="text()" />
  </xsl:template>

</xsl:stylesheet>
