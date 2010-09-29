# MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017)
MongoMapper.database = "ts-#{Rails.env}"

# MongoMapper.connection = Mongo::Connection.new('flame.mongohq.com', 27089)
# MongoMapper.database = 'all41ofus-dev'
# MongoMapper.database.authenticate('all41ofus_db', 'Q^X,r%ZrFp,z%@!!!ju{j@8\3')

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
