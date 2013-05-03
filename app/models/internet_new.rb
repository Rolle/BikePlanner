class InternetNewsCrumb
	attr_reader :link, :text

	def initialize(link, text)
		@text = text
		@link = link
	end
end

class InternetNew
	require "nokogiri"
    require 'open-uri'

    attr_reader :crumbs

	def initialize
		begin
			@crumbs = []
			doc = Nokogiri::XML(open('http://www.radsport-aktiv.de/rss.xml'))

			titles = doc.xpath("//xmlns:item/xmlns:title/text()")
			links = doc.xpath("//xmlns:item/xmlns:link/text()")

			titles.each_with_index do |t,i|
				crumb = InternetNewsCrumb.new(links[i].content, t.content)
				@crumbs << crumb
				break if i>9
			end
		rescue
			@crumbs = []
		end
	end
end