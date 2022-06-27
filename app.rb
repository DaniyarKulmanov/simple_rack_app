# frozen_string_literal: true

require_relative 'date_time_format'

class App
  def call(env)
    [200, {}, DateTimeFormat.new(env).convert]
  end
end
