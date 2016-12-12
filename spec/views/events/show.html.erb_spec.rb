require 'rails_helper'

RSpec.describe 'events/show', type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      title: 'Title',
      description: 'MyText',
      address: 'Address'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Address/)
  end
end
