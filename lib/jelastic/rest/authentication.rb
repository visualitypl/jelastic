module REST
  module Authentication
    def signin
      send_request_with_system_appid('users/authentication/rest/signin')
    end

    def signout
      send_request_with_system_appid('users/authentication/rest/signout')
    end
  end
end
