require 'spec_helper'
describe 'signacert' do

  context 'with defaults for all parameters' do
    it { should contain_class('signacert') }
  end
end
