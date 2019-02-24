# Exchange Rate Parser

[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/bcylin/exchange-rate-parser/blob/master/LICENSE)

Parse the webpage from [Bank of Taiwan](https://rate.bot.com.tw/xrt?Lang=en-US) and extract the exchange rates as the following JSON:

```js
{
  "url": "https://rate.bot.com.tw/xrt?Lang=zh-TW",
  "updated_at": "2015/09/30 16:01",
  "count": 19,
  "results": {
    "USD": {
      "selling_rate": "32.52000",
      "buying_rate": "33.06200",
      "cash_selling_rate": "32.82000",
      "cash_buying_rate": "32.92000",
      "name": "美金 (USD)"
    },
    // ...
  }
}
```

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/bcylin/exchange-rate-parser)

```
https://#{app-name}.herokuapp.com/rates.json
```

## Test Locally

Install required gems:

```sh
bundle install
```

Test with [shotgun](https://github.com/rtomayko/shotgun):

```sh
open http://localhost:9393/rates.json && shotgun app.rb
```

## License

The source code is released under the MIT license.

### Disclaimer

> This parser is not affiliated with Bank of Taiwan in any form. [This license](https://github.com/bcylin/exchange-rate-parser/blob/master/LICENSE) only grants the use of source code. Anyone who uses this parser is responsible for the use of data, which belongs to Bank of Taiwan. The correctness of the data depends on the disclosed information from <http://rate.bot.com.tw/Pages/Static/UIP003.zh-TW.htm>.
