require('sql_runner.rb')


class Account

  attr_reader :id, :type
  attr_accessor :transactions, :income, :expenses 

  def initialize
    @id = nil || options['id'].to_i 
    @type = options['type']
    @transactions = options['transactions']
    @income = options['income']
    @expenses = options['expenses']
  end

  def save()


  end

  def self.get_all()


  end

  def update()

  end

  def delete()

  end

 
  


end