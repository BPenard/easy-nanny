puts 'Cleaning the database'
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
jane.save!

mike = Child.new(
  first_name: "Mike",
  last_name: "Wheeler",
  birthdate: "07-04-1971"
)

mike.user = john_doe
mike.save!

dustin = Child.new(
  first_name: "Dustin",
  last_name: "Henderson",
  birthdate: "29-05-1971"
)

dustin.user = john_doe
dustin.save!

lucas = Child.new(
  first_name: "Lucas",
  last_name: "Sinclair",
  birthdate: "17-01-1971"
)
lucas.user = jane_smith
lucas.save!

nancy = Child.new(
  first_name: "Nancy",
  last_name: "Wheeler",
  birthdate: "14-10-1967"
)
nancy.user = jane_smith
nancy.save!

# children = [jane, mike, dustin, lucas, nancy]

# children.each do |child|
#   new_child = Child.new(
#     first_name: child[:first_name],
#     last_name: child[:last_name],
#     birthdate: child[:birthdate]
#   )
#   new_child.user = User.all.sample
#   new_child.save!
# end

puts 'Creating 2 contracts'

first_contract = Contract.new(
  start_date: "01-09-2021",
  end_date: "30-06-2023",
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
  if user.children.count > 0 && user.role == "parent"
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
  date: "2024-06-12",
  description: "Enfant malade"
)

event1.contract = first_contract
event1.child = dustin
event1.save!

event2 = Event.new(
  type: "RTT",
  date: "2024-06-05",
  description: "Pose d'un RTT"
)

event2.contract = second_contract
event2.child = lucas
event2.save!

event3 = Event.new(
  type: "Absence",
  date: "2024-06-03",
  description: "N'est pas venue au travail"
)

event3.contract = second_contract
event3.child = nancy
event3.save!

event4 = Event.new(
  type: "RTT",
  date: "2024-10-03",
  description: "Les vacances au soleil"
)

event4.contract = second_contract
event4.child = nancy
event4.save!

event5 = Event.new(
  type: "Congés",
  date: "2024-06-06",
  description: "Vacances bien méritées"
)

event5.contract = first_contract
event5.child = dustin
event5.save!

event6 = Event.new(
  type: "Congés",
  date: "2024-06-07",
  description: "Vacances bien méritées"
)

event6.contract = first_contract
event6.child = dustin
event6.save!

event7 = Event.new(
  type: "Médicament",
  date: "2024-06-04",
  description: "Dustin a été malade toute la nuit"
)

event7.contract = first_contract
event7.child = dustin
event7.save!
puts "- #{User.count} users created"
puts "- #{Contract.count} contracts created"
puts "- #{Child.count} children created"
puts "- #{ChildContract.count} child_contracts created"
puts "- #{Event.count} events created"
