module MailingSettingsConcern
  extend ActiveSupport::Concern

  Dir["app/models/mailing_settings/*.rb"].each {|file|
    require file.sub! 'app/models/', ''
  }
  MAILING_SETTINGS_CLASSES = MailingSettings::MailingSetting.descendants.map(&:name)

  included do
    MAILING_SETTINGS_CLASSES.each { |class_name|
      #Creates has_many associations for all models that inherited from MailingSetting
      #example: new_book_mailing_settings

      has_many class_name.demodulize.tableize.to_sym, class_name: class_name
    }
  end

  MAILING_SETTINGS_CLASSES.each { |class_name|
    #Creates method that returns single record from has_many association
    #example: new_book_mailing
    method_name = class_name.demodulize.tableize.remove('_settings')
    define_method method_name do
      eval "#{class_name.demodulize.tableize}.active.first"
    end

    #Creates method that checks if is any active mailing in associated mailing
    #example: has_new_book_mailing?
    define_method "has_#{method_name}?" do
      mailing = eval "#{method_name}"
      mailing && mailing.is_mailing_active?
    end

    #Creates method that returns single record from has_many association
    #example: active_new_book_mailing
    define_method "active_#{method_name}" do
      mailing = eval "#{method_name}"
      mailing if mailing && mailing.is_mailing_active?
    end
  }
end