// Base class for Polymorphism demonstration
abstract class BankAccount {
  String accountNumber;
  String accountHolderName;
  double balance;

  BankAccount(this.accountNumber, this.accountHolderName, this.balance);

  // Methods to be overridden
  void deposit(double amount);
  void withdraw(double amount);

  void displayInfo() {
    print('Account Number: $accountNumber');
    print('Account Holder: $accountHolderName');
    print('Balance: \$${balance}');
  }
}

// Savings Account
class SavingsAccount extends BankAccount {
  static const double minBalance = 500;
  static const int maxWithdrawals = 3;
  int _withdrawalsThisMonth = 0;

  SavingsAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void deposit(double amount) {
    balance += amount;
    print('SavingsAccount: Deposited \$${amount}. New balance: \$${balance}');
  }

  @override
  void withdraw(double amount) {
    if (_withdrawalsThisMonth >= maxWithdrawals) {
      print('SavingsAccount: Withdrawal limit reached.');
      return;
    }
    if (balance - amount < minBalance) {
      print('SavingsAccount: Cannot withdraw. Minimum balance \$${minBalance}');
      return;
    }
    balance -= amount;
    _withdrawalsThisMonth++;
    print(
      'SavingsAccount: Withdrew \$${amount}. Remaining balance: \$${balance}',
    );
  }
}

// Checking Account
class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35;

  CheckingAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void deposit(double amount) {
    balance += amount;
    print('CheckingAccount: Deposited \$${amount}. New balance: \$${balance}');
  }

  @override
  void withdraw(double amount) {
    balance -= amount;
    if (balance < 0) {
      balance -= overdraftFee;
      print(
        'CheckingAccount: Overdraft! Fee \$${overdraftFee} applied. New balance: \$${balance}',
      );
    } else {
      print(
        'CheckingAccount: Withdrew \$${amount}. Remaining balance: \$${balance}',
      );
    }
  }
}

// Premium Account
class PremiumAccount extends BankAccount {
  static const double minBalance = 10000;

  PremiumAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void deposit(double amount) {
    balance += amount;
    print('PremiumAccount: Deposited \$${amount}. New balance: \$${balance}');
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < minBalance) {
      print('PremiumAccount: Cannot withdraw. Minimum balance \$${minBalance}');
      return;
    }
    balance -= amount;
    print(
      'PremiumAccount: Withdrew \$${amount}. Remaining balance: \$${balance}',
    );
  }
}

// Bank class
class Bank {
  List<BankAccount> accounts = [];

  void createAccount(BankAccount account) {
    accounts.add(account);
    print('Account created for ${account.accountHolderName}');
  }

  void performTransactions() {
    print('\n--- Performing Transactions (Polymorphism Demo) ---');
    for (var acc in accounts) {
      acc.deposit(500); // same method call, different behavior
      acc.withdraw(700); // same method call, different behavior
    }
  }

  void generateReport() {
    print('\n--- Bank Accounts Report ---');
    for (var acc in accounts) {
      acc.displayInfo();
      print('--------------------------');
    }
  }
}

// Main function
void main() {
  Bank myBank = Bank();

  BankAccount sa = SavingsAccount('SA001', 'Alice', 1000);
  BankAccount ca = CheckingAccount('CA001', 'Bob', 500);
  BankAccount pa = PremiumAccount('PA001', 'Charlie', 20000);

  myBank.createAccount(sa);
  myBank.createAccount(ca);
  myBank.createAccount(pa);

  myBank.performTransactions(); // Polymorphism in action
  myBank.generateReport();
}
