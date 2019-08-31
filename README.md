# Midnight::Mongoid
## What is it?
It is the [Mongoid](https://docs.mongodb.com/mongoid/) integration of [Midnight::BusinessLogic](https://rubygems.org/gems/midnight-business_logic).  
  
Midnight::BusinessLogic enables you to write your business logics without worrying about the underlying storage engine,
but in real applications, you need some persistence layer anyway.  
  
[Midnight::Rails](https://rubygems.org/gems/midnight-rails) comes with the [Active Record](https://rubygems.org/gems/activerecord)
integration by default. This library provides an alternative of such integration,
for those who powered their app with
[MongoDB](https://www.mongodb.com/) or
[MongoDB like](https://aws.amazon.com/documentdb/) databases.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'midnight-mongoid'

# you probably also need Midnight::Rails
# for default integrations of something else apart from the Active Record
gem 'midnight-rails'
```

And then execute:

    $ bundle

## Maintainer
- Sarun Rattanasiri (
[GitLab](https://gitlab.com/midnight-wonderer),
[GitHub](https://github.com/midnight-wonderer),
midnight_w\[a]gmx\[.]tw
)

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/midnight-wonderer/midnight-mongoid.

## License
Midnight::Mongoid is released under the [3-clause BSD License](LICENSE.md).
