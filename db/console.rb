require_relative("sql_runner")
require_relative("../models/ticket")
require_relative("../models/customer")
require("pry")

Customer.delete_all()

customer_1 = Customer.new({"name" => "Dafydd", "funds" => 100})
customer_1.save()

customer_2 = Customer.new({"name" => "Sion", "funds" => 200})
customer_2.save()

binding.pry
nil
