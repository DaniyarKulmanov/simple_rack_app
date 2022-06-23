# frozen_string_literal: true

class Formatting
  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def initialize(app)
    @app = app
    @params = {}
    @body = []
    @result = ''
  end

  def call(env)
    status, headers, @body = @app.call(env)
    if @app.valid?
      self.params = @app.params
      convert_date_time
    end
    [status, headers, @body]
  end

  private

  attr_accessor :params, :result

  def format_time
    self.result = ''
    requested_formats = params['format'].split(',')

    requested_formats.each_with_index do |format, index|
      self.result =
        case index
        when 0
          result + FORMATS[format.to_sym]
        else
          result + '/' + FORMATS[format.to_sym]
        end
    end
    @body << "\n#{Time.now.strftime(result)}"
  end

  def convert_date_time
    format_time
  end
end
