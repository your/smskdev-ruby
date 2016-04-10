# smskdev-ruby

smskdev.it unofficial advanced REST API wrapper (incomplete)


## Usage

### Auth

```ruby
> s = Smskdev::Webservices.new(username: 'test', password: 'test')
```

### Send SMS

```ruby
> s.send_sms(to: '391111111111', msg: 'Welcome to my site!')
```

### Inspect response

```ruby
> s.response.data.select{ |s| s['to'] == '391111111111' }
=> [{"status"=>"OK", "error"=>"0", "smslog_id"=>"1769746", "queue"=>"78a86e63feb47eed8b08d25585b3b745", "to"=>"391111111111"}]
```

### SMS delivery status

```ruby
> s.status(smslog_id: 1769746)
=> {"smslog_id"=>"1769746", "src"=>"God", "dst"=>"391111111111", "msg"=>"Welcome to my site!", "dt"=>"2016-04-10 03:23:44", "update"=>"2016-04-10 03:23:56", "status"=>"3"}
```

### Misc

* `sms_sent`
* `sms_succeded`
* `sms_failed`


### More to come

...

## License: MIT

Copyright (C) 2016 Giuseppe Lobraico

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
