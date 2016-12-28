require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/account.rb' )
require_relative( '../models/user.rb' )

get '/:user_id/accounts' do
  @accounts = Account.get_accounts(params[:user_id])
  # @balance = Account.balance()
  erb ( :"/accounts/index" )
end

# get '/:user_id/new' do
#   @user = User.find( :user_id )
# 
#   erb(:"accounts/new")
# end

post '/:user_id/accounts' do
  account = Account.new(params)
  account.save
  redirect to("/:user_id/accounts")
end

get '/:user_id/ ' do
  @accounts = Account.get_accounts(params[:user_id])
  # @balance = Account.balance()
  erb ( :"accounts/index" )
end

post '/accounts/:id/delete' do
  Account.destroy(params[:id])
  redirect to("/accounts")
end