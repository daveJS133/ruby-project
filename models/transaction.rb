require('sql_runner.rb')


class Account

  attr_reader :id, :type, :merchant, :out
  attr_accessor :tag

  def initialize
    @id = nil || options['id'].to_i 
    @type = options['type']
    @merchant = options['merchant']
    @tag = options['tag']
    @out = options['out']
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