# frozen_string_literal: true

require_relative 'middleware/routes'
require_relative 'middleware/formatting'
require_relative 'app'

# use Formatting
use Routes
# add middleware to write formatting history to a file
run App.new
