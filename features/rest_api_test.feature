# encoding: UTF-8
# language: ru

#Readme
# Данный тест - проверка навыков работы с REST API
# Мы используем Gem RestClient
# Для облегчения работы в тесте есть обертка над этим гемом features/support/helpers/rest_wrapper.rb

# Ваша задача
# 1. Реализовать шаг удаления пользователя по логину ( логин - уникальный параметр для пользователя)
# 2. Реализовать шаг изменения доступных параметров пользователя по логину
# 3. Провести исследовательское тестирование работы реализованных REST API сервисов (независимо и в связках)

Функция: REST API

  Сценарий: Работа с пользователями через REST API

    Дано получаю информацию о пользователях

    И проверяю наличие логина i.ivanov в списке пользователей
    И проверяю отсутствие логина f.akelogin в списке пользователей

    Тогда добавляю пользователя c логином t.tasknb именем testing фамилией task паролем Qwerty123@
    И нахожу пользователя с логином t.tasknb

    # Параметры пользователя:
    #  "id": object id, не изменяемый в принципе
    #  "login": неизменяемый
    #  "name": изменяемый
    #  "surname": изменяемый
    #  "creationdate": неизменяемый
    #  "active": изменяемый
    #  "password": задаётся при создании пользователя, не возвращается в результатах get-запроса к https://testing4qa.ediweb.ru/api/users/{{user_id}}, неизменяемый

    Тогда изменяю имя пользователя с логином t.tasknb на testtest
    И проверяю, что имя пользователя с логином t.tasknb имеет значение testtest

    Тогда изменяю фамилию пользователя с логином t.tasknb на ololoev
    И проверяю, что фамилия пользователя с логином t.tasknb имеет значение ololoev

    Тогда изменяю атрибут "active" пользователя с логином t.tasknb на 0
    И проверяю, что атрибут "active" пользователя с логином t.tasknb имеет значение 0

    Тогда удаляю пользователя с логином t.tasknb
    И получаю информацию о пользователях
    И проверяю отсутствие логина t.tasknb в списке пользователей


