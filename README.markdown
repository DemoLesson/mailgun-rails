### Installation

Add the following to your Gemfile:

    gem 'mailgun-rails', :git => 'git://github.com/KellyLSB/mailgun-rails.git'

### Configuration

    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
        :api_key  => "YOUR_API_KEY",
        :api_host => "YOUR_API_HOST"
    }

### Mailgun Email Tagging

	mail = mail(:to => test@domain.com, :subject => 'My Subject')
	mail.delivery_method.tag('my_tag')
	mail.deliver

### Issues

1. Possible that if you are sending multiple emails in a session that it may not reset the tags

### Coming Soon

1. Mailgun analytics retrieval
2. Swithing away from cURL (or prettifying the existing code)
3. Prettifying the code