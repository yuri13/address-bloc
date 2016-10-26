require_relative '../models/address_book'

RSpec.describe AddressBook do
  # create new instance of the AddressBook model and assign it to the variable named book
  let(:book) {AddressBook.new}

  # Create a helper method named check_entry to consolidate redundant code
  def check_entry(entry, expected_name, expected_number, expected_email)
      expect(entry.name).to eql expected_name
      expect(entry.phone_number).to eql expected_number
      expect(entry.email).to eql expected_email
  end

  describe "attributes" do
    it "responds to entries" do
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  # Context and it statements are RSpec paradigm to explain what we are testing
  # it explaing ths functionality of the method being tested in human readable form
  # RSpec will take the content from context and it and output them to the command line
  # Test that AddressBook's .import_from_csv() method is working as expected
  context ".import_from_csv" do
  it "imports the correct number of entries" do
  # After the context and it statements we call import_from_csv method on the book
  # object which is a type of AddressBook (our data model). We pass import_from_csv
  # the string entries.csv as a parameter
  book.import_from_csv("entries.csv")
  # Here we reference the AddressBook.entries variable to get its size and save it
  # to the local variable book_size
  book_size = book.entries.size

  # Check the size of the entries in AddressBook
  expect(book_size).to eql 5
  end

  # Access the first entry in the array of entries that AddressBook stores
  it "imports the 1st entry" do
  book.import_from_csv("entries.csv")
  # Check the first entry
  entry_one = book.entries[0]
      check_entry(entry_one, "Bill", "555-555-5555", "bill@blocmail.com")
  end

  it "imports the 2nd entry" do
    book.import_from_csv("entries.csv")
    # Check the second entry
    entry_two = book.entries[1]
    check_entry(entry_two, "Bob", "555-555-5555", "bob@blocmail.com")
  end

  it "imports the 3rd entry" do
    book.import_from_csv("entries.csv")
    # Check the third entry
    entry_three = book.entries[2]
    check_entry(entry_three, "Joe", "555-555-5555", "joe@blocmail.com")
  end

  it "imports the 4th entry" do
    book.import_from_csv("entries.csv")
    # Check the fourth entry
    entry_four = book.entries[3]
    check_entry(entry_four, "Sally", "555-555-5555", "sally@blocmail.com")
  end

  it "imports the 5th entry" do
    book.import_from_csv("entries.csv")
    # Check the fifth entry
    entry_five = book.entries[4]
    check_entry(entry_five, "Sussie", "555-555-5555", "sussie@blocmail.com")
  end
  end

  +
  context ".import_from_csv" do
    it "imports the correct number of entries" do
      # After the context and it statements we call import_from_csv method on the book
      # object which is a type of AddressBook (our data model). We pass import_from_csv
      # the string entries.csv as a parameter
      book.import_from_csv("entries_2.csv")
      # Here we reference the AddressBook.entries variable to get its size and save it
      # to the local variable book_size
      book_size = book.entries.size

    # Check the size of the entries in AddressBook
    expect(book_size).to eql 3
    end

    # Access the first entry in the array of entries that AddressBook stores
    it "imports the 1st entry" do
      book.import_from_csv("entries_2.csv")
      # Check the first entry
      entry_one = book.entries[0]
      check_entry(entry_one, "John", "555-555-5555", "john@blocmail.com")
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries_2.csv")
      # Check the second entry
      entry_two = book.entries[1]
      check_entry(entry_two, "Vlade", "555-555-5555", "vlade@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries_2.csv")
      # Check the third entry
      entry_three = book.entries[2]
      check_entry(entry_three, "Michael", "555-555-5555", "michael@blocmail.com")
    end
  end
end
