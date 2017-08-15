<?xml version="1.0" encoding="utf-8"?>

<!--

    Transform the SOATrebon matrika list into the BibTex format.
  
    Result text document contains bibtex book references of the form:
  
          @BOOK{ [ID],
            author = "[příslušný farní úřad ...]",
            title = "[matrika ...]",
            year = "[minYear--maxYear]",
            publisher = "[soa Třeboň]"
        }
        
    ID is of the form: SOATREBON-[inventární číslo matriky]    

-->

<xsl:stylesheet version="2.0"

                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ev="http://www.mvcr.cz/archivy/evidence-nad/matriky"
                xmlns:my="http://www.lidinsky.cz" 
                
                >

    <xsl:output method="text" encoding="utf-8" />

    <xsl:template match="/">
        <xsl:variable name="matriky" select="//ev:matrika" />
        <xsl:variable name="inv" select="//ev:matrika/ev:oznaceniMatriky/ev:invCislo/text()" />
        <xsl:for-each select="distinct-values($inv)">
            <xsl:variable name="i" select="." />
            <xsl:apply-templates select="$matriky[ev:oznaceniMatriky/ev:invCislo/text() = $i][1]" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="ev:matrika">
    
        <!-- Matrika ID -->
        <xsl:variable name="id">
            <xsl:value-of select="concat('SOATREBON-', ev:oznaceniMatriky/ev:invCislo)" />
        </xsl:variable>
        
        <!-- Author -->
        <xsl:variable name="author">
            <xsl:apply-templates select="ev:idPuvodce" />
        </xsl:variable>
        
        <!-- Title -->
        <xsl:variable name="place">
            <xsl:apply-templates select="ev:uzemniRozsah" />
        </xsl:variable>
        <xsl:variable name="matrikaContent" select="ev:obsahMatriky[not(contains(@charakterObsahuMatriky, 'I'))]" />
        <xsl:variable name="indexContent" select="ev:obsahMatriky[contains(@charakterObsahuMatriky, 'I')]" />
        <xsl:variable name="content">
            <xsl:choose>
                <xsl:when test="empty($matrikaContent) and exists($indexContent)">
                    <xsl:value-of select="concat('Index ', my:joinList($indexContent))" />
                </xsl:when>
                <xsl:when test="exists($matrikaContent)">
                    <xsl:value-of select="concat('Matrika ', my:joinList($matrikaContent))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Bad content!</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="title">
            <xsl:value-of select="concat($content, ' v obci ', $place)" />
        </xsl:variable>

        <!-- Year -->
        <xsl:variable name="year">
            <xsl:apply-templates select="ev:casRozsah" />
        </xsl:variable>

        <!-- Publisher -->
        <xsl:variable name="publisher">
            <xsl:apply-templates select="ev:idMistaUlozeni" />
        </xsl:variable>

        @BOOK{<xsl:value-of select="$id" />,
            author = "<xsl:value-of select="$author" />",
            title = "<xsl:value-of select="$title" />",
            year = "<xsl:value-of select="$year" />",
            publisher = "<xsl:value-of select="$publisher" />"
        }

    </xsl:template>
    
    <xsl:template match="ev:idPuvodce">
        <xsl:variable name="ref" select="text()" />
        <xsl:apply-templates select="//ev:puvodce[@idPuvodce = $ref]/ev:nazevPuvodce" />
    </xsl:template>
    
    <xsl:template match="ev:idMistaUlozeni">
        <xsl:variable name="ref" select="text()" />
        <xsl:apply-templates select="//ev:mistoUlozeni[@idMistaUlozeni = $ref]/ev:nazevMistaUlozeni" />
    </xsl:template>
    
    <xsl:template match="ev:casRozsah">
        <xsl:value-of select="concat(ev:rokMin/text(), '--', ev:rokMax/text())" />
    </xsl:template>
    
    <xsl:template match="ev:obsahMatriky[@charakterObsahuMatriky = 'N']" priority="5">
        <xsl:value-of select="'narozených'" />
    </xsl:template>

    <xsl:template match="ev:obsahMatriky[@charakterObsahuMatriky = 'O']" priority="4">
        <xsl:value-of select="'oddaných'" />
    </xsl:template>

    <xsl:template match="ev:obsahMatriky[@charakterObsahuMatriky = 'Z']" priority="3">
        <xsl:value-of select="'zemřelých'" />
    </xsl:template>

    <xsl:template match="ev:obsahMatriky[@charakterObsahuMatriky = 'I-N']" priority="5">
        <xsl:value-of select="'narozených'" />
    </xsl:template>

    <xsl:template match="ev:obsahMatriky[@charakterObsahuMatriky = 'I-O']" priority="4">
        <xsl:value-of select="'oddaných'" />
    </xsl:template>

    <xsl:template match="ev:obsahMatriky[@charakterObsahuMatriky = 'I-Z']" priority="3">
        <xsl:value-of select="'zemřelých'" />
    </xsl:template>

    <xsl:template match="ev:obsahMatriky" priority="0" />
    
    <xsl:function name="my:joinList" as="xs:string">
        <xsl:param name="input" as="node()*" />
        <xsl:choose>
            <xsl:when test="count($input) = 1">
                <xsl:apply-templates select="$input[1]" />
            </xsl:when>
            <xsl:when test="empty($input)">
                <xsl:value-of select="''" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="pre">
                    <xsl:apply-templates select="$input[1]" />
                </xsl:variable>
                <xsl:value-of select="my:joinListRekursion(subsequence($input, 2), $pre)" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="my:joinListRekursion" as="xs:string">
        <xsl:param name="input" as="node()*" />
        <xsl:param name="pre" as="xs:string" />
        <xsl:choose>
            <xsl:when test="count($input) gt 1">
                <xsl:variable name="next">
                    <xsl:apply-templates select="$input[1]" />
                </xsl:variable>
                <xsl:variable name="joined" select="concat($pre, ', ', $next)" />
                <xsl:value-of select="my:joinListRekursion(subsequence($input, 2), $joined)" />
            </xsl:when>
            <xsl:when test="count($input) = 1">
                <xsl:variable name="next">
                    <xsl:apply-templates select="$input[1]" />
                </xsl:variable>
                <xsl:value-of select="concat($pre, ' a ', $next)" />
            </xsl:when>
            <xsl:when test="count($input) = 0">
                <xsl:value-of select="$pre" />
            </xsl:when>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>
