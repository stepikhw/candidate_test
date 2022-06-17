# frozen_string_literal: true

When(/^получаю информацию о пользователях$/) do
  users_full_information = $rest_wrap.get('/users')

  $logger.info('Информация о пользователях получена')
  @scenario_data.users_full_info = users_full_information
end

When(/^проверяю (наличие|отсутствие) логина (\w+\.\w+) в списке пользователей$/) do |presence, login|
  search_login_in_list = true
  presence == 'отсутствие' ? search_login_in_list = !search_login_in_list : search_login_in_list

  logins_from_site = @scenario_data.users_full_info.map { |f| f.try(:[], 'login') }
  login_presents = logins_from_site.include?(login)

  if login_presents
    message = "Логин #{login} присутствует в списке пользователей"
    search_login_in_list ? $logger.info(message) : raise(message)
  else
    message = "Логин #{login} отсутствует в списке пользователей"
    search_login_in_list ? raise(message) : $logger.info(message)
  end
end

When(/^добавляю пользователя c логином (\w+\.\w+) именем (\w+) фамилией (\w+) паролем ([\d\w@!#]+)$/) do
|login, name, surname, password|

  response = $rest_wrap.post('/users', login: login,
                             name: name,
                             surname: surname,
                             password: password,
                             active: 1)
  $logger.info(response.inspect)
end

When(/^добавляю пользователя с параметрами:$/) do |data_table|
  user_data = data_table.raw

  login = user_data[0][1]
  name = user_data[1][1]
  surname = user_data[2][1]
  password = user_data[3][1]

  step "добавляю пользователя c логином #{login} именем #{name} фамилией #{surname} паролем #{password}"
end

When(/^нахожу пользователя с логином (\w+\.\w+)$/) do |login|
  step %(получаю информацию о пользователях)
  if @scenario_data.users_id[login].nil?
    @scenario_data.users_id[login] = find_user_id(users_information: @scenario_data
                                                                       .users_full_info,
                                                  user_login: login)
  end

  $logger.info("Найден пользователь #{login} с id:#{@scenario_data.users_id[login]}")
end

When(/^удаляю пользователя с логином (\w+\.\w+)$/) do |login|
  url_to_send_delete_request = "/users/#{@scenario_data.users_id[login]}"
  response = $rest_wrap.delete(url_to_send_delete_request)
  $logger.info(response.inspect)
  $logger.info("Пользователь с логином #{login} и id:#{@scenario_data.users_id[login]} удалён")
end

# Значение атрибута "active" можно было бы проверять на соответствие шаблону (0|1).
When(/^изменяю (имя|фамилию|атрибут \"active\") пользователя с логином (\w+\.\w+) на (\w+)$/) do |parameter, login, new_value|
  url_to_send_put_request = "/users/#{@scenario_data.users_id[login]}"
  case parameter
  when "имя"
    response = $rest_wrap.put(url_to_send_put_request, name: new_value)
  when "фамилию"
    response = $rest_wrap.put(url_to_send_put_request, surname: new_value)
  when "атрибут \"active\""
    response = $rest_wrap.put(url_to_send_put_request, active: new_value)
  else
    raise "Изменение параметра #{parameter}, переданного в шаг, не реализовано в тесте."
  end
  $logger.info(response.inspect)
end

# Значение атрибута "active" можно было бы проверять на соответствие шаблону (0|1).
When(/^проверяю, что (имя|фамилия|атрибут \"active\") пользователя с логином (\w+\.\w+) имеет значение (\w+)$/) do |parameter, login, value|
  step "получаю информацию о пользователях"
  case parameter
  when "имя"
    user_name = get_user_attribute(users_information: @scenario_data.users_full_info, user_login: login, attribute: 'name')
    raise "Пользователь #{login}: имя #{user_name} не равно ожидаемому #{value}." unless user_name == value
  when "фамилия"
    user_surname = get_user_attribute(users_information: @scenario_data.users_full_info, user_login: login, attribute: 'surname')
    raise "Пользователь #{login}: фамилия #{user_surname} не равна ожидаемой #{value}." unless user_surname == value
  when "атрибут \"active\""
    user_is_active = get_user_attribute(users_information: @scenario_data.users_full_info, user_login: login, attribute: 'active')
    raise "Пользователь #{login}: значение параметра \"active\" #{user_is_active} не равно ожидаемому #{value}." unless user_is_active.to_s == value
  else
    raise "Проверка параметра #{parameter}, переданного в шаг, не реализована в тесте."
  end
  $logger.info("Пользователь #{login}: параметр #{parameter} имеет значение #{value}")
end

