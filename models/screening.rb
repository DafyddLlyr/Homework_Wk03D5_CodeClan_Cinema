class Screening

  attr_accessor :screening_time
  attr_reader :id, :capacity, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"].to_i
    @screening_time = Time.parse(options["screening_time"]).strftime("%k:%M")
    @capacity = options["capacity"]
  end

  def save()
    sql = "INSERT INTO screenings(film_id, screening_time, capacity)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@film_id, @screening_time, @capacity]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, capacity) = ($1, $2)
    WHERE id = $3"
    values = [@screening_time, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE screening_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |customer| Customer.new(customer) }
  end

  def customer_count()
    return self.customers.count()
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    return result.map { |screening| Screening.new(screening) }
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
