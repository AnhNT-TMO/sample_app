class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("auths.mail.subject")
  end

  def password_reset user
    @user = user

    mail to: user.email, subject: t("auths.mail.password_reset_subject")
  end
end
