#!/usr/bin/env ruby

# Populate database with our user and 99 more
# invoke with "rake db:populate"

require 'faker'

namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		# task :populate => :environment do ,ensures that the Rake task has access
		# to the local Rails environment, including the User model (and hence User.create!).
		
		Rake::Task['db:reset'].invoke
		admin = User.create!(:name => "Alex",
								 :email => "alex@example.com",
								 :password => "123456",
								 :password_confirmation => "123456")
		admin.toggle!(:admin)
		
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@example.com"
			password = "password"
		User.create!(:name => name,
								 :email => email,
								 :password => password,
								 :password_confirmation => password)
		end
		
		User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end

	end
end
