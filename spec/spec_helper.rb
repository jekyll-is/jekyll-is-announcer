# spec/spec_helper.rb

require "bundler/setup"
require 'simplecov'

# Запуск SimpleCov один раз в начале, перед загрузкой тестируемого кода
SimpleCov.start do
  add_filter '/spec/'  # исключаем тесты из отчёта
  minimum_coverage 0  # минимальный процент покрытия
end

require_relative "../lib/jekyll-is/announcer.rb"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
