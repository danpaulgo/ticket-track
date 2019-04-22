require 'rails_helper'

RSpec.describe "transaction_sources/new", type: :view do
  before(:each) do
    assign(:transaction_source, TransactionSource.new())
  end

  it "renders new transaction_source form" do
    render

    assert_select "form[action=?][method=?]", transaction_sources_path, "post" do
    end
  end
end
