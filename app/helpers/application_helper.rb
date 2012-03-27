module ApplicationHelper
  def development?
    ENV['RAILS_ENV'] == 'development'
  end

  def typogrify (*args, &block)
    if block_given?
      Typogruby.improve(capture(&block)).html_safe
    else
      Typogruby.improve(args.first).html_safe
    end
  end

  def flash_class(level)
    case level
    when :notice then 'alert-success'
    when :error then 'alert-error'
    when :alert then 'alert-alert'
    end
  end
end