require_relative('../db/sql_runner.rb')
require('pry')

class User

  attr_reader :id
  attr_accessor :name, :total_balance, :total_income, :total_expenses 

  def initialize(options)
    @id = nil || options['id'].to_i 
    @name = options['name']
    @total_income = options['total_income'].to_f
    @total_expenses = options['total_expenses'].to_f
    @total_balance = options['total_balance'].to_f
  end
  
  def self.get_all()
   sql = "SELECT * FROM users;"
   results = SqlRunner.run(sql)
   return results.map { |user| User.new(user) }
  end

 def save()
    sql = "INSERT INTO users (name, total_income, total_expenses, total_balance ) 
    VALUES ('#{name}', #{total_income}, #{total_expenses}, #{total_balance})
    RETURNING *;"

    results = SqlRunner.run(sql)
    @id = results[0]['id'].to_i
  end

  def self.find( id )
    sql = "SELECT * FROM users WHERE id = #{id};"
    results = SqlRunner.run( sql )
    return User.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM users;"
    SqlRunner.run( sql )
  end

  def total_expense()
    @total_expenses = Transaction.get_expenses(@id)
    balance()
    return @total_expenses
  end

  def total_income()
   @total_income = Transaction.get_incomes(@id)
   balance()
   return @total_income
  end

  def balance()
    @balance = @total_income.to_f - @total_expenses.to_f
    return @balance
  end

end
