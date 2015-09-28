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

  rates = {
    html: html
  }

  status 200
  headers "Content-Type" => "application/json;charset=utf-8"
  body rates.to_json
end
