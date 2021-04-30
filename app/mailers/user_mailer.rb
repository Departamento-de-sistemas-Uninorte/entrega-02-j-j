class UserMailer < ApplicationMailer
    def notif(user, user2)
        @user=user
        mail(to: user2.email, subject: 'Tienes un nuevo seguidor')
      end
end