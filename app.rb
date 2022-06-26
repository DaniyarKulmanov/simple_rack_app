# frozen_string_literal: true

require_relative 'formatting'

class App
  def call(env)
    body = []
    body << Formatting.new(env).convert_date_time
    [200, {}, body]
  end
end
