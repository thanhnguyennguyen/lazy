symbol=TOMOUSDT
price=$(curl -s -X GET https://api.binance.com/api/v3/ticker/price?symbol=$symbol | jq -r '.price' )
echo $symbol: $price

symbol=BTCUSDT
price=$(curl -s -X GET https://api.binance.com/api/v3/ticker/price?symbol=$symbol | jq -r '.price' )
echo $symbol: $price

symbol=ETHUSDT
price=$(curl -s -X GET https://api.binance.com/api/v3/ticker/price?symbol=$symbol | jq -r '.price' )
echo $symbol: $price

symbol=LTCUSDT
price=$(curl -s -X GET https://api.binance.com/api/v3/ticker/price?symbol=$symbol | jq -r '.price' )
echo $symbol: $price


