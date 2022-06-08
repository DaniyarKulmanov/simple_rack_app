# frozen_string_literal: true

class Formatting
  def initialize(app)
    @app = app
  end

  def call(env)
    start = Time.now
    status, headers, body = @app.call(env)
    body << Time.now.strftime('%m/%d/%Y')
    headers['X-Runtime'] = format('%fs', (Time.now - start))

    [status, headers, body]
  end
end
