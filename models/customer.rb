class Customer

  attr_accessor :name, :funds

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
