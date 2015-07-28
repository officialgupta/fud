namespace :email do
  desc "TODO"
  task digest: :environment do
    User.all.each do |user|
      UserMailer.digest(user).deliver_now
    end
  end
end
