require "action_mailer"
require "active_support"
require "curb"

module Mailgun

  # Custom Delivery Error
  class DeliveryError < StandardError
  end

  # Start Delivering
  class DeliveryMethod

    attr_accessor :settings

    # Run on initialization
    def initialize(settings)
      self.settings = settings

      # Store tags here
      @tags = []
    end

    # Get the API_HOST
    def api_host
      self.settings[:api_host]
    end

    # Get the API_KEY
    def api_key
      self.settings[:api_key]
    end

    # Store Tags in an array
    def tag(*ts)
      ts.each do |t|
        @tags << t
      end
    end

    # Deliver the message
    def deliver!(mail)

      # Get the MIME Body
      body = Curl::PostField.content("message", mail.encoded)
      body.remote_file  = "message"
      body.content_type = "application/octet-stream"

      # Prep the data
      data = []
      data << body

      # Prepare the destinations
      mail.destinations.each do |destination|
        data << Curl::PostField.content("to", destination)
      end

      # Prepare the tags
      unless @tags.empty?
        @tags.each do |t|
          data << Curl::PostField.content("o:tag", t)
        end
      end

      # Create the URL string
      url = "https://api:#{self.api_key}@api.mailgun.net/v2/#{self.api_host}/messages.mime"

      # Call URL with cURL
      curl = Curl::Easy.new(url)
      curl.multipart_form_post = true
      curl.http_post(*data)

      # If the result was not successful
      if curl.response_code != 200

        begin
          # Get the error message if another exception is thrown
          error = ActiveSupport::JSON.decode(curl.body_str)["message"]
        rescue
          # Then output unknown error
          error = "Unknown Mailgun Error"
        end

        # Then raise the new error for debugging
        raise Mailgun::DeliveryError.new(error)
      end
    end

    # Catch the .deliver and reroute
    def self.delivering_email(mail)

      # Redirect into Mailgun
      mail.deliver!

      # Block all additional deliveries
      mail.perform_deliveries = false
    end
  end
end

# Register the helper
ActionMailer::Base.add_delivery_method :mailgun, Mailgun::DeliveryMethod
ActionMailer::Base.register_interceptor Mailgun::DeliveryMethod