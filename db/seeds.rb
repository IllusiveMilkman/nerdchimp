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

puts 'Creating courses...'
Course.destroy_all

courses_array = [
  {
    title: 'Customer Analytics',
    description: 'Data about our browsing and buying patterns are everywhere.  From credit card transactions and online shopping carts, to customer loyalty programs and user-generated ratings/reviews, there is a staggering amount of data that can be used to describe our past buying behaviors, predict future ones, and prescribe new ways to influence future purchasing decisions.',
    url: 'https://www.coursera.org/learn/wharton-customer-analytics/home/welcome',
    provider: 'Coursera',
    category: 'Business',
    duration: 12
  },
  {
    title: 'Exploratory Data Analysis',
    description: 'his course covers the essential exploratory techniques for summarizing data. These techniques are typically applied before formal modeling commences and can help inform the development of more complex statistical models. Exploratory techniques are also important for eliminating or sharpening potential hypotheses about the world that can be addressed by the data.',
    url: 'https://www.coursera.org/learn/exploratory-data-analysis',
    provider: 'Coursera',
    category: 'Data Analysis',
    duration: 22
  },
  {
  title: 'R Programming',
  description: 'Data about our browsing and buying patterns are everywhere.  From credit card transactions and online shopping carts, to customer loyalty programs and user-generated ratings/reviews, there is a staggering amount of data that can be used to describe our past buying behaviors, predict future ones, and prescribe new ways to influence future purchasing decisions.',
  url: 'https://www.coursera.org/learn/r-programming',
  provider: 'Coursera',
  category: 'Data Science',
  duration: 34
  },
  {
  title: 'Economics: Consumer Demand',
  description: 'Learn the fundamental economic principles of consumer demand and how the relationship between price, quantity and demand affect the market.',
  url: 'https://www.edx.org/course/economics-consumer-demand-2',
  provider: 'edX',
  category: 'Economics',
  duration: 20
  },
  {
  title: "CS50's Introduction to Computer Science",
  description: "This is CS50x, Harvard University's introduction to the intellectual enterprises of computer science and the art of programming for majors and non-majors alike, with or without prior programming experience. An entry-level course taught by David J. Malan, CS50x teaches students how to think algorithmically and solve problems efficiently. Topics include abstraction, algorithms, data structures, encapsulation, resource management, security, software engineering, and web development.",
  url: 'https://www.edx.org/course/cs50s-introduction-to-computer-science',
  provider: 'edX',
  category: 'Computer Science',
  duration: 150
  },
  {
  title: 'Creative Coding',
  description: 'Creative Coding will introduce you to the fundamental concepts of object oriented programming, using code as a method for self-expression in a variety of media, such as 2D graphics, animation, image, and video processing.',
  url: 'https://www.edx.org/course/creative-coding',
  provider: 'edX',
  category: 'Computer Science',
  duration: 120
  },
]

Course.create!(courses_array)
puts 'Finished creating courses.'

puts 'Creating paths...'
Path.destroy_all

paths_array = [
  {
    title: 'My Data Science Track'
  },
  {
    title: 'Programming 101'
  },
  {
    title: 'Courses for Customer Data'
  }
]
Path.create!(paths_array)
puts 'Finished creating paths.'
puts 'Finished!'
