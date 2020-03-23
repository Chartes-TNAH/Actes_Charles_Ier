<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <xsl:call-template name="places"/>
    </xsl:template>
    <xsl:template name="places">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>index-section-main</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="style">
                <xsl:text>column-count: 3; margin-top: 3%;</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="//place//name[@xml:lang='fr']">
                <xsl:sort select="." order="ascending"/>
                <xsl:element name="p">
                    <xsl:attribute name="class">
                        <xsl:text>index-entree</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="b">
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="ancestor::place/desc"/>
                    <xsl:text>)</xsl:text>
                    <xsl:variable name="Placeid">
                        <xsl:value-of select="ancestor::place/@xml:id"/>
                    </xsl:variable>
                    <xsl:text> : </xsl:text>
                    <xsl:for-each select="ancestor::TEI//text//placeName[translate(@ref, '#','')=$Placeid]">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:text>/sommaire/</xsl:text><xsl:value-of select="ancestor::text/@n"/>
                            </xsl:attribute>
                            <xsl:value-of select="ancestor::text/@n"/>
                        </xsl:element>
                        <xsl:if test="position()!= last()">, </xsl:if>
                        <xsl:if test="position() = last()">.</xsl:if>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>