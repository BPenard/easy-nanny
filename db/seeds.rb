

puts 'Cleaning the database'
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
  role: "parent",
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

children = [
  {
    first_name: "Jane 'Eleven'",
    last_name: "Hopper",
    birthdate: "01-12-1971"
  },
  {
    first_name: "Mike",
    last_name: "Wheeler",
    birthdate: "07-04-1971"
  },
  {
    first_name: "Dustin",
    last_name: "Henderson",
    birthdate: "29-05-1971"
  },
  {
    first_name: "Lucas",
    last_name: "Sinclair",
    birthdate: "17-01-1971"
  },
  {
    first_name: "Nancy",
    last_name: "Wheeler",
    birthdate: "14-10-1967"
  }
]

children.each do |child|
  new_child = Child.new(
    first_name: child[:first_name],
    last_name: child[:last_name],
    birthdate: child[:birthdate]
  )
  new_child.user = User.all.sample
  new_child.save!
end

puts 'Creating 2 contracts'

 first_contract = Contract.new(
   start_date: "01-09-2021",
   end_date: "30-06-2023",
   type: "cdi",
   weekly_worked_hours: 35
 )





puts "- #{User.count} users created"
puts "- #{Contract.count} contracts created"
puts "- #{Child.count} children created"
