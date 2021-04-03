require 'rexml/document'

module IjkmlHelper
  def get_summary(text)
    doc = REXML::Document.new(text)
    REXML::XPath.first(doc, '/i:article/i:summary').text
  end
end
