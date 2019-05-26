class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
    @screening_id = options["screening_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    return result.map { |ticket| Ticket.new(ticket) }
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
