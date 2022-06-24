# frozen_string_literal: true

require_relative 'formatting'

class App
  def call(env)
    body = []
    body << Formatting.new(env).convert_date_time
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-type' => 'text/plain' }
  end
end
