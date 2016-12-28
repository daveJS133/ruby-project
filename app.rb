require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/transactions_controller')
require_relative('controllers/accounts_controller')
require_relative('controllers/users_controller')

get '/' do
  @users = User.get_all()
  erb ( :"users/index" )
end

