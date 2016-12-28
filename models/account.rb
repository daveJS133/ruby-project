require_relative('../db/sql_runner.rb')


class Account

  attr_reader :id, :type, :income, :expenses, :balance
  

  def initialize(options)
    @id = nil || options['id'].to_i 
    @type = options['type']
    @income = options['income']
    @expenses = options['expenses']
    @user_id = options['user_id']
    @balance = options['balance']
  end

  def save(id)
   
    sql = "INSERT INTO accounts (type, user_id) 
    VALUES ('#{type}', #{id})
    RETURNING *;"

    results = SqlRunner.run(sql)
    @id = results[0]['id'].to_i
  end

  def self.get_accounts( id )
    sql = "SELECT * FROM accounts WHERE @user_id = #{id}"
    results = SqlRunner.run(sql)
    return results.map { |pg| Account.new( pg )}
  end

  def self.find( id )
    sql = "SELECT * FROM accounts WHERE @user_id=#{id}"
    results = SqlRunner.run( sql )
    return Accounts.new( results.first )
  end

  def get_account_transactions(id )
    sql = "SELECT * FROM transactions WHERE account_id = #{id}"
    results = SqlRunner.run(sql)
    return results.map { |pg| Transaction.new ( pg )}
  end

  # def total_expense()
  #   @expenses = Transaction.get_account_expenses(@id)
   
  #   return @total_expenses
  # end

  # def total_income()
  #  @income = Transaction.get_account_incomes(@id)
   
  #  return @total_income
  # end

  # def balance()
  #   total_income()
  #   total_expense()
    
  #   @balance = @income.to_f - @expenses.to_f
  
  #   return @balance
  # end


    def self.destroy(id)
      sql = "DELETE FROM accounts where account_id = #{id}"
      SqlRunner.run( sql )
    end

    def self.delete_all
      sql = "DELETE FROM accounts"
      SqlRunner.run( sql )
    end


end