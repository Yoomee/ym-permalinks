# YmPermalinks

This gem provides unique, top-level urls for selected models in your app.

## Installation

Add to your Gemfile
```
gem 'ym_permalinks'
```
run the install generator,
```
rails generate ym_permalinks:install
```
then migrate.
```
rake db:migrate
```
In the model that you wish to have permalinks, add

```
has_permalinks
```

ym_permalinks uses the to_s method to create the permalink, so make sure there is one.

The permalink will be created if there is a (at least a blank) permalink_path passed, so either add it to your form, or add a hidden field with the value ' '

```
form.input :permalink_path
```
OR
```
form.hidden_field :permalink_path, value: ' '
```


## Tests
To run the tests
```
 rake -f test/dummy/Rakefile db:drop db:create db:migrate test:prepare
 rspec
 cucumber
```
