Given /^.* I am not logged in$/ do
  delete logout_path
  # page.should have_content 'Log In'
  # page.has_content?('Log In')
end

When /^I open.* (.+)$/ do |url|
  case url
  when /the site/
    visit(root_path)
  when /the login page/
    visit(login_path)
  else
    'Can not map #{url} to URI'
  end
end

Then /^I am .+ the login page$/ do
  visit(login_path)
  page.has_content?('Log In')
  # current_path == logout_path
end

Then(/^I should see a page with email and password fields$/) do
  page.has_content?('Email')
  page.has_content?('Password')
end

When /^I enter my email and password$/ do
  visit(login_path)
  fill_in('email', :with => 'temirov@gmail.com')
  fill_in('Password', :with => 'Seekrit')
end

Given /^that I am logged into the site$/ do
  visit(login_path) 
end

