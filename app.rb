require "json"
require "nokogiri"
require "open-uri"
require "sinatra"

get "/rates.json" do
  url = "http://rate.bot.com.tw/xrt?Lang=zh-TW"
  begin
    html = Nokogiri::HTML(open(url))
  rescue
    status 503
    headers "Content-Type" => "application/json;charset=utf-8"
    body ({ error: "Invalid HTML from #{url}" }.to_json)
    return
  end

  datetime = html.css("span.time").first.content
  tableRows = html.css("table > tbody > tr")

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
  name = node.css("div.print_show").first.content
  symbol = name.match(/[A-Z]+/).to_s

  rates = {
    cash_buying_rate:  node.css("td[data-table=本行現金買入]").first.content,
    cash_selling_rate: node.css("td[data-table=本行現金賣出]").first.content,
    buying_rate:       node.css("td[data-table=本行即期買入]").first.content,
    selling_rate:      node.css("td[data-table=本行即期賣出]").first.content,
    name: name.strip
  }

  data = { symbol.to_sym => rates }
end
