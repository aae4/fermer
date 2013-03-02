class UserMailer < ActionMailer::Base
  default from: "formosa@fermer.com"

  def sent_mail(user)
	@user=user
	@url="http://localhost:3000/verifications/show/#{@user.verif_code}"
	mail(:to => user.email, :subject => "Registration on rails.fermer.ru")
  end

  def sent_password_reset_mail(user)
	@user=user
	@url="http://localhost:3000/reset_passwords/edit/#{@user.verif_code}"
	mail(:to => user.email, :subject => "Registration on rails.fermer.ru")
  end
end
