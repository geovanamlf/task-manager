# Task Manager with PostgreSQL

require 'pg'

# Conexão com o banco
conn = PG.connect(
  dbname: 'taskmanager',
  user: 'geovana-lemos',
  password: '91480908',
  host: 'localhost'
)

# === Funções ===

def show_menu
  puts "\n=== TASK MANAGER ==="
  puts "1. Add task"
  puts "2. List tasks"
  puts "3. Mark task as completed"
  puts "4. Remove task"
  puts "5. Exit"
  print "Choose an option: "
end

def add_task(conn)
  print "Enter task description: "
  description = gets.chomp

  conn.exec_params(
    "INSERT INTO tasks (description) VALUES ($1)",
    [description]
  )

  puts "Task added."
end

def list_tasks(conn)
  result = conn.exec("SELECT * FROM tasks ORDER BY id")

  puts "\n--- TASK LIST ---"
  if result.ntuples == 0
    puts "No tasks found."
  else
    result.each do |row|
      status = row["completed"] == "t" ? "[✔]" : "[ ]"
      puts "#{row['id']}. #{status} #{row['description']}"
    end
  end
end

def complete_task(conn)
  print "Enter the task ID to mark as completed: "
  id = gets.chomp.to_i

  result = conn.exec_params(
    "UPDATE tasks SET completed = true WHERE id = $1",
    [id]
  )

  if result.cmd_tuples == 0
    puts "Task not found."
  else
    puts "Task marked as completed."
  end
end

def remove_task(conn)
  print "Enter the task ID to remove: "
  id = gets.chomp.to_i

  result = conn.exec_params(
    "DELETE FROM tasks WHERE id = $1",
    [id]
  )

  if result.cmd_tuples == 0
    puts "Task not found."
  else
    puts "Task removed."
  end
end

# === Loop ===

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

