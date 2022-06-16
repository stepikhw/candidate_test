# frozen_string_literal: true

When(/^захожу на страницу "(.+?)"$/) do |url|
  visit url
  $logger.info("Страница #{url} открыта")
  sleep 1
end

When(/^ввожу в поисковой строке текст "([^"]*)"$/) do |text|
  query = find("//input[@name='q']")
  query.set(text)
  query.native.send_keys(:enter)
  $logger.info('Поисковый запрос отправлен')
  sleep 1
end

When(/^кликаю по строке выдачи с адресом (.+?)$/) do |url|
  link_first = find("//a[@href='#{url}/']/h3")
  link_first.click
  $logger.info("Переход на страницу #{url} осуществлен")
  sleep 1
end

When(/^я должен увидеть текст на странице "([^"]*)"$/) do |text_page|
  sleep 1
  expect(page).to have_text text_page
end

When(/^открывается страница "([^"]*)"$/) do |expected_url|
  raise "Текущий URL #{current_url} не соответствует ожидаемому #{expected_url}" unless current_url == expected_url
end

When(/^я нажимаю на ссылку на последний стабильный релиз$/) do
  link_to_latest_release = find("//ul[2]/li[1]/ul/li[1]/a")
  link_to_latest_release.click()
  $logger.info("Ссылка на последний релиз #{link_to_latest_release[:href]} нажата")
  @webpage_scenario_data.link_to_the_latest_release = link_to_latest_release
  sleep(10)
end

When(/^имя скачанного файла совпадает с именем на сайте$/) do
  expected_filename = @webpage_scenario_data.link_to_the_latest_release[:href].split("/").last
  raise "Каталог #{@webpage_scenario_data.directory_to_download_file} не содержит файл с именем #{expected_filename}." unless File.basename(@finished_downloads.first) == expected_filename
  $logger.info("Файл #{expected_filename} имеет корректное имя.")
end

When(/^нажимаю на вкладку с текстом "([^"]*)"$/) do |text_on_page|
  link = find("//div[@id='header']/div[@id='header_content']/div/a",text: text_on_page)
  link.click()
  $logger.info("Вкладка с текстом #{text_on_page} нажата")
end

When(/^жду конца загрузки "([^"]*)" секунд$/) do |timeout_str|
  # Директория для загрузки файла
  @webpage_scenario_data.directory_to_download_file = Dir.pwd + '/features/tmp/'
  # Проверка, что в каталоге нет файлов с расширением .crdownload (только для Chrome)
  timeout = timeout_str.to_i()
  # Проверка, что есть завершенные загрузки и нет незавершенных
  for second_passed in 0..timeout
    unfinished_downloads =  Dir.glob(@webpage_scenario_data.directory_to_download_file+"*.crdownload")
    all_downloads = Dir.glob(@webpage_scenario_data.directory_to_download_file+"*.*")
    @finished_downloads =  all_downloads.reject { |file| file.include?('.crdownload') }
    # Есть завершенные загрузки и нет незавершенных
    if (unfinished_downloads.empty?)and(@finished_downloads.length != 0)
      break
    end
    sleep(1)
  end
  raise "Директория содержит файл(ы) незавершенных загрузок: #{Dir.glob(@webpage_scenario_data.directory_to_download_file+"*.crdownload")}" unless unfinished_downloads.empty?
  $logger.info("Незавершенных загрузок в #{@webpage_scenario_data.directory_to_download_file} нет.")
end

When(/^директория содержит загруженный файл$/) do
  raise "Директория #{@webpage_scenario_data.directory_to_download_file} пуста." unless @finished_downloads.length
  raise "Директория #{@webpage_scenario_data.directory_to_download_file} содержит #{@finished_downloads.length} файлов: #{@finished_downloads}." unless @finished_downloads.length == 1
end

When(/^очищаю директорию для загрузок$/) do
  # Каталог, в который загружаются файлы
  directory_to_cleanup = @webpage_scenario_data.directory_to_download_file
  Dir.glob(directory_to_cleanup+"*").each { |file| File.delete(file)}
  raise "Директория #{directory_to_cleanup} не пуста." unless Dir.glob(directory_to_cleanup+"*").empty?
  $logger.info("Директория #{directory_to_cleanup} очищена.")
end