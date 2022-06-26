# frozen_string_literal: true

require_relative 'middleware/validation'
require_relative 'app'

use Rack::ContentType, 'text/plain'
use Validation
run App.new
