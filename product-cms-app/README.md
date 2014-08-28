---
tags: sinatra, template
languages: ruby
resources: 0
---

# Sinatra App Template

## Structure

```bash
sinatra-ar-lab-template/
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   └── application_controller.rb
│   ├── models
│   │   └── sample_model.rb
│   └── views
│       └── layout.erb
├── config
│   └── environment.rb
├── config.ru
├── db
│   ├── migrate
│   ├── seeds.rb
│   └── test.sqlite
├── public
│   └── stylesheets
└── spec
    ├── controllers
    ├── features
    ├── models
    │   └── sample_model_spec.rb
    └── spec_helper.rb
```

## Usage

This template is for Sinatra-based labs with an MVC structure that use ActiveRecord.

## Resources
