require 'pg'
require_relative 'lib/database'
require_relative 'lib/task_functions'

conn = Database.connect_db

loop do
  show_menu
  option = gets.chomp.to_i

  case option
  when 1
    add_task(conn)
  when 2
    list_tasks(conn)
  when 3
    complete_task(conn)
  when 4
    remove_task(conn)
  when 5
    puts "Exiting... Bye!"
    conn.close
    break
  else
    puts "Invalid option. Please try again."
  end
end


