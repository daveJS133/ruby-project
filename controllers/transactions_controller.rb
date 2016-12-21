require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/account.rb' )
require_relative( '../models/user.rb' )
require_relative( '../models/option.rb' )

get '/:user_id/transactions' do
  @transactions = Transaction.get_all(params[:user_id])
  @user = User.find(params[:user_id])
  @options = Options.all
  erb ( :"transactions/index" )
end

post '/:user_id/transactions' do
  if params[:filter] == "*" then 
    @transactions = Transaction.get_all(params[:user_id])
  else
    @transactions = Transaction.get_transactions_filter( params[:filter], params[:user_id])
  end
  @user = User.find(params[:user_id])
  @options = Options.all
  erb ( :"transactions/index" )
end

get '/:user_id/transactions/new' do
  @user = User.find(params[:user_id])
  @accounts = Account.get_accounts(@user.id)
  @options = Options.all
  erb(:"transactions/new")
end

post '/:user_id/transactions/new' do
  @user = User.find( params[:user_id] )
  
  @options = Options.all
  @transaction = Transaction.new(params)
  @transaction.save(params[:user_id, :account_id])
  redirect to("/:user/transactions")
end
