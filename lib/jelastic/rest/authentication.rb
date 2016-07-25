module REST
  module Authentication
    def signin
      send_request('users/authentication/rest/signin')
    end

    def signout
      send_request('users/authentication/rest/signout')
    end
  end
end
