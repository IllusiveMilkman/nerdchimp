puts 'Cleaning database...'

# ============================================================
# Template for seeding (Replace "Model" with your model name):
# Model.destroy_all
# puts 'Creating Model...'
# models_array = [
#   {
#     attr1: '',
#     attr2: ''
#   },
#   {
#     attr1: '',
#     attr2: ''
#   }
# ]
# Model.create!(models_array)
# puts 'Finished creating Model'
# ============================================================

puts 'Creating Users...'
User.destroy_all
users_array = [
  {
  first_name: 'John',
  last_name: 'Ember',
  email: 'john@nerdchimp.io',
  password: '123123'
  },
  {
  # testing what happens if same names are appended to database
  first_name: 'John',
  last_name: 'Ember',
  email: 'john2@nerdchimp.io',  # Must be unique email address
  password: '123123'
  },
  {
  first_name: 'Sam',
  last_name: 'Jones',
  email: 'sam@nerdchimp.io',
  password: '123123'
  },
  {
  first_name: 'Alex',
  last_name: 'Davis',
  email: 'alex@nerdchimp.io',
  password: '123123'
  },
  {
  first_name: 'Haley',
  last_name: 'Summers',
  email: 'haley@nerdchimp.io',
  password: '123123'
  },
  {
  first_name: 'Lara',
  last_name: 'Croft',
  email: 'lara@nerdchimp.io',
  password: '123123'
  }
]
User.create!(users_array)
puts 'Finished creating users'

puts 'Finished!'
