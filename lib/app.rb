require 'json'

# Get path to products.json, read the file into a string,
# and transform the string into a usable hash
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("../report.txt", "w+")
end

def print (output)
  $report_file.puts output
end

def print_date
  time = Time.new
  line = "-- Date \n" + "today's date : " + time.inspect + "\n\n"
  print(line)
end

# Print "Products" in ascii art
def print_products_header
  $report_file.puts "                     _            _       "
  $report_file.puts "                    | |          | |      "
  $report_file.puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
  $report_file.puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
  $report_file.puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
  $report_file.puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
  $report_file.puts "| |                                       "
  $report_file.puts "|_|                                       "
  $report_file.puts
  $report_file.puts
end

# Print "Sales Report" in ascii art
def print_sales_report_header
  $report_file.puts "  _____       _             _____                       _    "
  $report_file.puts " / ____|     | |           |  __ \\                     | |   "
  $report_file.puts "| (___   __ _| | ___  ___  | |__) |___ _ __   ___  _ __| |_  "
  $report_file.puts " \\___ \\ / _` | |/ _ \\/ __| |  _  // _ \\ '_ \\ / _ \\| '__| __| "
  $report_file.puts " ____) | (_| | |  __/\\__ \\ | | \\ \\  __/ |_) | (_) | |  | |_  "
  $report_file.puts "|_____/ \\__,_|_|\\___||___/ |_|  \\_\\___| .__/ \\___/|_|   \\__| "
  $report_file.puts "                                      | |                    "
  $report_file.puts "                                      |_|                    "
  $report_file.puts
  $report_file.puts
end

# Print "Brands" in ascii art
def print_brands_header
  $report_file.puts " _                         _     "
  $report_file.puts "| |                       | |    "
  $report_file.puts "| |__  _ __ __ _ _ __   __| |___ "
  $report_file.puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
  $report_file.puts "| |_) | | | (_| | | | | (_| \\__ \\"
  $report_file.puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
  $report_file.puts
  $report_file.puts
end

def product_report

  def amount_sale(item)
    amount = item["purchases"].inject(0) { |amt, purchase| amt + purchase["price"] }
    return amount.to_f
  end

  print_sales_report_header
  print_products_header

  $products_hash["items"].each do |_item|
    # Print the name of the toy
    print("title : " + _item["title"])
     # Print the retail price of the toy
    print("price : $ " + _item["full-price"])
    # Calculate and print the total number of purchases
    purchs_size = _item["purchases"].size.to_i
    print("purchases : " + purchs_size.to_s)
    # Calculate and print the total amount of sales
    amt = amount_sale(_item)
    print("amount of sales : $ " + amt.to_s)
    # Calculate and print the average price the toy sold for
    avg = amt / purchs_size
    print("average price : $ " + avg.round(3).to_s)
    # Calculate and print the average discount (% or $) based off the average sales price
    discount = _item["full-price"].to_f - avg.to_f
    print("average discount : $ " + discount.round(3).to_s)
    print("")
  end
end

def brand_report

  def brand_details(brand)
    # print name
    print("brand name : " + brand)
    total_stock = 0
    total_price = 0
    total_sale = 0
    brand_products = $products_hash['items'].select {|_item| _item['brand'] == brand}

    brand_products.each do |_product|
      total_stock += _product['stock']
      total_price += _product['full-price'].to_f
      _product['purchases'].each do |_purchases|
        total_sale += _purchases['price'].round(3)
      end
    end

    avg = (total_price / brand_products.length).round(3)
    print("total_stock (no of products) : " + total_stock.to_s)
    # Calculate and print the average price of the brand's toys
    print("Average Product Price: $ " + avg.to_s)
    # Calculate and print the total sales volume of all the brand's toys combine
    print("Total Sales : $ " + total_sale.round(3).to_s)
    print("")
  end

  print_brands_header
  # array of brand name
  brands = $products_hash["items"].map{|_item| _item["brand"]}.uniq

  brands.each do |_brand|
    brand_details(_brand)
  end
end

def create_report
    # Print today's date
    print_date

    # Products report
    product_report

    # Brand report
    brand_report
end

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end

start # call start method to trigger report generation
