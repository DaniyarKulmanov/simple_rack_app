# frozen_string_literal: true

require_relative 'app/build_format'
require_relative 'app/parse_params'

class App
  def call(env)
    result = ParseParams.new(params(env))

    if result.valid?
      [200, {}, result.display]
    else
      [result.status, {}, result.error_message]
    end
  end

  private

  def params(env)
    params = {}
    params[:params] = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    params[:path] = env['PATH_INFO'].delete('/')
    params
  end
end
