# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

#seed shelters
Shelter.create(name = "Manhattan Animal Care Center", location = "326 East 110th Street (between 1st and 2nd Aves.)
New York, NY 10029", contact = "(212) 788-4000")

Shelter.create(name = "Brooklyn Animal Care Center", location = "2336 Linden Boulevard
Brooklyn, NY 11208", contact = "(212) 788-4000")
