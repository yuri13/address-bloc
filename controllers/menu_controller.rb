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
    puts "5 - View Entry n"
    puts "6 - Exit"
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
        system "clear"
        entry_n_submenu
        main_menu
      when 6
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

  def entry_n_submenu
    print "Entry number to view: "
    selection = gets.chomp.to_i

    if selection < @address_book.entries.count
      puts @address_book.entries[selection]
      puts "Press enter to return to the main menu"
      gets.chomp
      system "clear"
    else
      puts "#{selection} is not a valid input"
      entry_n_submenu
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
  end

  def read_csv
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
      when "e"
      # #return user to main menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end
end
