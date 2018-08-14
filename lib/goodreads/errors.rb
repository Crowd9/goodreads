module Goodreads
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class Forbidden < Error; end
  class Unauthorized < Error; end
  class NotFound < Error; end
  class UnprocessableEntity < Error
    attr_reader :response
    def initialize(response)
      @response = response
      super(errors.values.join(","))
    end

    def body_h
      Hash.from_xml(@response.body)
    end

    def errors
      body_h["errors"] || {}
    end
  end
end
