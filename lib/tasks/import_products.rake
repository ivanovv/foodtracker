desc "load energy data drom web"

task :import_products => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'
  #require 'logger'

  url = 'http://www.missfit.ru/diet/table-calory'
  agent = WWW::Mechanize.new
  page = agent.get(url)

  column_names = [:name, :water, :protein, :fat, :carbohydrate, :energy]
  heading_index = 10
  add_row = 3
  while heading_index < 108  do
    heading_index += 1 if heading_index > 100      
    category = Category.find_or_create_by_name( page.at("h2:nth-child(#{heading_index})").text.split(" ")[3..-1].join(" "))
    
    i = 0
    raw_product = {}
    
    if heading_index == 100 
      add_row = 4
    else
      add_row = 3
    end
    
    page.search(".tbl:nth-child(#{heading_index + add_row}) td").each do |item|
      raw_product[column_names[i]] = item.text.tr(',', '.')
      i += 1
      if i > 5
        i = 0        
        raw_product[:category_id] = category.id
        Product.find_or_create_by_name(raw_product)
        raw_product.clear
      end
    end
    heading_index += 6
  end
end