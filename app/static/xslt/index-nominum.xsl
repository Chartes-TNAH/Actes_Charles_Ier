<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <!-- STRUCTURATION GLOBALE -->
    <xsl:template match="/">
        <xsl:call-template name="noms"/>
    </xsl:template>
    <!-- STRUCTURE DE L'INDEX -->
    <xsl:template name="noms">
        <!-- <div> globale avec trois colonnes -->
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>index-section-main</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="style">
                <xsl:text>column-count: 3; margin-top: 3%;</xsl:text>
            </xsl:attribute>
            <!-- boucle sur chaque élément <persName> descedant de <listPerson> -->
            <xsl:for-each select="//listPerson//persName">
                <!-- tri alphabétique -->
                <xsl:sort select="surname" order="ascending"/>
                <!-- <p> pour chaque entrée d'index -->
                <xsl:element name="p">
                    <!-- intitulé de l'entrée d'index en bold -->
                    <xsl:element name="b">
                        <!-- contenu de l'élément <surname> (nom de famille) -->
                        <xsl:value-of select="surname"/>
                        <!-- suivi d'une virgule et du contenu de <forename> (prénom) -->
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="forename"/>
                        <!-- s'il y a une particule (<nameLink), elle est affichée entre paranthèse -->
                        <xsl:if test="nameLink">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="nameLink"/>
                            <!-- s'il y a un surnom (<addName>), il suit par particule -->
                            <xsl:if test="addName">
                                <xsl:text>, dit </xsl:text>
                                <xsl:value-of select="addName"/>
                            </xsl:if>
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </xsl:element>
                    <xsl:variable name="idPerson">
                        <!-- variable $idPerson contenant la valeur de l'@xml:id de <person> -->
                        <xsl:value-of select="parent::person/@xml:id"/>
                    </xsl:variable>
                    <xsl:text> : </xsl:text>
                    <xsl:for-each select="ancestor::TEI//body//persName[translate(@ref, '#','')=$idPerson]">
                        <!-- pour chaque occurence du nom (<persName> dans le <body> dont @ref sans le '#' est équivalent à $idPerson) -->
                        <xsl:element name="a">
                            <!-- est affichée le numéro de l'acte cocnerné (@n de <text>) -->
                            <!-- le numéro est un lien vers l'acte -->
                            <xsl:attribute name="href">
                                <xsl:text>/actes/</xsl:text><xsl:value-of select="ancestor::text/@n"/>
                            </xsl:attribute>
                            <xsl:value-of select="ancestor::text/@n"/>
                        </xsl:element>
                        <!-- occurence suivie par une virgule si elle n'est pas la dernière, par un point si elle l'est -->
                        <xsl:if test="position()!= last()">, </xsl:if>
                        <xsl:if test="position() = last()">.</xsl:if>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>