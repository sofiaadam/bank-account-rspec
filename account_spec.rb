require "rspec"
require_relative "account"

describe Account do

  let(:valid_acct_number) {"1234567890"}
  let(:invalid_acct_number) {"12345678"}
  let(:account) {Account.new(valid_acct_number)}


  describe "#initialize" do
    context "with invalid input" do
      it "throws an argument error when not given a type argument" do
        expect { Account.new }.to raise_error(ArgumentError)
      end
    end

  end

  describe "#transactions" do
    it "starts with array with one entry being zero" do
      expect(account.transactions).to be == [0]
    end
  end

  describe "#balance" do
    it "sums up all the transactions" do
      account.transactions << 6
      account.transactions << 9
      account.transactions << -2
      expect(account.balance).to be == 13
    end
  end

  describe "#account_number" do
    context "invalid account number" do
      it "raises an error" do
        expect{Account.new(invalid_acct_number)}.to raise_error(InvalidAccountNumberError)
      end
    end

    context "valid account number" do
      it "returns an object" do
        expect(Account.new(valid_acct_number)).to be_kind_of(Object)
      end
    end

  end

  describe "deposit!" do
    context "with invalid input" do
      it "requires an integer argument" do
        expect{account.deposit!("hello")}.to raise_error(ArgumentError)
      end
    end

    context "with negative amount" do
      it "should raise a negative amount error" do
          expect{account.deposit!(-4)}.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    context "with invalid input" do
      it "requires an integer argument" do
        expect{account.withdraw!("hello")}.to raise_error(ArgumentError)
      end
    end

    it "overdraft error if balance is less than zero" do
      account.transactions << -25
      expect{account.withdraw!(-2)}.to raise_error(OverdraftError)
    end
  end
end