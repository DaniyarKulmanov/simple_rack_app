# frozen_string_literal: true

module Validation

  VALIDATIONS = %i[bad_format? unknown_url?].freeze
  VALID_PARAMS = %w[year month day hour minute second].freeze

  attr_reader :status, :error_message

  def initialize(params)
    @error_message = []
    @status = 0
    @format = ''
    @bad_params = []
    format_params_read(params[:query_string])
  end

  def valid?
    validate!
    error_message.empty?
  end

  private

  attr_writer :status, :error_message
  attr_accessor :bad_params, :format

  def format_params_read(params)
    self.format = params['format'] if params['format']
    self.bad_params = (params['format'].split(',') - VALID_PARAMS) unless format.empty?
  end

  def validate!
    VALIDATIONS.each { |validation| send(validation) }
  end

  def unknown_url?
    add_error(404, "\nUnknown URL: #{path}") if path != 'time'
  end

  def bad_format?
    add_error(400, "\nUnknown time format") if format.empty?
    add_error(400, "\nUnknown time format #{bad_params}") if bad_params.any?
  end

  def add_error(status, body)
    error_message.clear
    self.status = 0
    self.status = status
    error_message << body
  end
end
