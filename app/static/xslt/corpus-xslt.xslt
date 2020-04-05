<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:param name="numero"/>
    <xsl:template match="/" >
                <xsl:apply-templates select="//text/group/text[@n=$numero]"/>
                <div>
                    <div class="note-global">
                        <xsl:apply-templates select="//text/group/text[@n=$numero]//note[@type='na']/p"/>
                    </div>
                    <div class="note-global">
                        <xsl:apply-templates select="//text/group/text[@n=$numero]//note[@type='n1']/p"/>
                    </div>
                </div>
    </xsl:template>
    <xsl:template match="docDate">
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>date</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="not(contains(placeName,'NS'))">
                    <xsl:apply-templates select="date"/>
                    <xsl:text>. — </xsl:text>
                    <xsl:apply-templates select="placeName"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
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
    <xsl:template match="argument[1]"/>
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
    <xsl:template match="listWit">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>tradition</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
            <!--
                <xsl:for-each select="witness">
                <xsl:element name="p">
                    <xsl:apply-templates/>
                    <xsl:if test="@n='analyse'">
                        <xsl:text>Analyse :</xsl:text>
                        <xsl:apply-templates/>
                    </xsl:if>
                </xsl:element>
            </xsl:for-each>
            -->
        </xsl:element>
    </xsl:template>
    <xsl:template match="witness">
        <xsl:choose>
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
            <xsl:otherwise>
                <xsl:element name="p">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="note[@type='n1']">
        <xsl:element name="sup">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
                </xsl:attribute>
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="note[@type='na']">
        <xsl:element name="sup">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
                </xsl:attribute>
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
        <xsl:template match="div[@type='acte']">
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
    <xsl:template match="hi[@rend='sup']">
        <xsl:element name="sup">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='i']">
        <xsl:element name="i">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='smallcaps']">
        <xsl:element name="mark">
            <xsl:attribute name="style">
                <xsl:text>font-variant: small-caps; background-color: inherit;</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div[@type='MHT']/p">
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>mht</xsl:text>
            </xsl:attribute>
            <i style="font-size: small;">(Sur le repli :) </i><xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div[@type='sign']/p">
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>signature</xsl:text>
            </xsl:attribute>
            <i style="font-size: small;">(Signé :) </i><xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="note[@type='n1']/p">
        <xsl:element name="p">
            <xsl:attribute name="id">
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
            </xsl:attribute>
            <xsl:number count="//text/group/text[@n=$numero]//note[@type='n1']" level="any" format="1"/>
            <xsl:text>. </xsl:text>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="note[@type='na']/p">
        <xsl:element name="p">
            <xsl:attribute name="id">
                <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
            </xsl:attribute>
            <xsl:number count="//text/group/text[@n=$numero]//note[@type='na']" level="any" format="a"/>
            <xsl:text>. </xsl:text>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="ref">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="head">
        <xsl:element name="p">
            <xsl:attribute name="class">
                <xsl:text>text_etabli</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>