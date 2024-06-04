class ErrorMessage
  attr_reader :message, :status
  
  def initialize(message)
     @message = message
  end
end