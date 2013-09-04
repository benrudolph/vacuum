require 'jeff'

module Vacuum
  # An Amazon Product Advertising API request.
  class Request
    include Jeff

    BadLocale  = Class.new(ArgumentError)

    # A list of Amazon Product Advertising API hosts.
    HOSTS = {
      'CA' => 'ecs.amazonaws.ca',
      'CN' => 'webservices.amazon.cn',
      'DE' => 'ecs.amazonaws.de',
      'ES' => 'webservices.amazon.es',
      'FR' => 'ecs.amazonaws.fr',
      'IT' => 'webservices.amazon.it',
      'JP' => 'ecs.amazonaws.jp',
      'GB' => 'ecs.amazonaws.co.uk',
      'US' => 'ecs.amazonaws.com'
    }.freeze

    params 'AssociateTag' => -> { associate_tag },
           'Service'      => 'AWSECommerceService',
           'Version'      => '2011-08-01'

    # Create a new request for given locale.
    #
    # locale - The String Product Advertising API locale (default: US).
    #
    # Raises a Bad Locale error if locale is not valid.
    def initialize(locale = nil)
      if locale == 'UK'
        warn '[DEPRECATION] Use GB instead of UK'
        locale = 'GB'
      end

      host = HOSTS[locale || 'US'] or raise BadLocale
      self.endpoint = "http://#{host}/onca/xml"
    end

    # Configure the Amazon Product Advertising API request.
    #
    # credentials - The Hash credentials of the API endpoint.
    #               :aws_access_key_id     - The String Amazon Web Services
    #                                        (AWS) key.
    #               :aws_secret_access_key - The String AWS secret.
    #               :associate_tag         - The String Associate Tag.
    #
    # Returns nothing.
    def configure(credentials)
      credentials.each { |key, val| self.send("#{key}=", val) }
    end

    # Get/Sets the String Associate Tag.
    attr_accessor :associate_tag
    # Keep around old attribute for a while for backward compatibility.
    alias :tag :associate_tag
    alias :tag= :associate_tag=

    # Build a URL.
    #
    # params - A Hash of Amazon Product Advertising query params.
    #
    # Returns the built URL String.
    def url(params)
      opts = {
        :method => :get,
        :query  => params
      }

      [endpoint, build_options(opts).fetch(:query)].join('?')
    end
  end
end
