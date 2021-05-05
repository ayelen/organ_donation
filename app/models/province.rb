# == Schema Information
#
# Table name: provinces
#
#  id                             :integer          not null, primary key
#  name                           :string           indexed
#  positive_quantity              :integer
#  negative_quantity              :integer
#  organ_waiting_list_quantity    :integer
#  leather_waiting_list_quantity  :integer

class Province < ActiveRecord::Base
  belongs_to :country


end
