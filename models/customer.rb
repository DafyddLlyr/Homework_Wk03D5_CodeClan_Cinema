class Customer

  attr_accessor :name
  attr_reader :id, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

  def save()
    sql = "INSERT INTO customers(name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1
    ORDER BY films.title"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |film| Film.new(film) }
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |ticket| Ticket.new(ticket) }
  end

  def ticket_count()
    return self.tickets.count()
  end

  def buy(film, screening)
    return "Insufficient funds" if film.price > @funds
    return "Sold out" if screening.customer_count >= screening.capacity

    ticket = Ticket.new({"customer_id" => @id, "film_id" => film.id, "screening_id" => screening.id})
    ticket.save()

    @funds -= film.price
    self.update()
  end

  def self.all()
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    return result.map { |customer| Customer.new(customer) }
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
