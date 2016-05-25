class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def welcome_email(mail,ago)
  	#Find last report
  	@user = User.find_by(email: mail).reports_ids.last

  	@max = TwitterApi.trending_tweets.to_h
  	@ago = ago
    @mail = mail
    @url  = 'http://example.com/login'
    mail(to: @mail, subject: 'Welcome to My Awesome Site')
  end
end
