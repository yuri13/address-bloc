require_relative 'entry'
require "csv"


class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
      # #9
    index = 0
    entries.each do |entry|
      # #10
      if name < entry.name
        break
      end
        index += 1
    end
      # #11
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  # Defined the method. Starts by reading the file using File.read and uses the CSV
  # class to parse the file
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true)
    # Iterate over the table object's rows
    csv.each do |row|
      # Create a hash for each row
      row_hash = row.to_hash
      # Convert each row_hash to an Entry by using add_entry method
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
    # Get the number of items parsed by calling the count method
    return csv.count
  end

  #search Address Book by specific name
  def binary_search(name)

    # #Saves the index of left most item in lower and right most itme in upper
    lower = 0
    upper = entries.length - 1

    # #loop while lower is less than or equal to upper
    while lower <= upper
      # #sum of lower and upper divided by two
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      # #compare search name to middle index
      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end

    # #if after search no match nil returned
    return nil

  end
end
