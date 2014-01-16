ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
 # Drop all collections after each test case.

class ActiveSupport::TestCase
  def teardown
   MongoMapper.database.collections.each do |coll|
     coll.remove
   end
 end

# Make sure that each test case has a teardown
# method to clear the db after each test.
  def inherited(base)
   base.define_method :teardown do
     super
   end
  end
 # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :users

  # Add more helper methods to be used by all tests here...
end
