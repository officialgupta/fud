every :sunday, :at => '12pm'  do
  rake "email:digest"
end
