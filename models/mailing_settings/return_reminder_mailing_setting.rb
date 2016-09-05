module MailingSettings
  class ReturnReminderMailingSetting < MailingSetting

    def notifier
      ReturnDateReminderNotification
    end

    def notification_date
      period = new_books_notify_period.to_i
      period = ENV['RETURN_DATE_REMINDER_DAYS_COUNT'].to_i if period <= 0
      DateTime.current - period.days if period > 0
    end
  end
end