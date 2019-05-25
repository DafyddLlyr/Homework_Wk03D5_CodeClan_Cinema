class Ticket

  attr_reader :film, :customer

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer = options["customer"]
    @film = options["film"]
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES
    ($1, $2) RETURNING id"
    values = [@customer, @film]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
  end

  def delete()
  end

  def self.all()
  end

  def self.delete_all()
  end

end
