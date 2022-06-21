# frozen_string_literal: true
# Если неизвестных форматов несколько, все они должны быть перечислены в теле ответа,
# например: "Unknown time format [epoch, age]"

# Если среди форматов времени присутствует неизвестный формат,
# необходимо возвращать ответ с кодом статуса 400 и телом "Unknown time format [epoch]"
class Formatting
  def initialize(app)
    @app = app
  end

  def call(env)
    p self.class
    start = Time.now
    status, headers, body = @app.call(env)
    body << Time.now.strftime('%m/%d/%Y')
    body << "\nPath: #{env['PATH_INFO'].to_s}"
    body << "\nParams: #{env['QUERY_STRING'].to_s}"
    headers['X-Runtime'] = format('%fs', (Time.now - start))

    # TODO: @app.call(env) ?
    [status, headers, body]
  end
end
