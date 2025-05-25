module Database
  def self.connect_db
    PG.connect(
      dbname: 'taskmanager',
      user: 'geovana-lemos',
      password: '91480908',
      host: 'localhost'
    )
  end
end

