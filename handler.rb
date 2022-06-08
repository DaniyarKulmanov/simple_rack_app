# frozen_string_literal: true

require 'rack'

app = ->(env) { [200, { 'Content-type' => 'text/plain' }, ["Hello world simple proc!\n"]] }

Rack::Handler::WEBrick.run app
