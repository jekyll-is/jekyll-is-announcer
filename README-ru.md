| [en](README.md) | RU |
|----------|----------|

# jekyll-is-announcer

`jekyll-is-announcer` — это Ruby gem для Jekyll, который автоматизирует анонсирование новых постов блога во внешние сервисы, в первую очередь в Telegram-каналы и систему IndexNow.

## Возможности

- Автоматическое обнаружение новых постов с меткой announce в вашем сайте на Jekyll.
- Отправка анонсов в Telegram через Telegram Bot API с поддержкой MarkdownV2 и экранированием спецсимволов.
- Генерация JSON-файлов с информацией об анонсированных постах для интеграции с другими каналами.
- Расширяемая архитектура для добавления новых каналов и способов оповещения.
- Наличие базовых тестов на RSpec и настройка покрытия кода.

## Установка

Добавьте в Gemfile вашего Jekyll-сайта:

```
gem 'jekyll-is-announcer', '~> 0.8.0'
```

Запустите команду:

```
bundle install
```

## Конфигурация

Добавьте в ваш `_config.yml` секцию `announcer` с настройками:

```
announcer:
  url: "https://ваш_сайт.com"
  telegram:
    method: telegram
    chat_id: "<ваш-telegram-chat-id>"
```

В метаданные постов (front matter) добавьте:

```
***
title: "Заголовок поста"
announce: true
***
```

## Использование

При сборке Jekyll сайта плагин обнаружит новые посты с флагом announce, создаст JSON для анонсов (`announces.json`) и отправит сообщения в Telegram с использованием токена бота, указанного в переменной окружения `TELEGRAM_BOT_TOKEN`.

Пример установки переменной окружения в Linux/macOS:

```
export TELEGRAM_BOT_TOKEN="ваш_токен_бота"
```

## Разработка

Клонируйте репозиторий и установите зависимости:

```
git clone https://github.com/jekyll-is/jekyll-is-announcer.git
cd jekyll-is-announcer
bundle install
```

Запустите тесты:

```
rake spec
```

## Контрибуции

Приглашаются к сотрудничеству! Форкайте репозиторий, создавайте ветки, присылайте pull request с описанием изменений. Пожалуйста, запускайте тесты перед отправкой.

## Лицензия

Проект лицензирован под [GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.html).

## Ссылки

- Репозиторий GitHub: https://github.com/jekyll-is/jekyll-is-announcer

---

Автор: [Иван Шихалев](https://github.com/shikhalev)
