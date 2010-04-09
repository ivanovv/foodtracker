# encoding: UTF-8

namespace :app do

  desc "Fetch product nutrition value"
  task :fetch_calory => :environment do
    require 'nokogiri'
    require 'open-uri'
    require 'open-uri'
    require 'mechanize'

    agent = Mechanize.new

    name = "блинчики".encode("windows-1251")
    url = "http://www.utkonos.ru/search.php?q=#{CGI.escape(name)}&CID=&t=0"
    agent.get(url)
    links = agent.page.search(".link_9")
    clickable_links = links.map do |link|
      Mechanize::Page::Link.new(link, agent, agent.page)
    end
    divs = clickable_links.map do |link|
      puts link
      sleep(20)
      link.click
      puts agent.page.at(".description .text").to_html.encode("UTF-8")
    end

  end
end

