module MailingSettings
  class MailingSetting < ActiveRecord::Base
    belongs_to :organisation

    validates_presence_of :admin_email
    scope :active, -> { where(is_settings_active: true) }

    def is_settings_active?
      is_settings_active
    end

    def is_mailing_active?
      is_mailing_active
    end

    def notifier
      raise "This method #{__method__} must be overwrite in #{self} model!!"
    end
  end
end
