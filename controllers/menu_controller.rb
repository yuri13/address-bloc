require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # #2
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    # #3
    selection = gets.to_i
    # #Use case statement operator to determine proper response to user input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"
        # #Terminate the program using exit(0)
        exit(0)
      # #use else to catch invalid response and prompt user to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  # #stub the rest of the methods
  def view_all_entries
    # #Iterate through all entries in Address Book using each
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
    # #Call entry_submenu to display a sub menu for each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    # #Clear the screen before displaying create entry prompts
    system "clear"
    puts "New AddressBloc Entry"
    # #use print to prompt the user for each entry attribute
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # #adds a new entry to address book using add entry
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries

    # #stores name user want to search for in name
    print "Search by name: "
    name = gets.chomp
    # #call search on address_book and returns match or nil
    match = address_book.binary_search(name)
    system "clear"
    # #if search returns match then helper submenu is called, displaying list of operations
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end

  end

  def read_csv

    # #prompt user to name of CSV file and chomp removes newlines
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # #check to see if filename empty, if it is return to main menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # #import specified file than clear screen and print number of entries
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end

  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    # #gets.chomp gets user input and assigns it appropriately named variable
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    # #sets attribute on entry only if a valid attribute was read
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    # #print out entry with updated results
    puts "Updated entry:"
    puts entry
  end

  def entry_submenu(entry)
      # #display submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

      # #removes any trailing whitespace from string gets returns
    selection = gets.chomp

    case selection
      # #next entry nothing now,
      when "n"
      # #delete and edit will be done in another checkpoint
      when "d"
        # #when user chooses d delete_entry is called
        delete_entry(entry)
      when "e"
        # #when user chooses e edit_entry is called and entry_submenu displayed
        edit_entry(entry)
        entry_submenu(entry)
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end

  def search_submenu(entry)
    # #print out submenu for entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # #save user input to selection
    selection = gets.chomp

    # #use case statement to take a specific action based on user input
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end

end
