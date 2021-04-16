<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i="http://www.downcastingsoft.net/2021/IJKML"
  exclude-result-prefixes="i">
  <xsl:output
    encoding="UTF-8"
    indent="yes"
    method="html"
    omit-xml-declaration="yes" />

  <xsl:template match="i:article">
    <article>
      <header id="header">
        <xsl:apply-templates select="i:title" />
        <div class="article-metadata">
          <div>
            <xsl:text>author: </xsl:text>
            <xsl:value-of select="/i:article/i:head/i:author/text()"/>
            <xsl:text>, created at: </xsl:text>
            <xsl:value-of select="/i:article/i:head/i:created-at/text()"/>
            <xsl:text>, updated at: </xsl:text>
            <xsl:value-of select="/i:article/i:head/i:updated-at/text()"/>
          </div>
          <xsl:if test="i:summary">
            <xsl:apply-templates select="i:summary" />
          </xsl:if>
        </div>
      </header>
      <xsl:apply-templates select="i:body" />

      <xsl:if test="//i:footnote">
        <section id="footnotes">
          <h2>脚注</h2>
          <xsl:for-each select="//i:footnote">
            <xsl:variable name="num" select="position()" />
            <div class="targetable">
              <xsl:attribute name="id">
                <xsl:text>footnote-</xsl:text>
                <xsl:value-of select="@fid" />
              </xsl:attribute>

              <a>
                <xsl:attribute name="href">
                  <xsl:text>#ref-footnote-</xsl:text>
                  <xsl:value-of select="@fid" />
                </xsl:attribute>

                <xsl:text>*</xsl:text>
                <xsl:value-of select="$num"/>
              </a>:
              <xsl:apply-templates />
            </div>
          </xsl:for-each>
        </section>
      </xsl:if>
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

  <xsl:template match="i:footnote">
    <xsl:variable name="predecessors" select="preceding::i:footnote"/>
    <xsl:variable name="num" select="count($predecessors) + 1"/>
    <a class="link-footnote targetable">
      <xsl:attribute name="href">
        <xsl:text>#footnote-</xsl:text>
        <xsl:value-of select="@fid" />
      </xsl:attribute>

      <xsl:attribute name="id">
        <xsl:text>ref-footnote-</xsl:text>
        <xsl:value-of select="@fid" />
      </xsl:attribute>

      <xsl:text/><xsl:value-of select="$num"/><xsl:text/>
    </a>
  </xsl:template>

  <xsl:template match="head">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="i:italic">
    <span style="font-style:italic;">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="i:p">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template match="i:quote">
    <blockquote>
      <xsl:apply-templates />
    </blockquote>
  </xsl:template>

  <xsl:template match="i:section">
    <section>
      <xsl:attribute name="id">
        <xsl:text>section-</xsl:text>
        <xsl:value-of select="@sid"/>
      </xsl:attribute>
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

  <xsl:template match="/i:article/i:title">
    <h1>
      <xsl:apply-templates />
    </h1>
  </xsl:template>

  <xsl:template match="i:title">
    <xsl:variable name="parents" select="ancestor::i:section"/>
    <xsl:variable name="level" select="1 + count($parents)"/>
    <xsl:element name="{concat('h', string($level))}">
      <xsl:attribute name="class">section-heading</xsl:attribute>
      <a class="section-anchor">
        <xsl:attribute name="href">
          <xsl:value-of select="concat('#section-', string(../@sid))" />
        </xsl:attribute>
      </a>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="i:titlestring">
    <title>
      <xsl:apply-templates />
    </title>
  </xsl:template>

  <xsl:template match="*|@*|text()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
