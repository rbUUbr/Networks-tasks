Curl analog
=========================================
This is my analog for cURL utilite.Usage
```
ruby my_curl.rb [url] [options]
```
Actions:
```
1. -u, --url 
2. -h, --help
3. -d, --data
```

1.-u
------------

Settings url for parsing, returns object with fields ``` code ``` and ``` body ```

2.-h
------------

Outputs help message with all commands

3.-d
------------

Make post request to server. Make it like this: ``` ruby my_curl.rb -d "url=.&name=Alex" -u [URL] ```

More information
------------

* Ruby version: 2.4.0
* Author: Tatchihin Kirill (rbUUbr)
* Used libraries and modules
  > net/http  
  > colorize  
  > optparse  
  > uri  
