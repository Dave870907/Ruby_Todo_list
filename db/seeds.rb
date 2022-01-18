# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!( :user_name => "Dave" ,:email => "d2cb103@gmail.com" ,:password => '0907' ,admin: true)

Label.create!( :name => "Red")
Label.create!( :name => "Orange")
Label.create!( :name => "Yellow")
Label.create!( :name => "Green")
Label.create!( :name => "Blue")
Label.create!( :name => "Purple")
Label.create!( :name => "Gray")