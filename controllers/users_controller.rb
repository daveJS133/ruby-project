require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/account.rb' )
require_relative( '../models/user.rb' )
require_relative( '../models/transaction.rb' )


get '/user/:user_id/show' do
  @user = User.find(params[:user_id])

  @total_expenses = @user.total_expense()
  @total_income = @user.total_income()
  @total_balance = @user.balance()
  erb ( :"users/show" )
end


get '/new' do 
  erb ( :"users/new" )
end

post '/:user_id/delete' do
  User.destroy(params[:user_id])
  redirect to("/")
end

post '/new' do
  @user = User.new(params())
  @user.save()
  redirect to("/")

end


# get '/:user_id/:account_id/new' do
#   @user = User.find( params[:user_id] )
#   @account = Account.find( params[:account_id] )
#   erb(:"accounts/new")
# end


# post '/accounts' do
#   account = Account.new(params)
#   account.save
#   redirect to("/:user/accounts")
# end


# post '/accounts/:id/delete' do
#   Account.destroy(params[:id])
#   redirect to("/accounts")
# end