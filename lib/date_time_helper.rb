module DateTimeHelper
  def timeline(start=nil,days=7)
    start = DateTime.now if start.nil?
    dates = []
    1.upto(days) do |i|
      dates[i-1] = (start+i-1.days).strftime("%a, %d.%m.%Y")
    end
    dates
  end
end