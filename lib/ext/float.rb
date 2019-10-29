class Float
  def price
		"$#{'%.2f' % self.round(2)}"
  end
end