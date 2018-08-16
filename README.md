# README

1. Making a POST request to create an Account
* Route: /api/accounts
* Requres name to create an account
* Send a name in the body of the request under account[name] 
* Response will send back the password created by the system to access the account info
2. Making a GET request to view account info
* Route: /api/accounts/:account_num
* Requires password to access account info
* Send the password in the parameters of the request under account[password]
3. Making a deposit 
* Route: /api/accounts/deposit/:account_num
* Requires password to access account info
* Send the password and the deposit amount in the parameters or the body
of the request under account[password], account[amount]
4. Making a withdrawal
* Route: /api/accounts/withdraw/:account_num
* Requires password to access account info
* Send the password and the deposit amount in the parameters or the body
of the request under account[password], account[amount]