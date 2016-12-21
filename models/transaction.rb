require_relative('../db/sql_runner.rb')
require('pry')

class Transaction

  attr_reader :id, :type, :merchant, :out, :amount, :user_id
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
  end

  def save(account, user)
    sql = "INSERT INTO transactions (type, merchant, tag, out, account, user, amount) 
    VALUES ('#{@type}', '#{@merchant}', '#{@tag}', #{@out}, #{account}, #{user}, #{@amount} )
    RETURNING *;"

    results = SqlRunner.run(sql)
    @id = results[0]['id'].to_i
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
    sql = "SELECT amount FROM transactions WHERE user_id = #{id} AND out = True"
    results = SqlRunner.run(sql)
    results = results.map { |pg| Transaction.new ( pg ) } 
    total = 0
    for transaction in results
      total += transaction.amount.to_f
    end
    return total

  end

  def self.get_incomes( id )

    sql = "SELECT amount FROM transactions WHERE user_id = #{id} AND out = False"
    results = SqlRunner.run(sql)
    results = results.map { |pg| Transaction.new ( pg ) } 
    total = 0
    for transaction in results
      total += transaction.amount.to_f
    end
    return total

  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end
  

end