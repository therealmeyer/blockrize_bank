json.extract! @account, :account_num, :name
json.amount "$" + ("%.2f" % @account.amount.truncate(2))
json.your_password @account.password
