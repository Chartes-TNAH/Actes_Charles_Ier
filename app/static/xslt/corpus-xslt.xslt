<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <!-- param pour l'id de l'acte -->
    <xsl:param name="numero"/>
    <!-- STRUCTURATION GLOBALE -->
    <xsl:template match="/" >
        <!-- bloc du paratexte et du texte -->
        <xsl:apply-templates select="//text/group/text[@n=$numero]"/>
        <!-- bloc des notes -->
        <div>
            <!-- notes paléographiques -->
            <div class="note-global">
                <xsl:apply-templates select="//text/group/text[@n=$numero]//note[@type='na']/p"/>
            </div>
            <!-- notes critiques -->
            <div class="note-global">
                <xsl:apply-templates select="//text/group/text[@n=$numero]//note[@type='n1']/p"/>
            </div>
        </div>
    </xsl:template>
    <!-- RÈGLES GLOBALES DE MISE EN FORME -->
    <xsl:template match="hi[@rend='sup']">
        <!-- exposant -->
        <xsl:element name="sup">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='i']">
        <!-- italique -->
        <xsl:element name="i">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='smallcaps']">
        <!-- petites majuscules -->
        <xsl:element name="mark">
            <xsl:attribute name="style">
                <xsl:text>font-variant: small-caps; background-color: inherit;</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="ref">
        <!-- liens -->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="head">
        <!-- titre des actes -->
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>text_etabli</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="biblStruct">
        <!-- référence bibliographique structurée -->
        <xsl:if test="parent::witness/@n='a'">
            <!-- si c'est l'édition a. -->
            <xsl:value-of select="parent::witness/@n"/>
            <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:if test="parent::witness/@n='b'">
            <!-- si c'est l'édition b. -->
            <xsl:value-of select="parent::witness/@n"/>
            <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:for-each select=".//author/persName">
            <!-- identité du ou des auteurs -->
            <xsl:if test="./addName">
                <xsl:apply-templates select="./addName"/>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates select="./forename"/>
            <xsl:if test="./surname">
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="./surname"/>
            </xsl:if>
            <xsl:text>, </xsl:text>
        </xsl:for-each>
        <xsl:choose>
            <!-- titre -->
            <xsl:when test=".//monogr/title[@level='a']">
                <!-- 1/ s'il s'agit d'un article -->
                <xsl:text>&#171; </xsl:text>
                <!-- titre de l'article entre guillemets français -->
                <xsl:apply-templates select=".//monogr/title[@level='a']"/>
                <xsl:text> &#187;, dans </xsl:text>
                <!-- titre de la revue en italique -->
                <xsl:element name="i">
                    <xsl:apply-templates select=".//monogr/title[@level='j']"/>
                </xsl:element>
                <xsl:if test=".//biblScope[@unit='part']">
                    <!-- si la revue est organisée en séries (@part) -->
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='part']/@n"/>
                </xsl:if>
                <xsl:text>, n°</xsl:text>
                <!-- numéro de la revue -->
                <xsl:choose>
                    <!-- il s'agit d'un numéro unique -->
                    <xsl:when test=".//biblScope[@unit='issue']/@n">
                        <xsl:value-of select=".//biblScope[@unit='issue']/@n"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- le numéro n'est pas unique -->
                        <xsl:value-of select=".//biblScope[@unit='issue']/@from"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select=".//biblScope[@unit='issue']/@to"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- 2/ il ne s'agit pas d'un article : c'est un titre de monographie -->
                <xsl:element name="i">
                    <xsl:apply-templates select=".//monogr/title[@level='m']"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>, </xsl:text>
        <xsl:if test=".//respStmt/persName">
            <!-- éditeur -->
            <xsl:for-each select=".//respStmt/persName">
                <xsl:apply-templates select="./forename"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="./surname"/>
                <xsl:if test="position()!= last()">, </xsl:if>
            </xsl:for-each>
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select=".//imprint/respStmt/resp"/>
            <xsl:text>), </xsl:text>
        </xsl:if>
        <xsl:if test=".//pubPlace">
            <!-- lieu de publication -->
            <xsl:apply-templates select=".//pubPlace"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test=".//publisher">
            <!-- éditeur -->
            <xsl:apply-templates select=".//publisher"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- date -->
        <xsl:value-of select=".//date/@when"/>
        <xsl:text>, </xsl:text>
        <xsl:if test=".//biblScope[@unit='page']">
            <!-- pagination -->
            <xsl:choose>
                <xsl:when test=".//biblScope[@unit='page']/@n">
                    <!-- il y a une page -->
                    <xsl:text>p. </xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='page']/@n"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- il y a plusieurs pages -->
                    <xsl:text>pp. </xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='page']/@from"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='page']/@to"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test=".//biblScope[@unit='entry']">
            <!-- la localisation dans la page est précisée (numéro d'index, preuve, appendice et al.) -->
            <xsl:text> , n°</xsl:text>
            <xsl:value-of select=".//biblScope[@unit='entry']/@n"/>
            <xsl:if test="./text()">
                <xsl:text> </xsl:text>
                <xsl:apply-templates select=".//biblScope[@unit='entry']"/>
            </xsl:if>
        </xsl:if>
        <xsl:if test=".//ref">
            <!-- il y a un lien vers une numérisation ou autre -->
            <xsl:text> </xsl:text>
            <xsl:apply-templates select=".//ref"/>
        </xsl:if>
        <xsl:if test="parent::witness">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="bibl">
        <!-- référence bibliographique non structurée -->
        <xsl:element name="i">
            <!-- titre -->
            <xsl:value-of select="./title"/>
        </xsl:element>
        <xsl:if test="./biblScope[@unit='volume']">
            <!-- numéro du volume s'il existe -->
            <xsl:text>, </xsl:text>
            <xsl:value-of select="./biblScope[@unit='volume']/@n"/>
        </xsl:if>
        <xsl:if test="./biblScope[@unit='page']">
            <!-- pagination si elle précisée -->
            <xsl:choose>
                <!-- une page -->
                <xsl:when test=".//biblScope[@unit='page']/@n">
                    <xsl:text>, p. </xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='page']/@n"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- plusieurs pages -->
                    <xsl:text>, pp. </xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='page']/@from"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select=".//biblScope[@unit='page']/@to"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="./biblScope[@unit='entry']">
            <xsl:text>, n°</xsl:text>
            <xsl:value-of select="./biblScope[@unit='entry']/@n"/>
        </xsl:if>
        <xsl:if test="parent::witness">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- DATATION -->
    <xsl:template match="docDate">
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>date</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <!-- dateq de temps et de lieu -->
                <xsl:when test="not(contains(placeName,'NS'))">
                    <xsl:apply-templates select="date"/>
                    <xsl:text>. — </xsl:text>
                    <xsl:apply-templates select="placeName"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <!-- date de temps uniquement -->
                <xsl:otherwise>
                    <xsl:apply-templates select="date"/>
                    <xsl:text>.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="date">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="docDate/placeName">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- pas de template pour le premier argument, qui est utilisé pour la page de présentation du corpus -->
    <xsl:template match="argument[1]"/>
    <!-- REGESTE -->
    <xsl:template match="argument[2]">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>analyse</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="argument[2]/p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <!-- IMAGES -->
    <xsl:template match="listWit">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>tradition</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
        <xsl:apply-templates select="facsimile"/>
        <!-- image de l'acte s'il y a un <facsimile> avec @n contenant l'id de l'acte  -->
        <xsl:if test="ancestor::TEI//facsimile[@n=$numero]">
            <xsl:element name="div">
                <xsl:element name="details">
                    <xsl:element name="summary">
                        <xsl:text>Cliquer pour afficher une image de l'acte.</xsl:text>
                    </xsl:element>
                    <!-- si un chemin est renseigné dans le @url de <graphic> -->
                    <xsl:if test="//facsimile[@n=$numero]/graphic/@url">
                        <xsl:element name="img">
                            <xsl:attribute name="src"><xsl:value-of select="//facsimile[@n=$numero]/graphic/@url"/></xsl:attribute>
                            <xsl:attribute name="width">100%</xsl:attribute>
                            <xsl:attribute name="height">auto</xsl:attribute>
                        </xsl:element>
                    </xsl:if>
                    <!-- s'il y a une description de l'image-->
                    <xsl:if test="//facsimile[@n=$numero]/graphic/desc">
                        <xsl:element name="p">
                            <xsl:value-of select="//facsimile[@n=$numero]/graphic/desc"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:element>
            </xsl:element>
            </xsl:if>
    </xsl:template>
    <!-- TABLEAU DE LA TRADITION -->
    <xsl:template match="witness">
        <!-- Plusieurs cas : -->
        <xsl:choose>
            <!-- Quand il y a une analyse -->
            <xsl:when test="@n='analyse'">
                <xsl:element name="p">
                    <xsl:element name="mark">
                        <xsl:attribute name="style">
                            <xsl:text>font-variant: small-caps; background-color: inherit;</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Analyse : </xsl:text>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <!-- Quand il y a une mention -->
            <xsl:when test="@n='mention'">
                <xsl:element name="p">
                    <xsl:element name="mark">
                        <xsl:attribute name="style">
                            <xsl:text>font-variant: small-caps; background-color: inherit;</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Mention : </xsl:text>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <!-- Quand il y a un indiqué -->
            <xsl:when test="@n='indique'">
                <xsl:element name="p">
                    <xsl:element name="mark">
                        <xsl:attribute name="style">
                            <xsl:text>font-variant: small-caps; background-color: inherit;</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Indiqué : </xsl:text>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <!-- Dans tous les cas -->
            <xsl:otherwise>
                <xsl:element name="p">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- APPELS DE NOTE DANS LE TEXTE -->
    <xsl:template match="note[@type='n1']">
        <!-- notes critiques -->
        <xsl:element name="sup">
            <xsl:element name="a">
                <!-- @href pour lier l'appel à l'id de la note en fonction de son numéro -->
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
                </xsl:attribute>
                <!-- numéro de la note -->
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="note[@type='na']">
        <!-- notes paléographiques -->
        <xsl:element name="sup">
            <xsl:element name="a">
                <!-- @href pour lier l'appel à l'id de la note en fonction de son numéro -->
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
                </xsl:attribute>
                <!-- numéro de la note -->
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- TEXTE DE L'ACTE -->
    <xsl:template match="div[@type='acte']">
        <!-- corps de l'acte -->
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>act</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div[@type='acte']/p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div[@type='MHT']">
        <!-- mention hors teneur (mht) -->
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>mht</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <!-- indication sur le positionnement de la mht -->
                <xsl:when test="@subtype='gauche'">
                    <i style="font-size: small;">(À gauche :) </i><xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@subtype='droite'">
                    <i style="font-size: small;">(À droite :) </i><xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@subtype='replidroit'">
                    <i style="font-size: small;">(Sur le repli, à droite :) </i><xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@subtype='repligauche'">
                    <i style="font-size: small;">(Sur le repli, à gauche :) </i><xsl:apply-templates/>
                </xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div[@type='sign']">
        <!-- signature -->
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>signature</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="child::p">
                <xsl:element name="p">
                    <i style="font-size: small;">(Signé :) </i><xsl:apply-templates/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <!-- NOTES CRITIQUES -->
    <xsl:template match="note[@type='n1']/p">
        <xsl:element name="p">
            <!-- @id, cible du @href de l'appel de note dans le texte -->
            <xsl:attribute name="id">
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
            </xsl:attribute>
            <!-- numéro de la note -->
            <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
            <xsl:text>. </xsl:text>
            <!-- texte de la note -->
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <!-- NOTES PALÉOGRAPHIQUES -->
    <xsl:template match="note[@type='na']/p">
        <xsl:element name="p">
            <xsl:attribute name="id">
                <!-- @id, cible du @href de l'appel de note dans le texte -->
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
            </xsl:attribute>
            <!-- numéro de la note -->
            <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
            <xsl:text>. </xsl:text>
            <!-- texte de la note -->
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>