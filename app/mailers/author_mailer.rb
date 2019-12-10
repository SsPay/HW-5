class AuthorMailer < ApplicationMailer
  default :from => "notifications@example.com"

  def registration_confirmation(author)
    @author = author
    mail(:to => "<#{author.email}>", :subject => "Registration Confirmation")
  end

  def password_reset(author)
    @author = author
    mail to: author.email, subject: "Password Reset"
  end

end
