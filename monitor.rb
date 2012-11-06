#!/usr/bin/env ruby
gem 'watir'
require 'watir'

host_path = "c:/windows/system32/drivers/etc/hosts"
test_url = "URL-HERE"
test_host = "HOSTNAME in URL"
search_string = "Careers at McApple Garden"

servers = {
    pm_grid_appxx: "xxx.xxx.xxx.xxx",
    pm_grid_appxx: "xxx.xxx.xxx.xxx",
    pm_grid_appxx: "xxx.xxx.xxx.xxx",
    pm_grid_appxx: "xxx.xxx.xxx.xxx",
    pm_grid_appxx: "xxx.xxx.xxx.xxx"
}

# create backup of host file
host_file = File.open(host_path, "r")
host_backup = host_file.readlines()
host_file.close()

servers.each { |server_name, server_ip|

  server_name = server_name.to_s.gsub("_", "-")

  puts "Updating host file with server: #{server_name} -> #{server_ip}"
  host_file = File.open(host_path, "w")
  host_file.write("#{server_ip}\t#{test_host}")
  host_file.close()

  browser = Watir::Browser.new()
  browser.goto(test_url)

  if browser.text.include?(search_string)
    print "Server-ID Parsed: #{browser.html.scan(/<small.*>(0\d)<\/small>/)} :: "
    puts "#{server_name} is displaying #{search_string} properly\r\n\r\n"
  else
    puts "#{server_name} does NOT show #{search_string} properly!\r\n\r\n"
  end

  browser.close()
}

puts "Restoring backup copy of #{host_path}"
host_file = File.open(host_path, "w")
host_file.write(host_backup)
host_file.close()

puts "Restoration complete."

