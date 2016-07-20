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
    return amount
  end

  print_sales_report_header
  print_products_header

  $products_hash["items"].each do |_item|
    # Print the name of the toy
    print("title : " + _item["title"])
     # Print the retail price of the toy
    print("price : " + _item["price"])
    # Calculate and print the total number of purchases
    print("purchases : " + _item["purchases"].size)
    # Calculate and print the total amount of sales
    print("amount of sales : " + amount_sale(_item))
    # Calculate and print the average price the toy sold for

  end
end

def brand_report
  print_brands_header

end

def create_report
    # Print today's date
    print_date

    # Products report




    # Calculate and print the average discount (% or $) based off the average sales price
    product_report

    # For each brand in the data set:
    # Print the name of the brand
    # Count and print the number of the brand's toys we stock
    # Calculate and print the average price of the brand's toys
    # Calculate and print the total sales volume of all the brand's toys combined
    brand_report
end

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end

start # call start method to trigger report generation
