# frozen_string_literal: true

class ParseParams
  VALIDATIONS = %i[bad_format unknown_url].freeze
  VALID_PARAMS = %w[year month day hour minute second].freeze

  attr_reader :status

  def initialize(params, path)
    @params = params
    @path = path
    @error_message = []
    @status = 0
  end

  def valid?
    unknown_url ? bad_format : positive_status
  end

  private

  attr_reader :params, :path
  attr_accessor :error_message
  attr_writer :status

  def positive_status
    self.status = 200
    true
  end

  def unknown_url
    if path != 'time'
      add_error(404, "\nUnknown URL")
      false
    else
      positive_status
    end
  end

  def bad_format
    if format_empty?
      add_error(400, "\nUnknown time format")
      false
    elsif bad_params.any?
      add_error(400, "\nUnknown time format #{bad_params}")
      false
    else
      positive_status
    end
  end

  def format_empty?
    params['format'].nil?
  end

  def bad_params
    params['format'].split(',') - VALID_PARAMS
  end

  def add_error(status, body)
    error_message.clear
    self.status = 0
    self.status = status
    error_message << body
  end
end
