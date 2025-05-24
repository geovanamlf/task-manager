# Task Manager

tasks = []

def show_menu
  puts "\n=== TASK MANAGER ==="
  puts "1. Add task"
  puts "2. List tasks"
  puts "3. Mark task as completed"
  puts "4. Remove task"
  puts "5. Exit"
  print "Choose an option: "
end

loop do
  show_menu
  option = gets.chomp.to_i

  case option
  when 1
    print "Enter the task description: "
    description = gets.chomp
    tasks << { description: description, completed: false }
    puts "Task added."
  when 2
    puts "\n--- TASK LIST ---"
    if tasks.empty?
      puts "No tasks found."
    else
      tasks.each_with_index do |task, index|
        status = task[:completed] ? "[✔]" : "[ ]"
        puts "#{index + 1}. #{status} #{task[:description]}"
      end
    end
  when 3
    print "Enter the task number to mark as completed: "
    index = gets.chomp.to_i - 1
    if tasks[index]
      tasks[index][:completed] = true
      puts "Task marked as completed."
    else
      puts "Invalid task number."
    end
  when 4
    print "Enter the task number to remove: "
    index = gets.chomp.to_i - 1
    if tasks[index]
      tasks.delete_at(index)
      puts "Task removed."
    else
      puts "Invalid task number."
    end
  when 5
    puts "Exiting... Bye!"
    break
  else
    puts "Invalid option. Please try again."
  end
end

