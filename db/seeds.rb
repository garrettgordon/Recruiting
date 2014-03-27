# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
event1=CareerFair.new(:name => "CED Career Fair", :location => "Haas Pavilion", :date => Date.new(2014, 3, 18), :foodPresent => true, :acceptingResumes => true, :numberOfOrganizers => 123, :description => "Annual Career Faire for EECS/CS Majors!", :link => "http://images.forbes.com/media/lists/95/2011/uc-berkeley-haas.jpg")
event1.save
event2=CareerFair.new(:name => "Just In Time Job Fair", :location => "Haas Pavilion", :date => Date.new(2014, 4, 16), :foodPresent => true, :acceptingResumes => true, :numberOfOrganizers => 84, :description => "Not too late to still find an internship!", :link => "http://deimos3.apple.com/indigo//e9/5a/22/14/e95a221489b7d2027cd32e82b01229bd8b209db772d55f10bc46d8bfb1ae04a4-1812338826.jpg")
event2.save
event3=InfoSession.new(:name => "Facebook Info Session", :location => "Wozniak Lounge", :date => Date.new(2014, 4, 20), :foodPresent => false, :acceptingResumes => true, :numberOfSpeakers => 2, :description => "Come to hear Google speak about their latest R&D projects in Google X Labs!", :link => "http://www.livehacking.com/web/wp-content/uploads/2013/01/facebook-logo-300x300.jpg")
event3.save
event4=InfoSession.new(:name => "Morgan Stanley Info Session", :location => "Wozniak Lounge", :date => Date.new(2014, 4, 21), :foodPresent => true, :acceptingResumes => false, :numberOfSpeakers => 2, :description => "Yahoo UI/UX designers will debut their latest UI templates using Bootstrap and Icing!", :link => "http://zikkir.com/brands/wp-content/themes/directorypress/thumbs/Morgan-Stanley-300x300.png")
event4.save
event5=InfoSession.new(:name => "Twitter Tech Talk", :location => "Wozniak Lounge", :date => Date.new(2014, 4, 25), :foodPresent => false, :acceptingResumes => false, :numberOfSpeakers => 1, :description => "Come to see Palantir engineers speak about what they do day to day!", :link => "https://blog.twitter.com/sites/all/themes/gazebo/img/twitter-bird-white-on-blue.png")
event5.save
event6=SpeakerPanel.new(:name=>"Google Scaling", :location => "Woz", :date => Date.new(2014, 3, 28), :foodPresent => false, :acceptingResumes => true, :numberOfSpeakers => 5, :description => "Learn to scale")
event6.save
user = User.new(:username => "zoopreme", :password => "alife", :email => "andrewmori@berkeley.edu")
user.save