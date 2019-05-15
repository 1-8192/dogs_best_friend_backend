require 'nokogiri'
require 'open-uri'
require 'byebug'

doc = Nokogiri::HTML(open('https://www.aspca.org/nyc/aspca-adoption-center/adoptable-dogs?ms=MP_PMK_GGAdoption-Tristate&initialms=MP_PMK_GGAdoption-Tristate&gclid=Cj0KCQjwzunmBRDsARIsAGrt4mtTV4Bzl60sF5AdOZOjRx0vrUDvay5tbvcaOS1RV2kppsuYaBK4o9saAg9WEALw_wcB'))

doc.css('#section-panel > div.center-wrapper > div.panel-col-first.panel-panel > div > div > div > div > div > div > div.view-content')
  # set up scraping of individual dog show pages
  byebug
  showpage_link = link.children[1].children[1].values[0]
  show_doc = Nokogiri::HTML(open('https://www.aspca.org' + showpage_link))

  # assign variables
  dog_name = show_doc.css("#content > div.panel-2col-stacked.clearfix.panel-display > div.center-wrapper > div.panel-col-first.panel-panel > div > div.panel-pane.pane-custom.pane-2.name.details > div > div.field-items > div").text
  dog_image = show_doc.css("#file-188775 > div > img").attr('data-echo').value
  dog_breed = show_doc.css("#content > div.panel-2col-stacked.clearfix.panel-display > div.center-wrapper > div.panel-col-first.panel-panel > div > div.panel-pane.pane-entity-field.pane-node-field-breed.breed.details > div > div.field-items > div").text
  dog_sex = show_doc.css("#content > div.panel-2col-stacked.clearfix.panel-display > div.center-wrapper > div.panel-col-first.panel-panel > div > div.panel-pane.pane-entity-field.pane-node-field-gender.gender.details > div > div.field-items > div").text
  dog_age = show_doc.css("#content > div.panel-2col-stacked.clearfix.panel-display > div.center-wrapper > div.panel-col-first.panel-panel > div > div.panel-pane.pane-entity-field.pane-node-field-birthdate.age.details > div > div.field-items > div > div").text

  #create dog object
  newDog = {
    name: dog_name,
    image_url: dog_image,
    sex: dog_sex,
    breed: dog_breed,
    age: dog_age,
  }

  puts newDog
