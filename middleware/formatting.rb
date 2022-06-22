# frozen_string_literal: true

class Formatting

  VALID_PARAMS = %w[year month day hour minute second].freeze

  def initialize(app)
    @app = app
    @params = {}
    @status = 400
    @body = []
  end

  def call(env)
    self.status, headers, self.body = @app.call(env)
    extract_params(env)
    convert_date_time if valid?
    # 0. route valid?
    # 1. format nil or wrong
    # 2. check params if any not in VALID_PARAMS
    # 3. if all okay convert DateTime to given params
    [status, headers, body]
  end

  private

  attr_accessor :params, :status, :body

  def bad_status?
    status == 404
  end

  def valid?
    if bad_status?
      false
    elsif bad_format?
      self.status = 400
      false
    elsif bad_params?
      self.status = 400
      false
    else
      true
    end
  end

  def extract_params(env)
    self.params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
  end

  def bad_format?
    return unless params['format'].nil?

    self.status = 400
    body << "\nNo params given for format"
  end

  def bad_params?
    wrong_params = params['format'].split(',') - VALID_PARAMS
    return unless wrong_params.any?

    self.status = 400
    body << "\nUnknown time format #{wrong_params}"
  end

  def format
    "\n#{Time.now.strftime('%m/%d/%Y')}"
  end

  def convert_date_time
    body << format
  end
end
