require File.dirname(__FILE__) + '/../../../test_helper'

class RedmineRecentIssues::Hooks::ViewIssuesFormDetailsTopTest < ActionController::IntegrationTest
  include Redmine::Hook::Helper

  context "#view_issues_form_details_top" do
    setup do
      IssueStatus.generate!(:is_default => true)
      @user = User.generate!(:login => 'test', :password => 'test', :password_confirmation => 'test')
      @project = Project.generate!.reload
      User.add_to_project(@user, @project, Role.generate!(:permissions => [:view_issues, :add_issues, :edit_issues]))
      login_as('test', 'test')

      @issue1 = Issue.generate_for_project!(@project).reload
      @issue2 = Issue.generate_for_project!(@project).reload
      @issue3 = Issue.generate_for_project!(@project).reload
      @issue4 = Issue.generate_for_project!(@project).reload
      
    end

    context "on a project" do
      setup do
        visit_project(@project)
        click_link "New issue"
        assert_response :success
      end
      
      should "show the last reported issues for a project" do
        assert_select ".recent-issues" do
          assert_select ".issue-#{@issue2.id}"
          assert_select ".issue-#{@issue3.id}"
          assert_select ".issue-#{@issue4.id}"
          assert_select ".issue-#{@issue1.id}", :count => 0 # Over limit
        end
        
      end
      
      should "have a watcher link to let the user watch an issue" do
        assert_select ".recent-issues" do
          assert_select "#watch-#{@issue2.id}"
          assert_select "#watch-#{@issue3.id}"
          assert_select "#watch-#{@issue4.id}"
          assert_select "#watch-#{@issue1.id}", :count => 0 # Over limit
        end
      end
      
      should "have a tooltip for each issue" do
        assert_select ".issue-#{@issue2.id} .tip"
        assert_select ".issue-#{@issue3.id} .tip"
        assert_select ".issue-#{@issue4.id} .tip"
      end
      
    end

    context "without a project" do
      should "show the last reported issues for all projects"
      should "have a watcher link to let the user watch an issue"
      should "have a tooltip for each issue"
    end
    
  end
end
