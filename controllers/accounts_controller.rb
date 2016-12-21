require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/account.rb' )
require_relative( '../models/user.rb' )

get '/:user_id/accounts' do
  @accounts = Account.get_accounts(params[:user_id])
  erb ( :"accounts/index" )
end

get '/:user_id/:account_id/new' do
  @user = User.find( :user )

  erb(:"accounts/new")
end

post '/:user_id/accounts' do
  account = Account.new(params)
  account.save
  redirect to("/:user_id/accounts")
end

post '/accounts/:id/delete' do
  Account.destroy(params[:id])
  redirect to("/accounts")
end