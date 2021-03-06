class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"]
  end

  def save()
    sql = "INSERT INTO films(title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1
    ORDER BY customer.name"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |customer| Customer.new(customer) }
  end

  def customer_count()
    return self.customers.count()
  end

  def screenings()
    sql = "SELECT * FROM screenings WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    all_screenings = result.map { |screening| Screening.new(screening) }
  end

  def show_times()
    all_times =  self.screenings.map { |screening| screening.screening_time }
    return all_times.sort()
  end

  def most_popular_time()
    result = self.screenings.sort_by { |screening| screening.customer_count }.reverse
    return result[0].screening_time
  end

  def self.all()
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql)
    return result.map { |film| Film.new(film) }
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
