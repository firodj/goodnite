namespace :users do
  desc "Initialize users"
  task init: :environment do
    User.create :name => "John"
    User.create :name => "Bob"
    User.create :name => "Alice"
    User.create :name => "Susan"
  end

end
