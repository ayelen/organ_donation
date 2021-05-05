# == Schema Information
#
# Table name: countries
#
#  id                  :integer          not null, primary key
#  name                :string           indexed
#  poblation           :integer

class Country < ActiveRecord::Base
  has_many :provinces

end
