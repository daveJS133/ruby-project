require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/transactions_controller')
require_relative('controllers/accounts_controller')
require_relative('controllers/users_controller')

get '/' do

  # def get_users()
  #   sql = "SELECT * FROM users"
  #   results = SqlRunner.run(sql)
  #   @id = results.map { |pg| User.new ( pg )}
  # end
  erb( :"users/index" )
end

