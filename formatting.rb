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

  attr_reader :body

  def initialize(env)
    @params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    @result = ''
  end

  def convert_date_time
    self.result = ''
    requested_formats = params['format'].split(',')
    build_format(requested_formats)
    "\n#{Time.now.strftime(result)}"
  end

  private

  attr_accessor :params, :result

  def build_format(requested_formats)
    requested_formats.each_with_index do |format, index|
      self.result =
        case index
        when 0
          result + FORMATS[format.to_sym]
        else
          "#{result}-#{FORMATS[format.to_sym]}"
        end
    end
  end
end
