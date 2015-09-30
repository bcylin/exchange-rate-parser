# Exchange Rate Parser

Fetch the webpage from [Bank of Taiwan](http://rate.bot.com.tw/Pages/Static/UIP003.zh-TW.htm) and extract the exchange rates of each currency as the following JSON:

```js
{
  "url": "http://rate.bot.com.tw/Pages/Static/UIP003.zh-TW.htm",
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
