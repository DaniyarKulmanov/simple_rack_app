# frozen_string_literal: true

class Routes
  REQUEST = {
    time: 200
  }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    _status, headers, body = @app.call(env)
    status = status_of(extract_path(env))
    invalid_url(body) unless valid?(status)
    [status, headers, body]
  end

  def valid?(status)
    status == 200
  end

  private

  def extract_path(env)
    env['PATH_INFO'].delete('/').to_sym
  end

  def status_of(path)
    REQUEST[path] || 404
  end

  def invalid_url(body)
    body.clear
    body << "\nUnknown URL"
  end
end
