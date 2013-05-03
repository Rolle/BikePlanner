class Forecast
  attr_reader :day_of_week, :low, :high, :icon, :condition
  def initialize(day_of_week, low,high,icon, condition)
    @day_of_week = day_of_week
    @low = low
    @high = high
    @icon = "http://www.google.de/" + icon
    @condition = condition
  end
end

class Weather
	require "nokogiri"
	require "open-uri"
  require "iconv"
	attr_reader :forecasts, :condition, :temp, :humidity, :icon, :wind

    def initialize()
      @forecasts = Array.new
      begin
    		doc = Nokogiri::XML(open("http://www.google.com/ig/api?weather=54341-Germany&hl=de"))
        conv = Iconv.new('US-ASCII//IGNORE', 'UTF-8')

      	@condition = conv.iconv(doc.xpath("//current_conditions//condition").first.attribute("data").value)
      	@temp = doc.xpath("//current_conditions//temp_c").first.attribute("data").value
      	@humidity = doc.xpath("//current_conditions//humidity").first.attribute("data")
      	@icon = "http://www.google.de/" + doc.xpath("//current_conditions//icon").first.attribute("data").value
      	@wind = doc.xpath("//current_conditions//wind_condition").first.attribute("data").value
        doc.xpath("//forecast_conditions").each do |forecast| 
      		fc = Forecast.new( 
      		forecast.xpath("day_of_week").first.attribute("data").value,
      		forecast.xpath("low").first.attribute("data").value,
      		forecast.xpath("high").first.attribute("data").value,
      		forecast.xpath("icon").first.attribute("data").value,
      		conv.iconv(forecast.xpath("condition").first.attribute("data").value))
          #debugger
          @forecasts << fc
      	end
      rescue 
      end
    end
end

=begin
w=Weather.new
puts w.temp 
puts w.condition 
puts w.wind
w.forecasts.each do |forecast|
  puts forecast.condition
end

<xml_api_reply version="1">
  <weather module_id="0" tab_id="0" mobile_row="0"
  mobile_zipped="1" row="0" section="0">
    <forecast_information>
      <city data="Fell, Rhineland-Palatinate" />
      <postal_code data="54341-Germany" />
      <latitude_e6 data="" />
      <longitude_e6 data="" />
      <forecast_date data="2011-10-11" />
      <current_date_time data="2011-10-11 06:55:00 +0000" />
      <unit_system data="SI" />
    </forecast_information>
    <current_conditions>
      <condition data="Bedeckt" />
      <temp_f data="56" />
      <temp_c data="13" />
      <humidity data="Luftfeuchtigkeit: 86 %" />
      <icon data="/ig/images/weather/cloudy.gif" />
      <wind_condition data="Wind: SW mit 23 km/h" />
    </current_conditions>
    <forecast_conditions>
      <day_of_week data="Di." />
      <low data="13" />
      <high data="17" />
      <icon data="/ig/images/weather/cloudy.gif" />
      <condition data="Bew&#246;lkt" />
    </forecast_conditions>
    <forecast_conditions>
      <day_of_week data="Mi." />
      <low data="10" />
      <high data="14" />
      <icon data="/ig/images/weather/chance_of_rain.gif" />
      <condition data="Vereinzelt Regen" />
    </forecast_conditions>
    <forecast_conditions>
      <day_of_week data="Do." />
      <low data="4" />
      <high data="13" />
      <icon data="/ig/images/weather/mostly_sunny.gif" />
      <condition data="Meist sonnig" />
    </forecast_conditions>
    <forecast_conditions>
      <day_of_week data="Fr." />
      <low data="3" />
      <high data="13" />
      <icon data="/ig/images/weather/sunny.gif" />
      <condition data="Klar" />
    </forecast_conditions>
  </weather>
</xml_api_reply>

=end