require_relative('../db/sql_runner.rb')
require('date')
require('pry')

class Transaction

  attr_reader :id, :type, :merchant, :out, :amount, :user_id, :date
  attr_accessor :tag

  def initialize(options)
    @id = nil || options['id'].to_i 
    @type = options['type']
    @merchant = options['merchant']
    @tag = options['tag']
    @out = options['out']
    @account_id = options['account_id']
    @user_id = options['user_id']
    @amount = options['amount']
    @date = options['date']
  end

  def save(account, user)
    @date = Date.today.to_s
    sql = "INSERT INTO transactions (type, merchant, tag, out, account_id, user_id, amount, trans_date) 
    VALUES ('#{@type}', '#{@merchant}', '#{@tag}', '#{@out}', #{account}, #{user}, #{@amount}, '#{@date}' )
    RETURNING *;"

    results = SqlRunner.run(sql)
    @id = results[0]['id'].to_i
    User.find(user).balance
  end

  
  def self.get_all( id )
    
    sql = "SELECT * FROM transactions WHERE user_id = #{id};"
    results = SqlRunner.run(sql) 
    return results.map { |pg| Transaction.new ( pg ) } 
  end

  def self.get_transactions_filter( filter, id )
    filter ||= nil
    sql = "SELECT * FROM transactions WHERE user_id = #{id} AND tag = '#{filter}';"
    results = SqlRunner.run(sql) 
    return results.map { |pg| Transaction.new ( pg ) } 
  end

  def self.get_expenses( id )
    sql = "SELECT amount FROM transactions WHERE user_id = #{id} AND out = 'Expense'"
    results = SqlRunner.run(sql)
    results = results.map { |pg| Transaction.new ( pg ) } 
    total = 0
    for transaction in results
      total += transaction.amount.to_f

    end
    return total

  end

  def self.get_incomes( id )

    sql = "SELECT amount FROM transactions WHERE user_id = #{id} AND out = 'Income'"
    results = SqlRunner.run(sql)
    results = results.map { |pg| Transaction.new ( pg ) } 
    total = 0
    for transaction in results
      total += transaction.amount.to_f
    end
    return total

  end

  # def self.get_account_expenses( id )
  #   sql = "SELECT amount FROM transactions WHERE account_id = #{id} AND out = 'Expense'"
  #   results = SqlRunner.run(sql)
  #   results = results.map { |pg| Transaction.new ( pg ) } 
  #   total = 0
  #   for transaction in results
  #     total += transaction.amount.to_f

  #   end
  #   return total

  # end

  # def self.get_account_incomes( id )

  #   sql = "SELECT amount FROM transactions WHERE account_id = #{id} AND out = 'Income'"
  #   results = SqlRunner.run(sql)
  #   results = results.map { |pg| Transaction.new ( pg ) } 
  #   total = 0
  #   for transaction in results
  #     total += transaction.amount.to_f
  #   end
  #   return total

  # end

  def self.destroy(id)
    sql = "DELETE FROM transactions WHERE id = #{id}"
    SqlRunner.run( sql )
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end
  

end