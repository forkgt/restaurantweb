class Template < ActiveRecord::Base
  has_many :subscriptions, as: :subscribable
  has_many :stores, through: :subscriptions

  # When you add/delete a templates, check these places:
  # /app/views/q/templates/yumasianbistro/*
  # /app/views/layouts/templates/yumasianbistro.html.erb
  # /app/assets/stylesheets/templates/yumasianbistro.css.scss
  # /app/assets/javascripts/templates/yumasianbistro.js
end
