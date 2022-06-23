# frozen_string_literal: true

class Validation
  REQUEST = {
    time: 200
  }.freeze

  def initialize(app)
    @app = app
    @status = 200
  end

  def call(env)
    self.status, headers, body = @app.call(env)
    self.status = status_of(extract_path(env))
    invalid_url(body) unless valid?
    [status, headers, body]
  end

  # move all validations from formatting here
  # make like validations module in ruby_full
  def valid?
    status == 200

    VALIDATIONS.each do |validation|
      break if validation
    end
  end

  private

  attr_accessor :status

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
