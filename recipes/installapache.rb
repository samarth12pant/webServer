#
# Cookbook:: WebServer
# Recipe:: installapache
#
# Copyright:: 2022, The Authors, All Rights Reserved.

#installing WebServer based on the Linux Distribution type
package 'httpd' do
    action :install
    case node[:platform_family]  # will help us identify the OS of client
    when 'rhel'  #if OS is RHEL then install httpd package otherwise if OS is Debian install apache2 package
        package_name 'httpd'
    when 'debian'
        package_name 'apache2'
    end        
end

#starting the WebServer service
service 'httpd' do
    action [:start, :enable]
    case node[:platform_family]  # will help us identify the OS of client
    when 'rhel'
        service_name 'httpd'
    when 'debian'
        service_name 'apache2'
    end
end

#creating a file using file resource
file '/var/www/html/sample.html' do
    content '<html><em>FILE CREATED BY CHEF, DO NOT EDIT!!!!!</em></html>'
    mode '0755'
    owner 'root'
    group 'root'
end

#creating file using a template(mycompany.html.erb)
template '/var/www/html/index.html' do
    source 'mycompany.html.erb'
    mode '0755'
    owner 'root'
    group 'root'
    variables ({    #passing parameters being used in the mycompany.html.erb template file
        :companyName => "My Firt Company",
        :productList => ["Item1", "Item2", "Item3", "Item4"],
        :premium => false
    })
end

#creating a file uing existing file(webpage.html)
cookbook_file '/var/www/html/webpage.html' do
    source 'webpage.html'
    mode '0755'
    owner 'root'
    group 'root'
end
