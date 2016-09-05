class MailingNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation

  attr_accessor :date

  scope :for_user, -> (user){where(:user => user)}
  scope :newest, -> {order(created_at: :desc)}
  scope :from_date, -> (date_time){where("created_at > ?", date_time)}

  def self.notification_send?(user, date = nil)
    if date.nil?
      count = self.for_user(user).count
    else
      count = self.for_user(user).from_date(date).count
    end
    count > 0
  end

  def self.save_notification_confirmation user, content
    raise "No information about the user" if !user
    raise "No information about the content" if !content
    self.create! user: user, organisation: user.organisation, content: content, description: __method__
  end

end
