<?xml version="1.0" ?>



<!--

  

-->



<xsl:stylesheet version="2.0"
  
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  
                xmlns:my="http://www.lidinsky.cz" >

  

  <xsl:import href="../stylesheet/formLatexDate.xsl" />
  <xsl:import href="../stylesheet/formLatexCite.xsl" />
  <xsl:import href="../stylesheet/placeFormat.xsl" />
  <xsl:import href="../stylesheet/latex.xsl" />
  <xsl:import href="../stylesheet/formLatexBirth.xsl" />
  <xsl:import href="../stylesheet/labels_CZ.xsl" />

  <xsl:output method="html" encoding="utf-8" />

  <xsl:template match="/">
    <html>
      <head><meta charset="utf-8" /></head>
      <body><table>
      <th><td>default</td><td>text</td><td>cite</td><td>graph</td></th>
      <xsl:apply-templates select="//test" />
    </table></body></html>
  </xsl:template>

  <xsl:template match="test">
        <tr>
          <td><em><xsl:value-of select="@label" /></em></td>
          <td>
            <xsl:apply-templates select="birth"/>
          </td>
          <td>
            <xsl:apply-templates select="birth" mode="text" />
          </td>
          <td>
            <xsl:apply-templates select="birth" mode="cite"/>
          </td>
          <td>
            <xsl:apply-templates select="birth" mode="graph"/>
          </td>
        </tr>
  </xsl:template>

</xsl:stylesheet>
