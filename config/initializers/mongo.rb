# Local ###
if ENV['RAILS_ENV'] == "development" 
  # Use on local dev
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  # use on home network
  # MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017)
  MongoMapper.database = 'toast_schedule'
elsif ENV['RAILS_ENV'] == "production" 
  MongoMapper.connection = Mongo::Connection.new('flame.mongohq.com', 27038)
  MongoMapper.database = 'toast_schedule'
  MongoMapper.database.authenticate('toast_user', 'gidwysEzlaug')
end

# Mongo HQ ###

# Shared Drive ###
# MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017)


if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
