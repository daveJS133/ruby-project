require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/account.rb' )
require_relative( '../models/user.rb' )
require_relative( '../models/transaction.rb' )


get '/' do
  @users = User.get_all()
  erb ( :"users/index" )
end


get '/user/:user_id/show' do
  @user = User.find(params[:user_id])

  @total_expenses = @user.total_expense()
  @total_income = @user.total_income()
  erb ( :"users/show" )
end


get '/new' do 
  erb ( :"users/new" )
end


get '/:user/:account/new' do
  @user = User.find( :user )

  erb(:"accounts/new")
end


post '/accounts' do
  account = Account.new(params)
  account.save
  redirect to("/:user/accounts")
end


post '/accounts/:id/delete' do
  Account.destroy(params[:id])
  redirect to("/accounts")
end