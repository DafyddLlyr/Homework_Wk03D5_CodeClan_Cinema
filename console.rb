require_relative("db/sql_runner")
require_relative("models/ticket")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/screening")
require("time")
require("pry")

Customer.delete_all()
Film.delete_all()

customer_1 = Customer.new({"name" => "Dafydd", "funds" => 500})
customer_1.save()

customer_2 = Customer.new({"name" => "Aled", "funds" => 200})
customer_2.save()

film_1 = Film.new({"title" => "Casino Royale", "price" => 5})
film_1.save()

film_2 = Film.new({"title" => "Skyfall", "price" => 500})
film_2.save()

screening_1 = Screening.new(
  "film_id" => film_1.id,
  "capacity" => 10,
  "screening_time" => "22:00")
screening_1.save()

screening_2 = Screening.new(
  "film_id" => film_1.id,
  "capacity" => 20,
  "screening_time" => "17:45"
)
screening_2.save

screening_3 = Screening.new(
  "film_id" => film_1.id,
  "capacity" => 20,
  "screening_time" => "23:45"
)
screening_3.save

5.times { customer_1.buy(film_1, screening_1)}
3.times { customer_2.buy(film_1, screening_3)}

binding.pry
nil
