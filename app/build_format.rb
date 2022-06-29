# frozen_string_literal: true

module BuildFormat
  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :body

  def display
    self.result = ''
    requested_formats = params['format'].split(',')
    build_format(requested_formats)
    ["\n#{Time.now.strftime(result)}"]
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
