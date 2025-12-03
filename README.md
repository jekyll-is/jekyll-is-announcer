| **EN** | [ru](README-ru.md) |
|----------|----------|

# jekyll-is-announcer

[![GitHub License](https://img.shields.io/github/license/jekyll-is/jekyll-is-announcer)](LICENSE)
[![Gem Version](https://badge.fury.io/rb/jekyll-is-announcer.svg?icon=si%3Arubygems&d=2)](https://badge.fury.io/rb/jekyll-is-announcer)
[![Ruby](https://github.com/jekyll-is/jekyll-is-announcer/actions/workflows/ruby.yml/badge.svg)](https://github.com/jekyll-is/jekyll-is-announcer/actions/workflows/ruby.yml) 
![Coverage](coverage-badge.svg)

`jekyll-is-announcer` is a Ruby gem for Jekyll that automates announcing new blog posts to external services, primarily Telegram channels and IndexNow.

## Features

- Automatic detection of new posts in your Jekyll site marked with `announce: true` in the front matter.
- Publishes announcements to configured Telegram channels via the Telegram Bot API, supporting MarkdownV2 formatting and automatic escaping of special characters.
- Generates JSON files containing announcement data (`announces.json`) for integration with other announcement channels, such as IndexNow.
- Extensible architecture enables adding more channels and notification methods.
- Includes assets (e.g., JavaScript files) automatically served with your Jekyll site using custom StaticFile handling.
- Provides executable scripts in the `bin` directory accessible via `bundle exec` for manual announcement triggering.
- Supports Ruby version 3.4+ and Jekyll version 4.3+.
- Comes with RSpec tests and code coverage tracking with SimpleCov.

## Installation

Add this line to your Jekyll site's `Gemfile`:

```
gem 'jekyll-is-announcer', '~> 0.8.0'
```

Then execute:

```
bundle install
```

## Configuration

Add an `announcer` section to your Jekyll `_config.yml`:

```
announcer:
  url: "https://yourblog.com"
  telegram:
    method: telegram
    chat_id: "<your-telegram-chat-id>"
```

## Usage

Mark the posts you want to announce in their front matter:

```
title: "My New Post"
announce: true
```

When you build your Jekyll site, the announcer plugin will:

- Detect new posts with `announce: true`.
- Generate the announcement JSON file (`announces.json`) in the `_tmp` folder.
- Send messages to Telegram using the bot token specified in the environment variable `TELEGRAM_BOT_TOKEN`.
- Keep track of published announcements status in a local file (`announced.json`).

To manually trigger the announcement process, run:

```
bundle exec jekyll-is-announcer
```

## Development

Clone the repository and install dependencies:

```
git clone https://github.com/jekyll-is/jekyll-is-announcer.git
cd jekyll-is-announcer
bundle install
```

Run tests with:

```
rake spec
```

## License

This project is licensed under the GPL-3.0-or-later License.

## Links

- GitHub repository: https://github.com/jekyll-is/jekyll-is-announcer
