require "AfricasTalking"

module SmsHandler
# Set your app credentials
  def send_message(message, numbers)
    username = 'wehaul' # use 'sandbox' for development in the test environment
    apiKey 	= '06e5752863f6785937add2681abcede6bee42fb28274d01791c5b2aaa40e8eca' # use your sandbox app API key for development in the test environment

    # Initialize the SDK
    @AT = AfricasTalking::Initialize.new username, apiKey

    # Get the SMS service
    sms = @AT.sms

    # Set the numbers you want to send to in international format
    to = "#{numbers}"

    # Set your shortCode or senderId
    from = "6616"

    options = {
        "to" => to,
        "message" => message,
        "from" => from
    }
    begin
        # Thats it, hit send and we'll take care of the rest.
        reports = sms.send options
        reports.each {|report|
            puts report.to_yaml
        }
    rescue AfricasTalking::AfricasTalkingException => ex
        puts 'Encountered an error: ' + ex.message
    end
  end
end