require_relative( '../models/user.rb' )
require_relative( '../models/account.rb' )
require_relative( '../models/transaction.rb' )
require('pry')

User.delete_all
Account.delete_all
Transaction.delete_all


user1 = User.new({

'name' => 'Dave',
'total_income' => 0,
'total_expenses' => 0,
'total_balance' => 0
  })

user2 = User.new({

'name' => 'Bob',
'total_income' => 0.00,
'total_expenses' => 0.00,
'total_balance' => 0
  })

account1 = Account.new({

  'type' => 'Current Account',
  # 'income' => 0.00,
  # 'expenses' => 0.00,
  # 'balance' => 0
  })

transaction1 = Transaction.new({
  'type' => 'debit',
  'merchant' => 'Tesco',
  'tag' => 'Food',
  'out' => "Expense",
  'amount' => 50



  })

user1.save()
user2.save()
user1.total_income()
user1.total_expenses()

user2.total_income()
user2.total_expenses()


account1.save(user1.id)
account1.save(user2.id)

transaction1.save(account1.id, user1.id)
transaction1.save(account1.id, user2.id)

binding.pry
nil
