# frozen_string_literal: true

class Formatting

  def initialize(app)
    @app = app
    @params = {}
    @body = []
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

  attr_writer :params

  def format_time
    "\n#{Time.now.strftime('%m/%d/%Y')}"
  end

  def convert_date_time
    @body << format_time
  end
end
