require 'nokogiri'
require 'open-uri'
require 'byebug'

doc = Nokogiri::HTML(open('https://www.aspca.org/nyc/aspca-adoption-center/adoptable-dogs?ms=MP_PMK_GGAdoption-Tristate&initialms=MP_PMK_GGAdoption-Tristate&gclid=Cj0KCQjwzunmBRDsARIsAGrt4mtTV4Bzl60sF5AdOZOjRx0vrUDvay5tbvcaOS1RV2kppsuYaBK4o9saAg9WEALw_wcB'))

doc.css('#section-panel > div.center-wrapper > div.panel-col-first.panel-panel > div > div > div > div > div > div > div.view-content > div.views-row-odd.views-row-first.listing.contextual-links-region').each do |link|
  # set up scraping of individual dog show pages
  showpage_link = link.children[1].children[1].values[0]
  show_doc = Nokogiri::HTML(open('https://www.aspca.org' + showpage_link))

  # assign variables
  byebug
  dog_name = show_doc.css("#content > div.panel-2col-stacked.clearfix.panel-display > div.center-wrapper > div.panel-col-first.panel-panel > div > div.panel-pane.pane-custom.pane-2.name.details > div > div.field-items > div").text

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
  dog_intake_date = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li:nth-child(7) > p").children[1].text
  dog_shelter = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li:nth-child(3) > p").text
  dog_chip_id = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-8.col-lg-8.right-animal-detail.detail-desktop > ul > li.first-li-item > p").text
  dog_weight = show_doc.css("#page > div.main-container.container-fluid.js-quickedit-main-content > div > section > div > article > div > div > div > div.col-xs-12.col-sm-4.col-lg-4.left-animal-detail.detail-desktop > ul > li:nth-child(6) > p").children[1].text

  #create dog object
  newDog = {
    name: dog_name,
    image_url: dog_image,
    sex: dog_sex,
    age: dog_age,
    intake_take: dog_intake_date,
    shelter: dog_shelter,
    chip_id: dog_chip_id,
    weight: dog_weight
  }

  puts newDog
end
