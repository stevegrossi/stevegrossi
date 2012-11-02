require 'spec_helper'

describe 'pages' do
  it 'routes a page with a slash in the permalink' do
    { get: '/is/awesome' }.should route_to(
      controller: 'pages',
      action: 'show',
      id: 'is/awesome'
    )
  end
  it 'routes a meta page with a slash in the permalink' do
    { get: '/meta/pages/is/awesome/edit' }.should route_to(
      controller: 'meta/pages',
      action: 'edit',
      id: 'is/awesome'
    )
  end
end
