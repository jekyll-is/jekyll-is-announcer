Gem::Specification.new do |s|
  s.name        = "jekyll-is-announcer"
  s.version     = "0.8.0"
  s.summary     = "Announcing new blog posts"
  s.description = "Announcing new blog posts (to Telegram channel and to IndexNow)."
  s.authors     = ["Ivan Shikhalev"]
  s.email       = ["shikhalev@gmail.com"]
  s.files       = Dir["lib/**/*", "README.md", "LICENSE"]
  s.homepage    = "https://github.com/jekyll-is/jekyll-is-announcer"
  s.license     = "GPL-3.0-or-later"

  s.required_ruby_version = "~> 3.4"

  s.add_dependency "jekyll", "~> 4.3"
  s.add_dependency "liquid", "~> 4.0"
  s.add_dependency "is-static-files", "~> 0.8"
  s.add_dependency "is-ial-parser", "~> 0.8"

  s.add_development_dependency "rspec", "~> 3.13"
  s.add_development_dependency "rake", "~> 13.3"
  s.add_development_dependency "simplecov", "~> 0.22.0"
end
