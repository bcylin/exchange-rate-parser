require "json"
require "nokogiri"
require "open-uri"
require "sinatra"

get "/rates.json" do
  url = "http://rate.bot.com.tw/Pages/Static/UIP003.zh-TW.htm"
  begin
    html = Nokogiri::HTML(open(url))
  rescue
    status 503
    headers "Content-Type" => "application/json;charset=utf-8"
    body ({ error: "Invalid HTML from #{url}" }.to_json)
    return
  end

  datetime = html.xpath("//td[@width]//td[@style]").map(&:content).first.match(/([\d\/]+\s[\d:]+)/)
  tableRows = html.xpath("//div[@id='slice1']//tr[@class]")

  rates = {
    url: url,
    updated_at: datetime,
    count: tableRows.count,
    results: tableRows.reduce({}) { |accumulator, node| accumulator.merge parseNode(node) }
  }

  status 200
  headers "Content-Type" => "application/json;charset=utf-8"
  body rates.to_json
end

not_found do
  halt 404, "Page not found"
end


private

# Extract data from the <tr> node.
# @return {Hash} Exchange rates of a currency. { currency_symbol => { type_of_rate => rate } }
def parseNode(node)
  name = node.xpath(".//td[@class='titleLeft']").map(&:content).first
  symbol = name.match(/[A-Z]+/).to_s

  keys = [:selling_rate, :buying_rate, :cash_selling_rate, :cash_buying_rate]
  values = node.xpath(".//td[@class='decimal']").map(&:content)

  rates = Hash[keys.zip(values)]
  rates[:name] = name[1..-1]  # remove the &nbsp; in the front

  data = { symbol.to_sym => rates }
end
