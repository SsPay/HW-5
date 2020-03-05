# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context 'GET #index' do
    it 'returns a success response' do
      get :index
      # expect(response.success).to eq(true)
      expect(response).to be_success
    end
  end
end
