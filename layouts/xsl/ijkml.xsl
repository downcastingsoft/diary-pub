<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i="https://ijkml.example.com/"
  exclude-result-prefixes="i">
  <xsl:output method="xml" encoding="UTF-8" />

  <xsl:template match="i:article">
    <article>
      <xsl:apply-templates select="i:title" />
      <xsl:if test="i:summary">
        <xsl:apply-templates select="i:summary" />
      </xsl:if>
      <hr />
      <xsl:apply-templates select="i:body" />
    </article>
  </xsl:template>

  <xsl:template match="i:body">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:code">
    <pre>
      <code class="prettyprint">
        <xsl:apply-templates />
      </code>
    </pre>
  </xsl:template>

  <xsl:template match="i:cpp-std">
    <a>
      <xsl:attribute name="href">
        <xsl:text>http://eel.is/c++draft/</xsl:text>
        <xsl:text/><xsl:value-of select="@section"/><xsl:text/>
        <xsl:if test="@paragraph">
          <xsl:text/>#<xsl:value-of select="@paragraph"/><xsl:text/>
        </xsl:if>
      </xsl:attribute>
      <xsl:text/>[<xsl:value-of select="@section"/>]<xsl:text/>
      <xsl:if test="@paragraph">
        <xsl:text/>/<xsl:value-of select="@paragraph"/><xsl:text/>
      </xsl:if>
    </a>
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
    <section>
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates />
    </section>
  </xsl:template>

  <xsl:template match="i:snip">
    <code>
      <xsl:apply-templates />
    </code>
  </xsl:template>

  <xsl:template match="i:summary">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template match="i:title">
    <xsl:variable name="parents" select="ancestor::i:section"/>
    <xsl:variable name="level" select="1 + count($parents)"/>
    <xsl:element name="{concat('h', string($level))}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="i:titlestring">
    <title>
      <xsl:apply-templates />
    </title>
  </xsl:template>

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>
