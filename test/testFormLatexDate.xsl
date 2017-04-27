<?xml version="1.0" ?>



<!--

  

-->



<xsl:stylesheet version="2.0"
  
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  
                xmlns:my="http://www.lidinsky.cz" >

  

  <xsl:import href="stylesheet/formLatexDate.xsl" />
  <xsl:import href="stylesheet/labels_CZ.xsl" />

  <xsl:output method="html" encoding="utf-8" />

  


  <xsl:template match="/">
    <html><body><table>
      <th><td>default</td><td>long</td><td>text</td><td>vmy</td></th>
      <xsl:apply-templates select="//test" />
    </table></body></html>
  </xsl:template>

  <xsl:template match="test">
        <tr>
          <td><em><xsl:value-of select="@label" /></em></td>
          <td>
            <xsl:apply-templates select="date"/>
          </td>
          <td>
            <xsl:apply-templates select="date" mode="long" />
          </td>
          <td>
            <xsl:apply-templates select="date" mode="text"/>
          </td>
          <td>
            <xsl:apply-templates select="date" mode="vmy"/>
          </td>
        </tr>
  </xsl:template>

</xsl:stylesheet>