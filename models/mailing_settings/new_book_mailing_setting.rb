module MailingSettings
  class NewBookMailingSetting < MailingSetting

    def notifier
      NewBooksNotification
    end

    def notification_date
      period = new_books_notify_period.to_i
      period = ENV['NEW_BOOKS_DAYS_COUNT'].to_i if period <= 0
      DateTime.current - period.days if period > 0
    end
  end

end
