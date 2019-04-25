class String
  def spaceless_title
    split(/\s|\_/).map(&:capitalize).join
  end
end