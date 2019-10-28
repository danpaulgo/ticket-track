class String
  def spaceless_title
    downcase.split(/\s|\_/).map(&:capitalize).join
  end

  def digest
  	BCrypt::Password.create(self)
  end
end