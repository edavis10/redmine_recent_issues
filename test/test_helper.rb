# Load the normal Rails helper
require File.expand_path(File.dirname(__FILE__) + '/../../../../test/test_helper')

# Ensure that we are using the temporary fixture path
Engines::Testing.set_fixture_path

require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end

module IntegrationTestHelper
  def login_as(user="existing", password="existing")
    visit "/login"
    fill_in 'Login', :with => user
    fill_in 'Password', :with => password
    click_button 'login'
    assert_response :success
    assert User.current.logged?
  end

  def visit_project(project)
    visit '/'
    assert_response :success

    click_link 'Projects'
    assert_response :success

    click_link project.name
    assert_response :success
  end

  def visit_issue_page(issue)
    visit '/issues/' + issue.id.to_s
    assert_response :success
  end

  def assert_forbidden
    assert_response :forbidden
    assert_template 'common/403'
  end
  
end

class ActionController::IntegrationTest
  include IntegrationTestHelper
end
