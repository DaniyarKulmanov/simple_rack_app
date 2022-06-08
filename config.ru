# frozen_string_literal: true

require_relative 'middleware/formatting'
require_relative 'app'

use Formatting
run App.new
