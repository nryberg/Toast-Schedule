MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017)
MongoMapper.database = "ts-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
