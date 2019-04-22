require 'rails_helper'

RSpec.describe "transaction_sources/index", type: :view do
  before(:each) do
    assign(:transaction_sources, [
      TransactionSource.create!(),
      TransactionSource.create!()
    ])
  end

  it "renders a list of transaction_sources" do
    render
  end
end
