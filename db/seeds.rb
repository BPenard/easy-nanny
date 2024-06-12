puts 'Cleaning the database'
Child.all.each do |child|
  child.photo.purge
end
User.all.each do |user|
  user.photo.purge
end
Payslip.destroy_all
ChildContract.destroy_all
Event.destroy_all
Contract.destroy_all
Child.destroy_all
User.destroy_all

puts 'Creating 2 Parents'

john_doe = User.new(
  first_name: "John",
  last_name: "Doe",
  email: "john.doe@example.com",
  password: "password",
  address: "12 Rue de la Liberté, 75003 Paris, France",
  role: "parent",
  phone_number: "06.03.23.47.23"
)
john_doe.save!

jane_smith = User.new(
  first_name: "Jane",
  last_name: "Smith",
  email: "jane.smith@example.com",
  password: "password",
  address: "25 Avenue des Champs-Élysées, 75008 Paris, France",
  role: "parent",
  phone_number: "06.04.26.37.93"
)
jane_smith.save!

# parents = [john_doe, jane_smith]

# parents.each do |user|
#   new_user = User.new(
#     first_name: user[:first_name],
#     last_name: user[:last_name],
#     email: user[:email],
#     password: user[:password],
#     address: user[:address],
#     role: user[:role],
#     phone_number: user[:phone_number]
#   )
#   new_user.save!
# end

puts 'Creating 2 Nannies'

mary_poppins = User.new(
  first_name: "Mary",
  last_name: "Poppins",
  email: "mary.poppins@example.com",
  password: "password",
  address: "number 17 Cherry Tree Lane, London, England",
  role: "nanny",
  phone_number: "07.12.21.47.23"
)
mary_poppins.photo.attach(io: File.open("app/assets/images/nannies/marypoppins.png"), filename: "iphigenie.png", content_type: "image/png")
mary_poppins.save!

iphigenie_doubtfire = User.new(
  first_name: "Iphigénie",
  last_name: "Doubtfire",
  email: "iphigenie.doubtfire@example.com",
  password: "password",
  address: "2640 Steiner Street, San Francisco, United-states",
  role: "nanny",
  phone_number: "06.18.26.57.13"
)
iphigenie_doubtfire.photo.attach(io: File.open("app/assets/images/nannies/iphigenie.jpg"), filename: "iphigenie.png", content_type: "image/png")
iphigenie_doubtfire.save!

# nannies.each do |nanny|
#   new_nanny = User.new(
#     first_name: nanny[:first_name],
#     last_name: nanny[:last_name],
#     email: nanny[:email],
#     password: nanny[:password],
#     address: nanny[:address],
#     role: nanny[:role],
#     phone_number: nanny[:phone_number]
#   )
#   new_nanny.save!
# end

puts 'Creating 5 Children'

jane = Child.new(
  first_name: "Jane 'Eleven'",
  last_name: "Hopper",
  birthdate: "01-12-1971"
)
jane.user = john_doe
jane.photo.attach(io: File.open("app/assets/images/children/eleven.jpg"), filename: "eleven.png", content_type: "image/png")
jane.save!

mike = Child.new(
  first_name: "Mike",
  last_name: "Wheeler",
  birthdate: "07-04-1971",
)

mike.user = john_doe
mike.photo.attach(io: File.open("app/assets/images/children/mike.jpg"), filename: "mike.png", content_type: "image/png")
mike.save!

dustin = Child.new(
  first_name: "Dustin",
  last_name: "Henderson",
  birthdate: "29-05-1971",
)

dustin.user = john_doe
dustin.photo.attach(io: File.open("app/assets/images/children/dustin.jpg"), filename: "dustin.png", content_type: "image/png")
dustin.save!

lucas = Child.new(
  first_name: "Lucas",
  last_name: "Sinclair",
  birthdate: "17-01-1971",
)
lucas.user = jane_smith
lucas.photo.attach(io: File.open("app/assets/images/children/Lucas.jpg"), filename: "lucas.png", content_type: "image/png")
lucas.save!

nancy = Child.new(
  first_name: "Nancy",
  last_name: "Wheeler",
  birthdate: "14-10-1967",
)
nancy.user = jane_smith
nancy.photo.attach(io: File.open("app/assets/images/children/nancy.jpg"), filename: "nancy.png", content_type: "image/png")
nancy.save!

puts 'Creating 2 contracts'

first_contract = Contract.new(
  start_date: "01-01-2024",
  end_date: "09-06-2024",
  type: "cdi",
  weekly_worked_hours: 35,
  gross_hourly_rate: 10
)

first_contract.parent = john_doe
first_contract.nanny = mary_poppins
first_contract.save!

second_contract = Contract.new(
  start_date: "01-01-2022",
  type: "cdi",
  weekly_worked_hours: 40,
  gross_hourly_rate: 12
)

second_contract.parent = jane_smith
second_contract.nanny = iphigenie_doubtfire
second_contract.save!

puts "Creating ChildContracts"
User.all.each do |user|
  if user.children.count.positive? && user.role == "parent"
    user.children.each do |child|
      child.first_name
      new_user_contract = ChildContract.new
      new_user_contract.child = child
      new_user_contract.contract = user.parent_contracts.first
      new_user_contract.save!
    end
  end
end

puts 'Creating 7 events'

event1 = Event.new(
  type: "Médicament",
  start_date: "2024-06-12 14:00:00",
  description: "Enfant malade"
)

event1.contract = first_contract
event1.child = dustin
event1.save!

event2 = Event.new(
  type: "RTT",
  start_date: "2024-06-05 09:00:00",
  description: "Pose d'un RTT"
)

event2.contract = second_contract
event2.child = lucas
event2.save!

event3 = Event.new(
  type: "Absence",
  start_date: "2024-06-07 09:00:00",
  description: "N'est pas venue au travail"
)

event3.contract = second_contract
event3.child = nancy
event3.save!

event4 = Event.new(
  type: "RTT",
  start_date: "2024-06-14 09:00:00",
  description: "Les vacances au soleil"
)

event4.contract = second_contract
event4.child = nancy
event4.save!

event5 = Event.new(
  type: "Congés",
  start_date: "2024-06-11 09:00:00",
  description: "Vacances bien méritées"
)

event5.contract = first_contract
event5.child = dustin
event5.save!

event6 = Event.new(
  type: "Congés",
  start_date: "2024-06-13 09:00:00",
  description: "Vacances bien méritées"
)

event6.contract = first_contract
event6.child = dustin
event6.save!

event7 = Event.new(
  type: "Médicament",
  start_date: "2024-06-14 02:00:00",
  description: "Dustin a été malade toute la nuit"
)

event7.contract = first_contract
event7.child = dustin
event7.save!

event8 = Event.new(
  type: "Médicament",
  start_date: "2024-06-14 10:00:00",
  description: "Donner Dopliprane à Dustin (12kg)"
)

event8.contract = first_contract
event8.child = dustin
event8.save!

puts 'Creating previous payslips on contracts'

Contract.all.each do |contract|
  contract.create_previous_payslips_on_creation
end

puts "- #{User.count} users created"
puts "- #{Contract.count} contracts created"
puts "- #{Child.count} children created"
puts "- #{ChildContract.count} child_contracts created"
puts "- #{Event.count} events created"
puts "- #{Payslip.count} payslips created"
