require 'rails_helper'

RSpec.describe "transaction_sources/show", type: :view do
  before(:each) do
    @transaction_source = assign(:transaction_source, TransactionSource.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
