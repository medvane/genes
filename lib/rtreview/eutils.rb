require 'cgi'
require 'net/http'
require 'uri'

module Rtreview::Eutils
  EUTILS_URL  = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/"
  TOOL_NAME   = "rtreview.medvane.org"
  TOOL_EMAIL  = "eutils@medvane.org"

  def esearch(query)
    server = EUTILS_URL + "esearch.fcgi"
    params = {
      "db"          => "pubmed",
      "term"        => query,
      "tool"        => TOOL_NAME,
      "email"       => TOOL_EMAIL,
      "retmax"      => 0,
      "usehistory"  => "y",
    }
    response = Net::HTTP.post_form(URI.parse(server), params)
    result = response.body
    count = result.scan(/<Count>(.*?)<\/Count>/m).flatten.first.to_i
    webenv = result.scan(/<WebEnv>(.*?)<\/WebEnv>/m).flatten.first.to_s
    return webenv, count
  end
  module_function :esearch

  def efetch(webenv, retstart = 0, retmax = 1000000, rettype = "uilist")
    server = EUTILS_URL + "efetch.fcgi"
    params = {
      "db"          => "pubmed",
      "tool"        => TOOL_NAME,
      "email"       => TOOL_EMAIL,
      "WebEnv"      => webenv,
      "retmax"      => retmax,
      "rettype"     => rettype,
      "retmode"     => "text",
      "retstart"    => retstart,
      "query_key"   => 1,
    }
    response = Net::HTTP.post_form(URI.parse(server), params)
    medline = []
    unless response.body.blank?
      case rettype
      when "uilist"
        medline = response.body.split(/\n/)
      when "medline"
        medline = response.body.split(/\n\n+/).map {|e| Bio::MEDLINE.new(e) }
      end
    end
    return medline
  end
  module_function :efetch

  def epost(ids)
    server = EUTILS_URL + "epost.fcgi"
    params = {
      "db"          => "pubmed",
      "id"          => ids.join(","),
      "tool"        => TOOL_NAME,
      "email"       => TOOL_EMAIL,
    }
    response = Net::HTTP.post_form(URI.parse(server), params)
    result = response.body
    webenv = result.scan(/<WebEnv>(.*?)<\/WebEnv>/m).flatten.first.to_s
    return webenv
  end
  module_function :epost
end