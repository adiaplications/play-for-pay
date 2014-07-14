class User < ActiveRecord::Base
  has_many :user_downloads

  has_secure_password

  def self.unique_gmail_email(email)
    return email if email =~ /^(adi.aplications)\+\w+@gmail\.com$/i
    email = email.gsub(/([^+]*)\+(.*)@gmail.com/i,"\\1@gmail.com")
    if email.match(/@gmail.com$/i)
      email = email[0..email.index('@')].gsub(/\./,'')+'gmail.com'
    end
    email
  end
end
