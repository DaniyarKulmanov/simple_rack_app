# frozen_string_literal: true

class App
  def call(_env)
    [
      200,
      { 'Content-type' => 'text/plain' },
      ["Hello world!\n"]
    ]
  end
end
