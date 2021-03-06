require 'clockwork'

namespace :reminders do
  desc "TODO"
  task send: :environment do
    api = Clockwork::API.new("347312a2862cccbde09c98ecc7beac7429b2b8e6")

    User.all.each do |user|
      if user.items.select{|i| i.expired_in?(7)}.count > 0
        if user.items.select{|i| i.expired_in?(7)}.count > 1
        items =
          user.items.select {|i| i.expired_in?(7)}[0..-1].map {|i| i.food.name}.join(", ") +
          " and " +
          user.items.select {|i| i.expired_in?(7)}.last.food.name
        else
          items = user.items.select {|i| i.expired_in?(7)}.first.food.name
        end

        message = api.messages.build( :to => "44#{user.phone}", :content => "Your #{items} will expire in three days, consider using them. Reply with FUD to 84477 with 'item':'status' for each item to update it's status to in-use, used, donated or disposed." )
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


end
