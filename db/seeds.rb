# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

Shelter.destroy_all
Dog.destroy_all
User.destroy_all
Payment.destroy_all


#seed shelters
Shelter.create(name: "Manhattan Animal Care Center", location: "326 East 110th Street between 1st and 2nd Aves, New York, NY 10029", contact: "(212) 788-4000")

Shelter.create(name: "Brooklyn Animal Care Center", location: "2336 Linden Boulevard
Brooklyn, NY 11208", contact: "(212) 788-4000")

Shelter.create(name: "Staten Island Animal Care Center", location: "3139 Veterans Road West
Staten Island, NY 10309", contact: "(212) 788-4000")

#seed dogs from ACC website
doc = Nokogiri::HTML(open('https://www.nycacc.org/adopt/adoption-search?field_animal_id=&field_type=3&field_contact_location=All'))

doc.css('li.col-xs-12').each do |link|
  # set up scraping of individual dog show pages
  showpage_link = link.children[4].children.children[0].values[0]
  show_doc = Nokogiri::HTML(open('https://www.nycacc.org' + showpage_link))

  # assign variables
  dog_name = show_doc.css('#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > h2 > span').text

    if show_doc.css('#pet-image-container > a > div').search('.animal-image-detail').map{ |n| n['style'][/url\((.+)\)/, 1] }[0]
      dog_image = show_doc.css('#pet-image-container > a > div').search('.animal-image-detail').map{ |n| n['style'][/url\((.+)\)/, 1] }[0].split('')
      dog_image.shift
      dog_image.pop
      dog_image = dog_image.join('')
    else
      dog_image = show_doc.css("#image-animal-wrapper > a > div").map{ |n| n['style'][/url\((.+)\)/, 1] }[0].split('')
      dog_image.shift
      dog_image.pop
      dog_image = dog_image.join('')
    end

  dog_sex = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li.first-li-item > p").children[1].text
  dog_age = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li:nth-child(2) > p").children[1].text
  dog_shelter = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li:nth-child(3) > p").text
  dog_chip_id = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li.first-li-item > p").text

  if show_doc.css("#animal-summary")
    dog_description = show_doc.css("#animal-summary")[0].text
  else
    dog_description = "No one has written about this pup yet, but they still need your support!"
  end

  dog_shelter_id = Shelter.find_by(name: dog_shelter).id
  #create dog object
  Dog.create(
    name: dog_name,
    image_url: dog_image,
    chip_id: dog_chip_id,
    sex: dog_sex,
    age: dog_age,
    shelter_id: dog_shelter_id,
    description: dog_description
  )
end

doc_2 = Nokogiri::HTML(open('https://www.nycacc.org/adopt/adoption-search?field_animal_id=&field_type=3&field_contact_location=All&page=1'))

doc_2.css('li.col-xs-12').each do |link|
  # set up scraping of individual dog show pages
  showpage_link = link.children[4].children.children[0].values[0]
  show_doc = Nokogiri::HTML(open('https://www.nycacc.org' + showpage_link))

  # assign variables
  dog_name = show_doc.css('#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > h2 > span').text

    if show_doc.css('#pet-image-container > a > div').search('.animal-image-detail').map{ |n| n['style'][/url\((.+)\)/, 1] }[0]
      dog_image = show_doc.css('#pet-image-container > a > div').search('.animal-image-detail').map{ |n| n['style'][/url\((.+)\)/, 1] }[0].split('')
      dog_image.shift
      dog_image.pop
      dog_image = dog_image.join('')
    else
      dog_image = show_doc.css("#image-animal-wrapper > a > div").map{ |n| n['style'][/url\((.+)\)/, 1] }[0].split('')
      dog_image.shift
      dog_image.pop
      dog_image = dog_image.join('')
    end

  dog_sex = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li.first-li-item > p").children[1].text
  dog_age = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li:nth-child(2) > p").children[1].text
  dog_shelter = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li:nth-child(3) > p").text
  dog_chip_id = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li.first-li-item > p").text

  if show_doc.css("#animal-summary")
    dog_description = show_doc.css("#animal-summary")[0].text
  else
    dog_description = "No one has written about this pup yet, but they still need your support!"
  end

  dog_shelter_id = Shelter.find_by(name: dog_shelter).id
  #create dog object
  Dog.create(
    name: dog_name,
    image_url: dog_image,
    chip_id: dog_chip_id,
    sex: dog_sex,
    age: dog_age,
    shelter_id: dog_shelter_id,
    description: dog_description
  )
end

doc_3 = Nokogiri::HTML(open('https://www.nycacc.org/adopt/adoption-search?field_animal_id=&field_type=3&field_contact_location=All&page=1'))

doc_3.css('li.col-xs-12').each do |link|
  # set up scraping of individual dog show pages
  showpage_link = link.children[4].children.children[0].values[0]
  show_doc = Nokogiri::HTML(open('https://www.nycacc.org' + showpage_link))

  # assign variables
  dog_name = show_doc.css('#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > h2 > span').text

    if show_doc.css('#pet-image-container > a > div').search('.animal-image-detail').map{ |n| n['style'][/url\((.+)\)/, 1] }[0]
      dog_image = show_doc.css('#pet-image-container > a > div').search('.animal-image-detail').map{ |n| n['style'][/url\((.+)\)/, 1] }[0].split('')
      dog_image.shift
      dog_image.pop
      dog_image = dog_image.join('')
    else
      dog_image = show_doc.css("#image-animal-wrapper > a > div").map{ |n| n['style'][/url\((.+)\)/, 1] }[0].split('')
      dog_image.shift
      dog_image.pop
      dog_image = dog_image.join('')
    end

  dog_sex = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li.first-li-item > p").children[1].text
  dog_age = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li:nth-child(2) > p").children[1].text
  dog_shelter = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li:nth-child(3) > p").text
  dog_chip_id = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li.first-li-item > p").text

  if show_doc.css("#animal-summary")
    dog_description = show_doc.css("#animal-summary")[0].text
  else
    dog_description = "No one has written about this pup yet, but they still need your support!"
  end

  dog_shelter_id = Shelter.find_by(name: dog_shelter).id
  #create dog object
  Dog.create(
    name: dog_name,
    image_url: dog_image,
    chip_id: dog_chip_id,
    sex: dog_sex,
    age: dog_age,
    shelter_id: dog_shelter_id,
    description: dog_description
  )
end
