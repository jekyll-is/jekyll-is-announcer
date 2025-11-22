# jekyll-is-announcer

[![License: GPL-3.0-or-later](https://img.shields.io/badge/license-GPL--3.0--or--later-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D3.4-red.svg)](https://www.ruby-lang.org/en/)
[![Jekyll](https://img.shields.io/badge/jekyll-%7E%3E4.3-green.svg)](https://jekyllrb.com/)

`jekyll-is-announcer` is a Ruby gem for Jekyll that automates announcing new blog posts to external services, currently supporting Telegram channels and IndexNow.

## Features

- Automatically detects new posts in your Jekyll site marked for announcing.
- Publishes announcements to configured Telegram channels using Telegram Bot API.
- Supports message formatting with MarkdownV2 and automatic escaping of special characters.
- Generates JSON files for announced posts, allowing integration with other announcement channels like IndexNow.
- Extensible architecture to add more channels and notification methods.
- Comes with RSpec tests and code coverage setup.

## Installation

Add this line to your Jekyll site's `Gemfile`:

```
gem 'jekyll-is-announcer', '~> 0.8.0'
```

Then run:

```
bundle install
```

## Configuration

In your Jekyll `_config.yml`, add an `announcer` section specifying channels and settings:

```
announcer:
  url: "https://yourblog.com"
  telegram:
    method: telegram
    chat_id: "<your-telegram-chat-id>"
```

Mark posts you want to announce with `announce: true` in the front matter:

```
***
title: "New post"
announce: true
***
```

## Usage

When you build your Jekyll site, the announcer plugin detects new posts, generates announcement JSON files (`announces.json`), and sends messages to Telegram via the bot token specified in the environment variable `TELEGRAM_BOT_TOKEN`.

Example environment setup (Linux/macOS):

```
export TELEGRAM_BOT_TOKEN="your_bot_token_here"
```

## Development

Clone the repository and install dependencies with bundler:

```
git clone https://github.com/jekyll-is/jekyll-is-announcer.git
cd jekyll-is-announcer
bundle install
```

Run tests using Rake and RSpec:

```
rake spec
```

## Contributing

Contributions are welcome. Please fork the repository and submit pull requests. Ensure tests pass before submitting.

## License

This project is licensed under the [GPL-3.0-or-later License](https://www.gnu.org/licenses/gpl-3.0.html).

## Links

- GitHub repository: https://github.com/jekyll-is/jekyll-is-announcer

---

Created by [Ivan Shikhalev](https://github.com/shikhalev)
