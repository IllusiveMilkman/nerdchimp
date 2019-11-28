require 'nokogiri'
require 'open-uri'

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
  password: '123123',
  remote_photo_url: "https://res.cloudinary.com/drdm61dhy/image/upload/v1574940874/nerdchimp/User_1_nkzcin.jpg"
  },
  {
  # testing what happens if same names are appended to database
  first_name: 'John',
  last_name: 'Ember',
  email: 'john2@nerdchimp.io',  # Must be unique email address
  password: '123123',
  remote_photo_url: "https://res.cloudinary.com/drdm61dhy/image/upload/v1574257753/nerdchimp/Charles_wvep0m.jpg"
  },
  {
  first_name: 'Sam',
  last_name: 'Jones',
  email: 'sam@nerdchimp.io',
  password: '123123',
  remote_photo_url: "https://res.cloudinary.com/drdm61dhy/image/upload/v1574949255/nerdchimp/Profile_Picture_h562wp.jpg"
  },
  {
  first_name: 'James',
  last_name: 'Bond',
  email: 'alex@nerdchimp.io',
  password: '123123',
  remote_photo_url: "https://res.cloudinary.com/drdm61dhy/image/upload/v1574257896/nerdchimp/James_Bond_i5l5og.jpg"
  },
  {
  first_name: 'Haley',
  last_name: 'Summers',
  email: 'haley@nerdchimp.io',
  password: '123123',
  remote_photo_url: "https://res.cloudinary.com/drdm61dhy/image/upload/v1574257896/nerdchimp/Octocat_itmdrk.png"
  },
  {
  first_name: 'Lara',
  last_name: 'Croft',
  email: 'lara@nerdchimp.io',
  password: '123123',
  remote_photo_url: "https://res.cloudinary.com/drdm61dhy/image/upload/v1574258088/nerdchimp/Lara_Croft_knq7v7.jpg"
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

#########################
puts "Started edX RSS Course seeding..."
for n in (2..4) do
  document = Nokogiri::XML(open("https://www.edx.org/api/v2/report/course-feed/rss?page=#{n}"))

  edx_array = document.root.xpath('channel/item').map do |course|
    {
      title: course.xpath('title').text,
      description: course.xpath('description').text,
      url: course.xpath('link').text,
      provider: 'edX',
      category: course.xpath('course:subject').text,
      duration: course.xpath('course:length').text.split.first.to_i * course.xpath('course:effort').text.gsub('-', ' ').split.select {|i| i[/\d/]}.max.to_i # Duration in Hours
    }
  end
  Course.create!(edx_array)
end
##########################

puts 'Finished creating courses.'

puts 'Creating paths...'
Path.destroy_all

paths_array = [
  {
    title: 'My Data Science Track',
    user: User.first
  },
  {
    title: 'Programming 101',
    user: User.first
  },
  {
    title: 'My Empty Path',
    user: User.first
  },

  {
    title: 'Courses for Customer Data',
    user: User.second
  },
  {
    title: 'Courses for Data Analytics',
    user: User.second
  }
]
Path.create!(paths_array)
puts 'Finished creating paths.'

puts 'Creating UserCourses'
UserCourse.destroy_all

courses_array = Course.all

UserCourse.create([
  {
  user: User.first,
  course: courses_array[0],
  course_tracker: 0.0
  },
  {
  user: User.first,
  course: courses_array[1],
  course_tracker: 0.0
  },
  {
  user: User.first,
  course: courses_array[2],
  course_tracker: 0.0
  },
  {
  user: User.first,
  course: courses_array[3],
  course_tracker: 0.0
  },
  {
  user: User.first,
  course: courses_array[4],
  course_tracker: 0.0
  },
  {
  user: User.first,
  course: courses_array[5],
  course_tracker: 0.0
  },
  {
  user: User.second,
  course: Course.second,
  course_tracker: 0.93
  }
])
puts 'finished creating UsersCourses'

puts 'Creating UserCoursesPaths...'
UsersCoursesPath.destroy_all

users_paths = [
  {
    position: 0,
    user_course: UserCourse.first,
    path: Path.first
  },
  {

    position: 2,
    user_course: UserCourse.third,
    path: Path.first
  },
  {
    position: 1,
    user_course: UserCourse.second,
    path: Path.first
  },
  {
    position: 1,
    user_course: UserCourse.second,
    path: Path.second
  }
]

UsersCoursesPath.create!(users_paths)
puts 'Finished creating UsersCoursesPaths.'
puts 'Finished!'
