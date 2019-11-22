class UsersCoursesPathDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def c_duration
    object.user_course.course.duration
  end

  def c_progress
    object.user_course.course_tracker
  end

  def c_item
    object.user_course.course
  end
end
