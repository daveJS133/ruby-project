class Options
  def self.all
    return { tags: ["*", "Food", "Car", "Clothes", "Household", "Rent"], out: ["Income", "Expense"], type: ["Cash", "Card", "Credit Card", "Direct Debit", "Bank Transfer", "PayPal", "Online Payment"]
            }
  end
end