# frozen_string_literal: true

class Formatting

  VALID_PARAMS = %w[year month day hour minute second].freeze

  def initialize(app)
    @app = app
    @params = {}
  end

  def call(env)
    status, headers, body = @app.call(env)
    extract_params(env)
    if @app.valid?(status)
      body << "\n#{Time.now.strftime('%m/%d/%Y')}"
      if bad_format?
        status = 400
        body << "\nUnknown time format"
      end

      body << bad_params.to_s
    end

    [status, headers, body]
  end

  private

  attr_accessor :params

  def extract_params(env)
    self.params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
  end

  def bad_format?
    params['format'].nil?
  end

  def bad_params
    params['format'].split(',') - VALID_PARAMS
  end
end
