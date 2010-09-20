require 'redmine'

Redmine::Plugin.register :redmine_recent_issues do
  name 'Redmine Recent Issues plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  settings :default => {'recent_issue_count' => '5'}, :partial => 'settings/recent_issues'
end

require 'redmine_recent_issues/hooks/view_issues_form_details_top_hook'
