<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <xsl:call-template name="regestes"/>
    </xsl:template>
    <xsl:template name="regestes">
        <xsl:element name="div">
            <xsl:for-each select="//argument[1]/p">
                <xsl:element name="p">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>/sommaire/</xsl:text>
                            <xsl:number count="argument[1]" level="any" format="1"/>
                        </xsl:attribute>
                        <xsl:element name="b">
                            <xsl:number count="argument[1]" level="any" format="1"/>
                            <xsl:text>. </xsl:text>
                            <xsl:value-of select="ancestor::front//date"/>
                            <xsl:text>. </xsl:text>
                        </xsl:element>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
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
</xsl:stylesheet>