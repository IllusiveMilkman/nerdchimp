# json.array! @usercourses do |usercourse|
#   json.extract! usercourse, :id, :user, :course, :course_tracker
# end
json.extract! @course, :id, :title, :description
