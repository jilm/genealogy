<?xml version="1.0" encoding="utf-8"?>

<!--


-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="http://www.lidinsky.cz" >

    <xsl:variable name="BIRTH-SYMBOL" select="'$\star$'" />
    <xsl:variable name="DEATH-SYMBOL" select="'$\dagger$'" />
  <xsl:variable name="birth-symbol" select="'\gtrsymBorn{}'" />
  <xsl:variable name="death-symbol" select="'\gtrsymDied{}'" />
  <xsl:variable name="married-symbol" select="'\gtrsymMarried{}'" />
  <xsl:variable name="ver-birth-symbol"
                select="concat('\gtrSymbolsSetDraw{red}', $birth-symbol)" />
  <xsl:variable name="ver-death-symbol"
                select="concat('\gtrSymbolsSetDraw{red}', $death-symbol)" />
  <xsl:variable name="ver-married-symbol"
                select="concat('\gtrSymbolsSetDraw{red}', $married-symbol)" />

    <xsl:variable name="DOCUMENT-HEAD">
\documentclass{article}
\usepackage[czech]{babel}
\usepackage[utf8]{inputenc}

\begin{document}
    </xsl:variable>

    <xsl:variable name="DOCUMENT-TAIL">
\end{document}
    </xsl:variable>
    

</xsl:stylesheet>
