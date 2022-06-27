# frozen_string_literal: true

require_relative 'app'

use Rack::ContentType, 'text/plain'
# TODO: use Logger
run App.new
