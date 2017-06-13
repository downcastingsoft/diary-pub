require 'nokogiri'

class IjkMlFilter < Nanoc::Filter
  identifier :ijkml

  def run(content, params = {})
    xslt = Nokogiri::XSLT(@layouts['/xsl/ijkml.xsl'].raw_content)
    doc = Nokogiri::XML(content)
    xslt.apply_to(doc)
  end
end
