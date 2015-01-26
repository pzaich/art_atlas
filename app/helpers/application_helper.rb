module ApplicationHelper
  # inspired by the localytics blog post
  # http://info.localytics.com/engineering-blog/a-year-on-angular-on-rails-a-retrospective
  def preload_ng_templates
    template_root  = Rails.root.join('app', 'assets', 'templates')

    Dir.glob("#{template_root}/**/*.html.haml").collect do |file_path|
      key = file_path.gsub(%r(^#{template_root}),'').split('.').first
      load_ng_template(key, file_path)
    end.join.html_safe
  end

  def load_ng_template(key, partial_path)
    content_tag :script, type: 'text/ng-template', id: "#{key}.html" do
      render file: "#{partial_path}"
    end
  end
end
