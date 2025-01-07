module Notifications
    extend ActiveSupport::Concern

    included do
      # Callbacks hoặc logic mặc định
    end

    def notify_subscribers
      # Logic thông báo
      puts "Notifying subscribers..."
    end
end
