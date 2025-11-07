// Base class demonstrating Inheritance
class BankAccount {
  String accountNumber;
  String accountHolderName;
  double balance;

  BankAccount(this.accountNumber, this.accountHolderName, this.balance);

  void deposit(double amount) {
    balance += amount;
    print('$accountHolderName deposited \$${amount}. Balance: \$${balance}');
  }

  void withdraw(double amount) {
    if (amount <= balance) {
      balance -= amount;
      print(
        '$accountHolderName withdrew \$${amount}. Remaining balance: \$${balance}',
      );
    } else {
      print('$accountHolderName: Insufficient funds.');
    }
  }

  void displayInfo() {
    print('Account Number: $accountNumber');
    print('Account Holder: $accountHolderName');
    print('Balance: \$${balance}');
  }
}

// SavingsAccount inherits from BankAccount
class SavingsAccount extends BankAccount {
  static const double minBalance = 500;
  int withdrawalsThisMonth = 0;

  SavingsAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

  @override
  void withdraw(double amount) {
    if (withdrawalsThisMonth >= 3) {
      print('SavingsAccount: Withdrawal limit reached.');
      return;
    }
    if (balance - amount < minBalance) {
      print('SavingsAccount: Cannot withdraw. Minimum balance \$${minBalance}');
      return;
    }
    balance -= amount;
    withdrawalsThisMonth++;
    print(
      'SavingsAccount: Withdrew \$${amount}. Remaining balance: \$${balance}',
    );
  }
}

// CheckingAccount inherits from BankAccount
class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35;

  CheckingAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

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

// PremiumAccount inherits from BankAccount
class PremiumAccount extends BankAccount {
  static const double minBalance = 10000;

  PremiumAccount(String accNum, String holder, double balance)
    : super(accNum, holder, balance);

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

  void generateReport() {
    print('--- Bank Accounts Report ---');
    for (var acc in accounts) {
      acc.displayInfo();
      print('--------------------------');
    }
  }
}

// Main function
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
  pa.withdraw(5000);

  myBank.generateReport();
}
