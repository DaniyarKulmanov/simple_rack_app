# frozen_string_literal: true

require_relative 'middleware/validation'
require_relative 'app'

use Validation
run App.new
