module MailingSettings
  class DetentionOfBookMailingSetting < MailingSetting

    def notifier
      DetentionOfBookNotification
    end
  end
end