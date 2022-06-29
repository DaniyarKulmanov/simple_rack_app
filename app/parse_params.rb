# frozen_string_literal: true

require_relative 'validation'

class ParseParams
  include Validation

  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :body

  def initialize(params)
    super
    @params = params[:query_string]
    @path = params[:path_info]
  end

  def display_data
    self.result = ''
    requested_formats = params['format'].split(',')
    build_format(requested_formats)
    ["\n#{Time.now.strftime(result)}"]
  end

  private

  attr_accessor :params, :path, :result

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
