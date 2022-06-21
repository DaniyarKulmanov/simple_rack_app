# frozen_string_literal: true

class Formatting
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    if valid?(status)
      body << "\n#{Time.now.strftime('%m/%d/%Y')}"
      body << "\nPath: #{env['PATH_INFO'].to_s}"
      body << "\nParams: #{env['QUERY_STRING'].to_s}"
    end

    [status, headers, body]
  end

  private

  def valid?(status)
    status == 200
  end
end
