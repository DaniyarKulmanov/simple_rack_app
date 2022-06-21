# frozen_string_literal: true
# При запросе на любой другой URL необходимо возвращать ответ с кодом статуса 404

class Routes

  REQUEST = {
    time: 200
  }.freeze

  def initialize(app)
    @app = app
  end

  # TODO: [status, headers, body]  ?
  def call(env)
    status, headers, body = @app.call(env)
    status = status(env)
    [status, headers, body]
  end

  private

  def request(path)
    REQUEST[path] || 404
  end

  def status(env)
    path = env['PATH_INFO'].delete('/')
    request(path.to_sym)
  end
end
