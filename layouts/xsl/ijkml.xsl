<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i="https://ijkml.example.com/">
  <xsl:output method="xml" encoding="UTF-8" />

  <xsl:template match="i:article">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:body">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:code">
    <pre>
      <code>
        <xsl:apply-templates />
      </code>
    </pre>
  </xsl:template>

  <xsl:template match="head">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:p">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template match="i:section">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:snip">
    <code>
      <xsl:apply-templates />
    </code>
  </xsl:template>

  <xsl:template match="i:summary">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:title">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="text()">
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>
