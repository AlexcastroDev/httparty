# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  gem "minitest"
  gem "httparty"
end

require "minitest/autorun"
require "logger"
require "httparty"

class BugTest < Minitest::Test
  def test_error_response
    base_uri = 'https://api.bing.microsoft.com/v7.0/images/search'
    options = {
      query: { q: 'whatever' },
      headers: { 'Ocp-Apim-Subscription-Key' => 'missing', 'Content-Type': 'application/json' },
      format: :json
    }

    response = HTTParty.get(base_uri, options)
    assert_equal response.parsed_response.class, Hash # false
  end
end
