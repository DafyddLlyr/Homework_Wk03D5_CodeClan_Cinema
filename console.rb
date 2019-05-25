require_relative("db/sql_runner")
require_relative("models/ticket")
require_relative("models/customer")
require_relative("models/film")
require("pry")

Customer.delete_all()
Film.delete_all()

customer_1 = Customer.new({"name" => "Dafydd", "funds" => 100})
customer_1.save()

customer_2 = Customer.new({"name" => "Sion", "funds" => 200})
customer_2.save()

film_1 = Film.new({"title" => "Casino Royale", "price" => 5})
film_1.save()


binding.pry
nil
