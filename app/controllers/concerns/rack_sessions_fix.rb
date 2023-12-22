# frozen_string_literal: true

# https://sdrmike.medium.com/rails-7-api-only-app-with-devise-and-jwt-for-authentication-1397211fb97c#:~:text=I%20was%20able%20to%20find%20a%20workaround%20to%20this%20problem%20by%20instructing%20devise%20to%20create%20a%20fake%20session%20hash.%20We%20add%20the%20following%20file%20app/controllers/concerns/rack_sessions_fix.rb%3A
module RackSessionsFix
  extend ActiveSupport::Concern
  # Mockup class
  class FakeRackSession < Hash
    def enabled?
      false
    end

    def destroy; end
  end
  included do
    before_action :set_fake_session

    private

    def set_fake_session
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
