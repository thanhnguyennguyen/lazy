watchList=(ADA ATOM BAT BTC EOS ETC ETH ICX IOST IOTA KNC LINK LSK OMG ONT QTUM TOMO TRX VET WAVES WRX XLM XRP ZEC ZRX ) 

for s in ${watchList[@]}; do
	price=$(curl -s -X GET https://api.binance.com/api/v3/ticker/price?symbol=${s}USDT | jq -r '.price' )
	echo $s: $price
done







