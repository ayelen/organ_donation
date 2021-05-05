class ApplicationController < ActionController::Base

  before_action :verify_auth

    def verify_auth
      if valid_auth?
        handle_valid_auth
      else
        handle_invalid_auth
      end
    end

    def valid_auth?
      true
    end

    def handle_valid_auth
      true
    end

    def handle_invalid_auth
      true
    end

end
