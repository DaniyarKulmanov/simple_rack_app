# frozen_string_literal: true

class App
  def call(_env)
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-type' => 'text/plain' }
  end

  def body
    ["Hello world!\n"]
  end
end
