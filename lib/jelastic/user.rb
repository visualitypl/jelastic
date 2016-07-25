class User
  attr_reader :uid, :email, :session, :status

  def initialize(params = {})
    @uid     = params.fetch('uid')
    @email   = params.fetch('email')
    @session = params.fetch('session')
    @status  = params.fetch('status')
  end
end
