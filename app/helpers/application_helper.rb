module ApplicationHelper
  def development?
    ENV['RAILS_ENV'] == 'development'
  end
end
