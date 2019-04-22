require 'rails_helper'

RSpec.describe "transaction_sources/edit", type: :view do
  before(:each) do
    @transaction_source = assign(:transaction_source, TransactionSource.create!())
  end

  it "renders the edit transaction_source form" do
    render

    assert_select "form[action=?][method=?]", transaction_source_path(@transaction_source), "post" do
    end
  end
end
