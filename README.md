# Коннектор к Google Spreadsheets для Microsoft Power BI

### Наши курсы:
1) Основы Power BI (3 часа): https://directprorf.ru/basics?utm_source=github
2) Курс по коннекторам в Excel (4 часа): https://directprorf.ru/excel?utm_source=github
3) Большой курс по обработке данных в Power Query (8 часов): https://directprorf.ru/pq?utm_source=github

По всем вопросам, связанным с курсами и коннекторами: https://t.me/alexdirect

### Основные преимущества и дополнения:
- позволяет получать данные из таблиц, не доступных по ссылке,
- поддерживает онлайн-обновление в Power BI Service,
- добавлен обязательный выбор аккаунта при подключении к Google таблице.


### Как воспользоваться коннектором:

1) Скачайте файл GoogleSheets.mez: https://github.com/morinad/PQGoogleSpreadsheet/raw/master/GoogleSheets.mez

2) Поместите файл GoogleSheets.mez в папку C:\Users\USERNAME\Documents\Power BI Desktop\Custom Connectors, подставив USERNAME своего компьютера.

3) Откройте Power BI, зайдите в Файл -> Параметры и настройки -> Параметры -> Глобальные -> Безопасность, выберите "Разрешить загрузку любого расширения без проверок и предупреждений".

4) Нажмите на кнопку "Получить данные", в поиске найдите коннектор Google Spreadsheets и укажите ссылку на вашу таблицу, скопировав её из браузера.


### Как обеспечить полную конфиденциальность данных:

1) Перейдите в https://console.developers.google.com/apis/ и создайте новый проект.
2) В разделе "Библиотека" найдите Google Sheets API и включите его в новом проекте.
3) В разделе "Учётные данные" создайте новые учётные данные типа "Идентификатор клиента OAuth"
4) Выберите тип приложения - "Веб приложение"
5) Скопируйте полученный client_id и client secret.
6) Установите программу Visual Studio и библиотеку Power Query SDK.
7) Создайте новый проект с названием "GoogleSheets".
8) В созданном файле GoogleSheets.pq замените код на вот этот, подставив при этом свои client_id и client_secret: https://github.com/morinad/PQGoogleSpreadsheet/blob/master/GoogleSheets/GoogleSheets.pq
9) При желании скачайте иконки png и замените в своём проекте стандартные иконки на иконки гугл таблиц: https://github.com/morinad/PQGoogleSpreadsheet/blob/master/GoogleSheets
10) При нажатии правой кнопкой на название проекта справа, выберите в меню "Собрать".
11) При нажатии правой кнопкой на название проекта, выберите "Открыть папку в проводнике".
12) Откройте папку проекта и перейдя в /bin/Debug скопируйте полученный файл GoogleSheets.mez, 
13) Замените старый коннектор .mez на новый в папке "C:\Users\USERNAME\Documents\Power BI Desktop\Custom Connectors".
14) Проверьте работу обновлённого коннектора.




