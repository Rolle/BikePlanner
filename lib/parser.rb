require "nokogiri"

class Point
	attr_accessor :lat, :lon, :alt, :dist
	
	@@R = 6378.1
	
	def initialize(coords)
		if coords.instance_of?(String)
			c = coords.split(",")
			@lon = c[0].to_f
			@lat = c[1].to_f
			@alt = c[2].to_f
		end
	end
	
	def compute(p2)
		begin
			 dist = @@R * Math::acos(
				Math::sin(self.lat * Math::PI / 180) * Math::sin(p2.lat * Math::PI / 180) + 
		  		Math::cos(self.lat * Math::PI / 180) * Math::cos(p2.lat * Math::PI / 180) * 
		  		Math::cos(p2.lon * Math::PI / 180 - self.lon * Math::PI / 180)
	  		)
			 return dist
	  	rescue
			return 0
	  	end
	end

	def distance(k)
		return self.compute(k)
	end


end

class Parser
	attr_accessor :description, :name, :coordinates, :long_description, :doc, :distances

	def self.create(file)
		file = file[0..file.index("?")-1] if !file.index("?").nil?
		if file.upcase.include?(".KML")			
			KMLParser.new(file)				
		elsif file.upcase.include?(".GPX")			
			GPXParser.new(file)			
		else
			return nil #raise "No supported file extension in file " + file
		end
	end

	def initialize(file)
		f = File.open(file)
		@doc = Nokogiri::XML(f)
		namespaces = @doc.collect_namespaces
		@ns = Hash.new
		namespaces.each_pair do |key, value|
				@ns[key.sub(/^xmlns:/, '')] = value
		end
	end

	def distances
		distance = 0
		@coordinates[0].dist = 0
		i=0
		begin
			for i in 0..@coordinates.size - 2
				distance = distance + @coordinates[i].distance(@coordinates[i+1])
				@coordinates[i+1].dist = distance
			end
		rescue
			puts "-------\ni: " + i.to_s
			puts "lat: " + @coordinates[i].lat.to_s
			puts "lon: " + @coordinates[i].lon.to_s
						puts "lat: " + @coordinates[i+1].lat.to_s
			puts "lon: " + @coordinates[i+1].lon.to_s
		end

	end
end

class GPXParser < Parser
	def initialize(file)
		super(file)
		@description = ""
		#@name = @doc.xpath("/xmlns:gpx/xmlns:metadata/xmlns:name", @ns)[0].text
		@coordinates = split_coordinates(@doc.xpath("/xmlns:gpx/xmlns:trk/xmlns:trkseg/xmlns:trkpt", @ns))
		@distances = distances()
		@long_description = ""
	end	

	private
	def split_coordinates(list)
		coordinates = Array.new
		list.each do |e|
			coordinates << Point.new(e["lon"] + "," +e["lat"] + "," + e.xpath("xmlns:ele").text)			
		end
		coordinates
	end
end

class KMLParser < Parser
	
	def initialize(file)
		super(file)
		@description = @doc.xpath("/xmlns:kml/xmlns:Document/xmlns:description", @ns)[0].text
		@name = @doc.xpath("/xmlns:kml/xmlns:Document/xmlns:name", @ns)[0].text
		@coordinates = split_coordinates(@doc.xpath("/xmlns:kml/xmlns:Document/xmlns:Placemark/xmlns:MultiGeometry/xmlns:LineString/xmlns:coordinates", @ns)[0].text)
		@distances = distances()
		@long_description = @doc.xpath("/xmlns:kml/xmlns:Document/xmlns:Placemark/xmlns:description", @ns)[-1].children()[0].text
	end

	def distance
		coords = @coordinates.split(" ")
		distance = 0
		for i in 0..@coordinates_with_alt.size()-2				
			p0 = Point.new(@coordinates_with_alt[i])
			p1 = Point.new(@coordinates_with_alt[i+1])
			#p0 = Point.new(coords[i].split(",")[1], coords[i].split(",")[0])
			#p1 = Point.new(coords[i+1].split(",")[1], coords[i+1].split(",")[0])
			distance = distance + p0.compute(p1)
		end
		distance.round(3)
	end

	def alt
		up,down,max,min = 0,0,-99999,99999
		coords_a = to_a

		for i in 0..coords_a.size() - 2
			diff = coords_a[i+1][2] - coords_a[i][2]
			if (diff > 0)
				up += diff
				print(diff.to_s+"+")
			else
				down += diff
			end				
		end
		coords_a.each do |coord|				
			max = coord[2] if coord[2] > max
			min = coord[2] if coord[2] < min
		end
		return up,down,max,min
	end

	private
	def split_coordinates(long_string)
		coords_with_alt = long_string.split(" ")
		coords_as_points_with_alt = Array.new
		coords_with_alt.each do |c| 
			coords_as_points_with_alt << Point.new(c)
		end
		coords_as_points_with_alt
	end
end

=begin
p=Parser.create("Manderscheid_50.gpx")
puts p.coordinates.size
for i in 0..10 do
	puts p.coordinates[i].alt.to_s + ","+p.coordinates[i].dist.to_s
end
puts "------"
	puts p.coordinates[-1].alt.to_s + ","+p.coordinates[-1].dist.to_s

=end