module MailingSettings
  class ReturnMailingSetting < MailingSetting

    def notifier
      ReturnBookNotification
    end
  end
end