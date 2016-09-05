module MailingSettings
  class RequestMailingSetting < MailingSetting
    def notifier
      RequestBookNotification
    end
  end
end
