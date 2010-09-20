require 'redmine'

Redmine::Plugin.register :redmine_recent_issues do
  name 'Recent Issues'
  author 'Eric Davis'
  url 'https://projects.littlestreamsoftware.com/projects/redmine-recent-issue'
  author_url 'http://www.littlestreamsoftware.com'
  description 'Redmine plugin to show the recent issues reported to help prevent duplicate bug reports.'
  version '0.1.0'

  settings :default => {'recent_issue_count' => '5'}, :partial => 'settings/recent_issues'
end

require 'redmine_recent_issues/hooks/view_issues_form_details_top_hook'
