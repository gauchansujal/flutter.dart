// BankAccount demonstrating Encapsulation
class BankAccount {
  // Private fields
  String _accountNumber;
  String _accountHolderName;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolderName, this._balance);

  // Getters
  String get accountNumber => _accountNumber;
  String get accountHolderName => _accountHolderName;
  double get balance => _balance;

  // Setters with validation
  set accountHolderName(String name) => _accountHolderName = name;

  set balance(double amount) {
    if (amount >= 0) {
      _balance = amount;
    } else {
      print('Balance cannot be negative.');
    }
  }

  // Deposit method
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited \$${amount}. New balance: \$${_balance}');
    } else {
      print('Deposit amount must be positive.');
    }
  }

  // Withdraw method
  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Withdrew \$${amount}. Remaining balance: \$${_balance}');
    } else {
      print('Invalid withdrawal amount.');
    }
  }

  // Display account information
  void displayInfo() {
    print('Account Number: $_accountNumber');
    print('Account Holder: $_accountHolderName');
    print('Balance: \$$_balance');
  }
}

// Bank class demonstrating Encapsulation
class Bank {
  List<BankAccount> _accounts = []; // private list of accounts

  // Add new account
  void createAccount(BankAccount account) {
    _accounts.add(account);
    print('Account created for ${account.accountHolderName}');
  }

  // Find account by account number
  BankAccount? findAccount(String accNum) {
    try {
      return _accounts.firstWhere((acc) => acc.accountNumber == accNum);
    } catch (e) {
      return null;
    }
  }

  // Generate report for all accounts
  void generateReport() {
    print('--- Bank Accounts Report ---');
    for (var acc in _accounts) {
      acc.displayInfo();
      print('--------------------------');
    }
  }
}

// Demonstration using main
void main() {
  Bank myBank = Bank();

  BankAccount acc1 = BankAccount('ACC001', 'Alice', 1000);
  BankAccount acc2 = BankAccount('ACC002', 'Bob', 500);

  myBank.createAccount(acc1);
  myBank.createAccount(acc2);

  acc1.deposit(500);
  acc2.withdraw(200);

  myBank.generateReport();

  // Testing setters
  acc1.balance = -100; // Should not allow
  acc1.accountHolderName = 'Alice Cooper';
  acc1.displayInfo();
}
