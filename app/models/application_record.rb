class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def titleize_name
		self.name = name.titleize if name
	end
  
end
