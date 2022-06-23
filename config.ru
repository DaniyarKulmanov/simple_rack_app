# frozen_string_literal: true

require_relative 'middleware/validation'
require_relative 'middleware/formatting'
require_relative 'app'

# use Formatting
use Validation
# add middleware to write formatting history to a file
run App.new
