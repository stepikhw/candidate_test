# frozen_string_literal: true

Before do |_scenario|
  # Сценарий "Работа с пользователями через REST API"
  if _scenario.name == "Работа с пользователями через REST API"
    @scenario_data = ScenarioData.new
    # Прочие сценарии
  else
    @webpage_scenario_data = WebPageScenarioData.new
  end
end

Before do |_scenario|
  # Выполняется перед выполнением сценария "Работа с пользователями через REST API"
  # Т.о. можно быть уверенным, что пользователь t.tasknb будет удалён в любом случае
  # В идеале имя пользователя тоже должно было бы быть передано как параметр/читаться из конфига
  if _scenario.name == "Работа с пользователями через REST API"
    begin
      $logger.info("Запуск Before hook")
      users_full_information = $rest_wrap.get('/users')
      user_to_delete_id = find_user_id(users_information: users_full_information, user_login: "t.tasknb")
    rescue RuntimeError
      #
    else
      url_to_send_delete_request = "/users/#{user_to_delete_id}"
      response = $rest_wrap.delete(url_to_send_delete_request)
      $logger.info(response.inspect)
      $logger.info("Существующий пользователь t.tasknb удалён.")
    ensure
      $logger.info("Завершение Before hook.")
      print("\n")
    end
  end
end

After do |_scenario|
  # Выполняется после выполнения сценария "Работа с пользователями через REST API" вне зависимости от того, упал ли тест
  # Т.о. можно быть уверенным, что пользователь t.tasknb будет удалён в любом случае
  # В идеале имя пользователя тоже должно было бы быть передано как параметр/читаться из конфига
  if _scenario.name == "Работа с пользователями через REST API"
    begin
      print("\n")
      $logger.info("Запуск After hook")
      users_full_information = $rest_wrap.get('/users')
      user_to_delete_id = find_user_id(users_information: users_full_information, user_login: "t.tasknb")
    rescue RuntimeError
      #
    else
      url_to_send_delete_request = "/users/#{user_to_delete_id}"
      response = $rest_wrap.delete(url_to_send_delete_request)
      $logger.info(response.inspect)
      $logger.info("Существующий пользователь t.tasknb удалён.")
    ensure
      $logger.info("Завершение After hook.")
    end
  end
end
