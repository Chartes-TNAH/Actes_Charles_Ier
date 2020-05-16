<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <!-- STRUCTURATION GLOBALE -->
    <xsl:template match="/">
        <xsl:apply-templates select="//projectDesc/p"/>
    </xsl:template>
    <!-- TEXTE DE PRÉSENTATION DU PROJET -->
    <xsl:template match="projectDesc/p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <!-- RÈGLES GLOBALES DE MISE EN FORME -->
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
</xsl:stylesheet>