<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <!-- STRUCTURATION GLOBALE -->
    <xsl:template match="/">
        <!-- appel de la template places -->
        <xsl:call-template name="places"/>
    </xsl:template>
    <!-- STRUCTURE DE L'INDEX -->
    <xsl:template name="places">
        <!-- <div> globale avec trois colonnes -->
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>index-section-main</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="style">
                <xsl:text>column-count: 3; margin-top: 3%;</xsl:text>
            </xsl:attribute>
            <!-- boucle sur chaque élément <name> descedant de <place> -->
            <xsl:for-each select="//place//name[@xml:lang='fr']">
                <!-- tri alphabétique -->
                <xsl:sort select="." order="ascending"/>
                <!-- <p> pour chaque entrée d'index -->
                <xsl:element name="p">
                    <!-- intitulé de l'entrée d'index en bold -->
                    <xsl:element name="b">
                        <!-- contenu de l'élément <name xml:lang='fr'> -->
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <!-- entre parathèse, contenu de l'élément <desc> (le département, le pays, etc) -->
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="ancestor::place/desc"/>
                    <xsl:text>)</xsl:text>
                    <xsl:variable name="Placeid">
                        <!-- variable $Placeid contenant la valeur de l'@xml:id de <place> dans le <settingDesc> -->
                        <xsl:value-of select="ancestor::place/@xml:id"/>
                    </xsl:variable>
                    <xsl:text> : </xsl:text>
                    <xsl:for-each select="ancestor::TEI//text//placeName[translate(@ref, '#','')=$Placeid]">
                        <!-- pour chaque occurence du nom (<placeName> dans le <body> dont @ref sans le '#' est équivalent à $Placeid) -->
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