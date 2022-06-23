# frozen_string_literal: true

class Validation
  VALIDATIONS = %i[bad_format unknown_url].freeze
  VALID_PARAMS = %w[year month day hour minute second].freeze

  attr_reader :params

  def initialize(app)
    @app = app
    @status = 400
    @params = {}
    @body = []
    @path = ''
  end

  def call(env)
    self.status, headers, self.body = @app.call(env)
    initialize_params(env)
    validate_request
    [status, headers, body]
  end

  def valid?
    @status == 200
  end

  private

  attr_accessor :status, :body, :path
  attr_writer :params

  def initialize_params(env)
    self.params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    self.path = env['PATH_INFO'].delete('/')
  end

  def validate_request
    VALIDATIONS.each { |validation| send(validation) }
  end

  def unknown_url
    add_error(404, "\nUnknown URL") if path != 'time'
  end

  def bad_format
    if format_empty?
      add_error(400, "\nUnknown time format")
    elsif bad_params.any?
      add_error(400, "\nUnknown time format #{bad_params}")
    end
  end

  def format_empty?
    params['format'].nil?
  end

  def bad_params
    p params['format']
    params['format'].split(',') - VALID_PARAMS
  end

  def add_error(status, body)
    self.body.clear
    self.status = status
    self.body << body
  end
end
