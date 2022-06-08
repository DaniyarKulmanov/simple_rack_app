# frozen_string_literal: true

require 'rack'

app = proc do |env|
  [
    200,
    { 'Content-type' => 'text/plain' },
    ["Hello world simple proc!\n"]
  ]
end

Rack::Handler::WEBrick.run app
