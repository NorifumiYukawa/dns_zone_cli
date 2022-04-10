# DnsZoneCli

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dns_zone_cli`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dns_zone_cli'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dns_zone_cli

---

## Usage

What would you do if you wanted to check for a domain?

For example, hosting DNS servers, web servers, and mail servers.

You can predict each host name to some extent, right?
For example, the host name of the mail server may be the domain name itself, or mail.domain name.

It is very troublesome to execute the dig command each time.

If possible, I would like to investigate all at once.
It would be better if you could specify a DNS server and execute the dig command.

I wanted to have a CLI tool that meets such demands.

It's very easy to use.
After installing this gem, the following command will launch the CLI.

    $ dns_zone_cli check

All you have to do is enter the domain name and dns server along with the message.

I think that it is easier to understand the usability if you describe a concrete example.
As an example, I will describe the result of executing dns_zone_cli in the domain of github.com.

```
$ dns_zone_cli check
***Hi, this is CLI domain's DNS zone chekcer***
Please type (domain name) and press (enter)
 github.com
By default, Google Public DNS(8.8.8.8) DNS is used, is there any problem?
If OK, please press (y) and (enter).
If you want to use another DNS, please press (enter) y
=========================================================
Answerd DNS server is 8.8.8.8
=========================================================
----------------NS Recoad--------------------
github.com	3600	IN	NS	dns1.p08.nsone.net
github.com	3600	IN	NS	dns2.p08.nsone.net
github.com	3600	IN	NS	dns3.p08.nsone.net
github.com	3600	IN	NS	dns4.p08.nsone.net
github.com	3600	IN	NS	ns-1283.awsdns-32.org
github.com	3600	IN	NS	ns-1707.awsdns-21.co.uk
github.com	3600	IN	NS	ns-421.awsdns-52.com
github.com	3600	IN	NS	ns-520.awsdns-01.net
---------------------------------------------------------
----------------A Recoad--------------------
github.com	60	IN	A	52.192.72.89
www.github.com	60	IN	A	13.114.40.48
ftp.github.com	3600	IN	A	185.199.108.153
ftp.github.com	3600	IN	A	185.199.109.153
ftp.github.com	3600	IN	A	185.199.110.153
ftp.github.com	3600	IN	A	185.199.111.153
pop.github.com	3600	IN	A	185.199.108.153
pop.github.com	3600	IN	A	185.199.109.153
pop.github.com	3600	IN	A	185.199.110.153
pop.github.com	3600	IN	A	185.199.111.153
smtp.github.com	3600	IN	A	140.82.112.31
smtp.github.com	3600	IN	A	140.82.112.32
smtp.github.com	3600	IN	A	140.82.113.31
smtp.github.com	3600	IN	A	140.82.113.32
smtp.github.com	3600	IN	A	140.82.114.31
smtp.github.com	3600	IN	A	140.82.114.32
imap.github.com	3497	IN	A	185.199.108.153
imap.github.com	3497	IN	A	185.199.109.153
imap.github.com	3497	IN	A	185.199.110.153
imap.github.com	3497	IN	A	185.199.111.153
mail.github.com	3002	IN	A	185.199.108.153
mail.github.com	3002	IN	A	185.199.111.153
mail.github.com	3002	IN	A	185.199.110.153
mail.github.com	3002	IN	A	185.199.109.153
mx.github.com	3600	IN	A	185.199.110.153
mx.github.com	3600	IN	A	185.199.108.153
mx.github.com	3600	IN	A	185.199.109.153
mx.github.com	3600	IN	A	185.199.111.153
localhost.github.com	3600	IN	A	185.199.108.153
localhost.github.com	3600	IN	A	185.199.109.153
localhost.github.com	3600	IN	A	185.199.110.153
localhost.github.com	3600	IN	A	185.199.111.153
---------------------------------------------------------
----------------CNAME Recoad--------------------
www.github.com	3600	IN	CNAME	github.com
ftp.github.com	3600	IN	CNAME	github.github.io
pop.github.com	3600	IN	CNAME	github.github.io
imap.github.com	3600	IN	CNAME	github.github.io
mail.github.com	3600	IN	CNAME	github.github.io
mx.github.com	3600	IN	CNAME	github.github.io
localhost.github.com	3600	IN	CNAME	github.github.io
---------------------------------------------------------
----------------MX Recoad--------------------
github.com	3600	IN	MX	1	aspmx.l.google.com
github.com	3600	IN	MX	5	alt1.aspmx.l.google.com
github.com	3600	IN	MX	5	alt2.aspmx.l.google.com
github.com	3600	IN	MX	10	alt3.aspmx.l.google.com
github.com	3600	IN	MX	10	alt4.aspmx.l.google.com
---------------------------------------------------------
----------------TXT Recoad--------------------
github.com	3024	IN	TXT	"MS=6BF03E6AF5CB689E315FB6199603BABF2C88D805"
github.com	3024	IN	TXT	"MS=ms44452932"
github.com	3024	IN	TXT	"MS=ms58704441"
github.com	3024	IN	TXT	"adobe-idp-site-verification=b92c9e999aef825edc36e0a3d847d2dbad5b2fc0e05c79ddd7a16139b48ecf4b"
github.com	3024	IN	TXT	"apple-domain-verification=RyQhdzTl6Z6x8ZP4"
github.com	3024	IN	TXT	"atlassian-domain-verification=jjgw98AKv2aeoYFxiL/VFaoyPkn3undEssTRuMg6C/3Fp/iqhkV4HVV7WjYlVeF8"
github.com	3024	IN	TXT	"docusign=087098e3-3d46-47b7-9b4e-8a23028154cd"
github.com	3024	IN	TXT	"stripe-verification=f88ef17321660a01bab1660454192e014defa29ba7b8de9633c69d6b4912217f"
github.com	3024	IN	TXT	"66.78.69.170 ip4:166.78.71.131 ip4:167.89.101.2 ip4:167.89.101.192/28 ip4:192.254.112.60 ip4:192.254.112.98/31 ip4:192.254.113.10 ip4:192.254.113.101 ip4:192.254.114.176 ~all"
---

```

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dns_zone_cli.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
# dns_zone_cli
