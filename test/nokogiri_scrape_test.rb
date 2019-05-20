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

  dog_shelter_id = Shelter.find_by(name: dog_shelter).id
  #create dog object
  Dog.create(
    name: dog_name,
    image_url: dog_image,
    chip_id: dog_chip_id,
    sex: dog_sex,
    age: dog_age,
    shelter_id: dog_shelter_id,
  )
end
