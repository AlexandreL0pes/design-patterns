class Notifier
  def initialize(sender)
    @sender = sender
  end

  def send(message)
    puts message
    puts "From: #{@sender}"
    puts "\n"
  end
end

class Decorator 
  def initialize(notifier)
    @notifier = notifier
  end

  def send(message)
    @notifier.send(message)
  end  
end

class SmsDecorator < Decorator
  def initialize(notifier)
    super(notifier)
  end

  def send(message)
    @notifier.send("New SMS \n\t#{message}")
  end
end

class SlackDecorator < Decorator
  def initialize(notifier)
    super(notifier)
  end

  def send(message)
    @notifier.send("New Slack Message \n\t#{message}")
  end
end

class EmailDecorator < Decorator
  def initialize(notifier)
    super(notifier)
  end

  def send(message)
    @notifier.send("New Email \n\t#{message}")
  end
end

class TimeStampDecorator < Decorator
  def send(message)
    @notifier.send("#{message} \nTime: #{Time.new.strftime("%k:%M")}")
  end
end


# Creates a notifier object with an sender and email
notifier = Notifier.new('user1@gmail.com')

# Uses an single decorator
SlackDecorator.new(notifier).send("Hello!")

# Chain two decorators 
sms_notifier_with_time = SmsDecorator.new(TimeStampDecorator.new(notifier))
sms_notifier_with_time.send("Hey!")

mail_notifier_with_time = EmailDecorator.new(TimeStampDecorator.new(Notifier.new('user@gmail.com')))
mail_notifier_with_time.send("To whom it may concern...")