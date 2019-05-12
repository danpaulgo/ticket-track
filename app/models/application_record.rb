class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def titleize_name
		self.name = name.titleize if name
	end

	def formatted_date(length = :short)
		if length == :long
			date.strftime("%B %-d, %Y")
		else
			date.strftime("%-m/%-d/%Y")
		end
	end
  
end
