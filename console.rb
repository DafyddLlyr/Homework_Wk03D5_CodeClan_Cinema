require_relative("db/sql_runner")
require_relative("models/ticket")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/screening")
require("time")
require("pry")

Customer.delete_all()
Film.delete_all()

customer_1 = Customer.new({"name" => "Dafydd", "funds" => 100})
customer_1.save()

customer_2 = Customer.new({"name" => "Sion", "funds" => 200})
customer_2.save()

film_1 = Film.new({"title" => "Casino Royale", "price" => 5})
film_1.save()

film_2 = Film.new({"title" => "Skyfall", "price" => 10})
film_2.save()

ticket_1 = Ticket.new("customer_id" => customer_1.id, "film_id" => film_1.id)
ticket_1.save()

ticket_2 = Ticket.new("customer_id" => customer_2.id, "film_id" => film_1.id)
ticket_2.save()

screening_1 = Screening.new(
  "film_id" => film_1.id,
  "number_of_tickets" => 10,
  "screening_time" => "22:00")
screening_1.save()

screening_2 = Screening.new(
  "film_id" => film_2.id,
  "number_of_tickets" => 20,
  "screening_time" => "17:45"
)
screening_2.save


binding.pry
nil
