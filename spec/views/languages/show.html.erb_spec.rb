require 'rails_helper'

RSpec.describe 'languages/show', type: :view do
  before(:each) do
    @language = assign(:language, Language.create!(
      description: 'Description'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Description/)
  end
end
