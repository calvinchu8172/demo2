namespace :dev do
  task :fake => :environment do
  	puts "Start fake"
    user = User.first
    100.times do |i|
      Event.create( :name => "Event #{i}", :user => user)
    end
  end
end