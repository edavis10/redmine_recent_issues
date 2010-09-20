module RedmineRecentIssues
  module Hooks
    class ViewIssuesFormDetailsTopHook < Redmine::Hook::ViewListener
      render_on :view_issues_form_details_top, :partial => 'recent_issues/list'
    end
  end
end
