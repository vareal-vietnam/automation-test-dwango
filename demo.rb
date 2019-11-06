require "selenium-webdriver"

#TODO Read users from csv file
[
  {email: "vu.minh.duc@vareal.vn", password: "123456"},
  {email: "vu.minh.duc@vareal.vn", password: "123456"}
].each do |user|
  client = Selenium::WebDriver::Remote::Http::Default.new
  options = Selenium::WebDriver::Chrome::Options.new

  client.read_timeout = 300
  options.add_argument('--incognito')
  options.add_argument('--ignore-certificate-errors')
  options.add_argument('--disable-popup-blocking')
  options.add_argument('--disable-translate')

  driver = Selenium::WebDriver.for :chrome, options: options, http_client: client
  driver.navigate.to "https://pc-monka.dev.nnn.ed.nico/"

  btn_login_niconico = driver.find_element(link_text: "ログイン")
  if btn_login_niconico.displayed?
    puts "Start login niconico..."
    btn_login_niconico.click
  end

  texb_login_email = driver.find_element(id: "input__mailtel")
  texb_login_password = driver.find_element(id: "input__password")
  btn_login_submit = driver.find_element(id: "login__submit")

  texb_login_email.send_keys user[:email]
  texb_login_password.send_keys user[:password]
  btn_login_submit.click

  #TODO: update user information

  driver.quit
end
