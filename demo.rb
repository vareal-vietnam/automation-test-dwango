require "selenium-webdriver"
require "pry"

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

  # Run job in background
  # options.add_argument('--headless')

  driver = Selenium::WebDriver.for :chrome, options: options, http_client: client
  driver.navigate.to "https://dev.nnn.ed.nico/"

  btn1_login_niconico = driver.find_element(link_text: "ログイン")
  btn1_login_niconico.click

  text_login_email = driver.find_element(id: "input__mailtel")
  text_login_email.send_keys user[:email]
  text_login_password = driver.find_element(id: "input__password")
  text_login_password.send_keys user[:password]
  btn_auth_submit = driver.find_element(id: "login__submit")
  btn_auth_submit.click

  driver.find_element(class: "okay").click()

  btn_choice1 = driver.find_element(link_text: "はじめる")
  btn_choice1.click

  btn_choice2 = driver.find_element(link_text: "同意して設定する")
  btn_choice2.click

  btn_choice3 = driver.find_element(name: "commit")
  btn_choice3.click

  driver.find_element(name:"year").send_keys('1988')
  driver.find_element(name:"month").send_keys('10')
  driver.find_element(name:"day").send_keys('9')

  driver.find_element(name:'profile[last_name]').send_keys('テスト')
  driver.find_element(name:'profile[first_name]').send_keys('テスト')
  driver.find_element(name:'profile[last_name_kana]').send_keys('テスト')
  driver.find_element(name:'profile[first_name_kana]').send_keys('テスト')
  driver.find_element(name:'profile[postal_code]').send_keys('1640013')
  driver.find_element(name:'profile[phone_number]').send_keys('123456789')

  btn_choice4 = driver.find_element(name: "commit")
  btn_choice4.click

  driver.find_element(name:'daigaku_juken[job_or_grade_id]').send_keys('一般社会人')

  btn_choice5 = driver.find_element(name: "commit")
  btn_choice5.click

  btn_choice6 = driver.find_element(link_text: "N予備校ホームへ")
  btn_choice6.click

  driver.quit
end
