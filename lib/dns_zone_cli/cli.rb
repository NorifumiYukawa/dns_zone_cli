require "dns_zone_cli"
require 'resolv'
require "thor"

module DnsZoneCli
  class CLI < Thor
    desc 'quick dns checker', 'This is CLI domain DNS Check Tool'
  
    @@domain_regex = /^([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/
    @@ipv4_regex = /^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$/
    @@ipv6_regex = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/
  
    some_host_name = ['', 'www.', 'ftp.', 'pop.', 'smtp.', 'imap.', 'mail.', 'mx.', 'localhost.']
    host_name_none = ['']
  
    @@recoad_type_and_host_neme = {
      NS: host_name_none,
      A: some_host_name,
      CNAME: some_host_name,
      MX: ['', 'mail.', 'mx.'],
      TXT: host_name_none
    }
  
    def check
      say "***Hi, this is CLI domain\'s DNS zone chekcer***", :green
      @domain = ask "Please type (domain name) and press (enter)\r\n", :green
    
      while @domain.nil? || !@domain.match(@@domain_regex)
        say "***Null or it's not FQDN.  Please try again***", :red
        @domain = ask 'Please retype (domain name) and press (enter)', :red
      end
    
      say 'By default, Google Public DNS(8.8.8.8) DNS is used, is there any problem?', :green
    
      if yes? "If OK, please press (y) and (enter).\r\nIf you want to use another DNS, please press (enter)", :green
        query_dns('8.8.8.8')
      else
        assign_dns = ask "Please input DNS server name and (enter)\r\n", :green
    
        valid_dns_host = [@@domain_regex, @@ipv4_regex, @@ipv6_regex]
    
        while assign_dns.nil? || !assign_dns.match(Regexp.union(valid_dns_host))
          say "***Null or it's not dns_server.  Please try again***", :red
          assign_dns = ask "(Please retype dns server name and press enter key)\r\nex:dns.google\r\nex:1.1.1.1\r\n", :red
        end
  
        # DNS server find?
        begin
          Resolv.getaddress(assign_dns)
        rescue StandardError
          say "I can\'t DNS host name, so... I use Google Public DNS", :red
          query_dns('8.8.8.8')
        else
          query_dns(assign_dns)
        end
      end
    end
  
    private
  
    def query_dns(dns_server)
      puts '========================================================='
      puts "Answerd DNS server is #{dns_server}"
      puts '========================================================='
  
      is_dns = Resolv::DNS.new(nameserver: dns_server)
  
      @@recoad_type_and_host_neme.each do |recoad_type, host_name|
        puts "----------------#{recoad_type} Recoad--------------------"
        host_name.each do |host|
          fqdn = host + @domain
  
          case recoad_type
          when :NS
            is_dns.each_resource(fqdn, Resolv::DNS::Resource::IN::NS) do |resource|
              puts "#{fqdn}\t#{resource.ttl}\tIN\t#{recoad_type}\t#{resource.name}"
            end
          when :A
            is_dns.each_resource(fqdn, Resolv::DNS::Resource::IN::A) do |resource|
              puts "#{fqdn}\t#{resource.ttl}\tIN\t#{recoad_type}\t#{resource.address}"
            end
          when :CNAME
            is_dns.each_resource(fqdn, Resolv::DNS::Resource::IN::CNAME) do |resource|
              puts "#{fqdn}\t#{resource.ttl}\tIN\t#{recoad_type}\t#{resource.name}"
            end
          when :MX
            is_dns.each_resource(fqdn, Resolv::DNS::Resource::IN::MX) do |resource|
              puts "#{fqdn}\t#{resource.ttl}\tIN\t#{recoad_type}\t#{resource.preference}\t#{resource.exchange}"
            end
          when :TXT
            is_dns.each_resource(fqdn, Resolv::DNS::Resource::IN::TXT) do |resource|
              txt_value = resource.strings.pop
              puts "#{fqdn}\t#{resource.ttl}\tIN\t#{recoad_type}\t\"#{txt_value}\""
            end
          end
        end
        puts '---------------------------------------------------------'
      end
    end
  end
end