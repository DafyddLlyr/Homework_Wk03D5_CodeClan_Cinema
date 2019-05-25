class Screening

  attr_accessor :screening_time, :tickets_sold
  attr_reader :id, :capacity, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"].to_i
    @screening_time = Time.parse(options["screening_time"]).strftime("%k:%M")
    @capacity = options["capacity"]
    @tickets_sold = options["tickets_sold"].to_i
  end

  def save()
    sql = "INSERT INTO screenings(film_id, screening_time, capacity, tickets_sold)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@film_id, @screening_time, @capacity, 0]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, capacity, tickets_sold) = ($1, $2, $3)
    WHERE id = $4"
    values = [@screening_time, @capacity, @tickets_sold, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def sell_ticket()
    @tickets_sold += 1
    self.update()
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
