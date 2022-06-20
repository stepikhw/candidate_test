## Тестовое окружение:
* ruby 2.6.5p114
* ChromeDriver 102.0.5005.61
* Google Chrome 102.0.5005.115

## Дополнительные тест-кейсы (MindMap):

https://atlas.mindmup.com/2022/06/5a2997e0efe411ecaee1eb363585dae6/working_with_users_via_rest_api/index.html

## Тестирование работы реализованных REST API сервисов

### Case #1 -  Выполнение сценария "Работа с пользователями через REST API"
**Steps:**  
1. Запустить сценарий "Работа с пользователями через REST API"  

**Actual result:** сценарий выполняется успешно, тесты проходят  

### Case #2 -  Выполнение Before hook
**Preconditions:** пользователь t.tasknb существует  
**Steps:** 
1. Запустить сценарий "Работа с пользователями через REST API" 

**Actual result:** существующий пользователь t.tasknb удаляется, в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Запуск Before hook_  
_YYYY-MM-DD HH-MM-SS INFO -- {"name"=>"Delete", "message"=>"Delete was success.", "status"=>200}_  
_YYYY-MM-DD HH-MM-SS INFO -- Существующий пользователь t.tasknb удалён._  
_YYYY-MM-DD HH-MM-SS INFO -- Завершение Before hook._  

### Case #3 -  Выполнение Before hook
**Preconditions:** пользователь t.tasknb не существует  
**Steps:**
1. Запустить сценарий "Работа с пользователями через REST API"

**Actual result:** в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Запуск Before hook_  
_YYYY-MM-DD HH-MM-SS INFO -- Завершение Before hook._  

### Case #4 - Изменение имени существующего пользователя
**Preconditions:** пользователь существует  
**Steps:**
1. Выполнить шаг _изменяю имя пользователя с логином t.tasknb на testtest_  

**Actual result:** имя пользователя изменяется на указанное, в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- {"name"=>"Success", "message"=>"Update was success.", "status"=>200}_  
_YYYY-MM-DD HH-MM-SS INFO -- Информация о пользователях получена_  
_YYYY-MM-DD HH-MM-SS INFO -- Пользователь t.tasknb: параметр имя имеет значение testtest_  
Изменение атрибута может быть проконтролировано путём выполнения GET-запроса к https://testing4qa.ediweb.ru/api/users/[USER_ID], где USER_ID - id пользователя

### Case #5 - Изменение имени несуществующего пользователя
**Preconditions:** пользователь не существует  
**Steps:**
1. Выполнить шаг _изменяю имя пользователя с логином t.tasknb2 на testtest_

**Actual result:** в лог выводится:  
_RuntimeError: Пользователь с логином t.tasknb2 не существует_    

### Case #6 - Проверка изменения имени существующего пользователя
**Preconditions:** пользователь существует  
**Steps:**
1. Выполнить шаг _проверяю, что имя пользователя с логином t.tasknb имеет значение testtest_  

**Actual result:** в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Информация о пользователях получена_  
_YYYY-MM-DD HH-MM-SS INFO -- Пользователь t.tasknb: параметр имя имеет значение testtest_   

### Case #7 - Проверка изменения имени несуществующего пользователя
**Preconditions:** пользователь не существует  
**Steps:**
1. Выполнить шаг _проверяю, что имя пользователя с логином t.tasknb2 имеет значение testtest_

**Actual result:** в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Информация о пользователях получена_

_RuntimeError: Пользователь t.tasknb2: не удалось получить значение атрибута name_ 

### Case #8 - Проверка изменения имени существующего пользователя (несовпадение значения, полученного с помощью API со значением, указанным в шаге)
**Preconditions:** пользователь существует, имя пользователя имеет значение testtest  
**Steps:**
1. Выполнить шаг _проверяю, что отчество пользователя с логином t.tasknb имеет значение testtesttest_

**Actual result:** в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Информация о пользователях получена_

_RuntimeError: Пользователь t.tasknb: имя testtest не равно ожидаемому testtesttest._  
_./features/step_definitions/rest_tests_steps.rb:90:in `/^проверяю, что (имя|фамилия|атрибут \"active\") пользователя с логином (\w+\.\w+) имеет значение (\w+)$/'_  
_./features/rest_api_test.feature:36:in `И проверяю, что имя пользователя с логином t.tasknb имеет значение testtesttest'_  

### Изменение фамилии, поля "active", проверка изменений - аналогично.

### Case #9 - Проверка изменения несуществующего атрибута существующего пользователя
**Preconditions:** пользователь существует  
**Steps:**
1. Выполнить шаг _проверяю, что отчество пользователя с логином t.tasknb имеет значение testtest_

**Actual result:** в лог выводится:  
_You can implement step definitions for undefined steps with these snippets:_

_И(/^проверяю, что отчество пользователя с логином t\.tasknb имеет значение testtest$/) do
pending # Write code here that turns the phrase above into concrete actions
end_ 

### Case #10 -  Выполнение After hook
**Preconditions:** пользователь t.tasknb существует  
**Steps:**
1. Запустить сценарий "Работа с пользователями через REST API"

**Actual result:** существующий пользователь t.tasknb удаляется, в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Запуск After hook_  
_YYYY-MM-DD HH-MM-SS INFO -- {"name"=>"Delete", "message"=>"Delete was success.", "status"=>200}_  
_YYYY-MM-DD HH-MM-SS INFO -- Существующий пользователь t.tasknb удалён._  
_YYYY-MM-DD HH-MM-SS INFO -- Завершение After hook._

### Case #11 -  Выполнение After hook
**Preconditions:** пользователь t.tasknb не существует  
**Steps:**
1. Запустить сценарий "Работа с пользователями через REST API"

**Actual result:** в лог выводится:  
_YYYY-MM-DD HH-MM-SS INFO -- Запуск After hook_  
_YYYY-MM-DD HH-MM-SS INFO -- Завершение After hook._  





