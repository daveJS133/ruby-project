require('sql_runner.rb')


class User

  attr_reader :id, :name
  attr_accessor :total_income, :total_expenses 

  def initialize
    @id = nil || options['id'].to_i 
    @name = options['name']
    @total_income = options['total_income']
    @total_expenses = options['total_expenses']
  end

  def save()


  end

  def delete()

  end


  


end