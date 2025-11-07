// Abstract base class demonstrating Abstraction
abstract class BankAccount {
  // Private fields
  String _accountNumber;
  String _accountHolderName;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolderName, this._balance);

  // Getters
  String get accountNumber => _accountNumber;
  String get accountHolderName => _accountHolderName;
  double get balance => _balance;

  // Setters
  set accountHolderName(String name) => _accountHolderName = name;
  set balance(double amount) => _balance = amount;

  // Abstract methods
  void deposit(double amount);
  void withdraw(double amount);

  // Concrete method
  void displayInfo() {
    print('Account Number: $_accountNumber');
    print('Account Holder: $_accountHolderName');
    print('Balance: \$$_balance');
  }
}

// Interface for interest-bearing accounts
abstract class InterestBearing {
  double calculateInterest();
}

// Savings Account
class SavingsAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 500;
  static const int maxWithdrawals = 3;
  int _withdrawalsThisMonth = 0;

  SavingsAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void deposit(double amount) {
    balance += amount;
    print('Deposited \$${amount}. New balance: \$${balance}');
  }

  @override
  void withdraw(double amount) {
    if (_withdrawalsThisMonth >= maxWithdrawals) {
      print('Withdrawal limit reached for this month.');
      return;
    }
    if (balance - amount < minBalance) {
      print('Cannot withdraw. Minimum balance: \$${minBalance}');
      return;
    }
    balance -= amount;
    _withdrawalsThisMonth++;
    print('Withdrew \$${amount}. Remaining balance: \$${balance}');
  }

  @override
  double calculateInterest() => balance * 0.02;
}

// Checking Account
class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35;

  CheckingAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void deposit(double amount) {
    balance += amount;
    print('Deposited \$${amount}. New balance: \$${balance}');
  }

  @override
  void withdraw(double amount) {
    balance -= amount;
    if (balance < 0) {
      balance -= overdraftFee;
      print(
        'Overdraft! \$${overdraftFee} fee applied. New balance: \$${balance}',
      );
    } else {
      print('Withdrew \$${amount}. Remaining balance: \$${balance}');
    }
  }
}

// Premium Account
class PremiumAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 10000;

  PremiumAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void deposit(double amount) {
    balance += amount;
    print('Deposited \$${amount}. New balance: \$${balance}');
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < minBalance) {
      print('Cannot withdraw. Minimum balance: \$${minBalance}');
      return;
    }
    balance -= amount;
    print('Withdrew \$${amount}. Remaining balance: \$${balance}');
  }

  @override
  double calculateInterest() => balance * 0.05;
}

// Bank class
class Bank {
  List<BankAccount> accounts = [];

  void createAccount(BankAccount account) {
    accounts.add(account);
    print('Account created for ${account.accountHolderName}');
  }

  BankAccount? findAccount(String accNum) {
    try {
      return accounts.firstWhere((acc) => acc.accountNumber == accNum);
    } catch (e) {
      return null;
    }
  }

  void transfer(String fromAccNum, String toAccNum, double amount) {
    BankAccount? fromAcc = findAccount(fromAccNum);
    BankAccount? toAcc = findAccount(toAccNum);

    if (fromAcc == null || toAcc == null) {
      print('One or both accounts not found.');
      return;
    }

    fromAcc.withdraw(amount);
    toAcc.deposit(amount);
    print(
      'Transferred \$${amount} from ${fromAcc.accountHolderName} to ${toAcc.accountHolderName}',
    );
  }

  void generateReport() {
    print('--- Bank Accounts Report ---');
    for (var acc in accounts) {
      acc.displayInfo();

      // Dart 2.x: manually cast to InterestBearing if implemented
      if (acc is InterestBearing) {
        InterestBearing interestAcc = acc as InterestBearing;
        print('Interest: \$${interestAcc.calculateInterest()}');
      }

      print('--------------------------');
    }
  }
}

// Demonstration
void main() {
  Bank myBank = Bank();

  SavingsAccount sa = SavingsAccount('SA001', 'Alice', 1000);
  CheckingAccount ca = CheckingAccount('CA001', 'Bob', 500);
  PremiumAccount pa = PremiumAccount('PA001', 'Charlie', 20000);

  myBank.createAccount(sa);
  myBank.createAccount(ca);
  myBank.createAccount(pa);

  sa.withdraw(200);
  ca.withdraw(600);
  pa.deposit(5000);

  myBank.transfer('PA001', 'SA001', 3000);

  myBank.generateReport();
}
