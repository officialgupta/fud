require 'clockwork'

namespace :reminders do
  desc "TODO"
  task send: :environment do
    api = Clockwork::API.new( api_key )

    User.all.each do |user|
      if user.items.expired_in?(3).count > 1
      items =
        user.items.select {|i| i.expired_in?(3) && !user.items.expired_in?(3).last}.map {|i| i.name}.join(", ") +
        " and " +
        user.items.expired_in?(3).last
      else
        items = user.items.expired_in?(3).first
      end

      message = api.messages.build( :to => "441234567890", :content => "Your #{items} will expire in three days, consider using them." )
      response = message.deliver

      if response.success
          puts response.message_id
      else
          puts response.error_code
          puts response.error_description
      end
    end
  end

end
