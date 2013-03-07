Feature: Login with email and automatically generated password
  In order to log into the website
  A user
  Should provide his email
  And receive a password

Scenario: verify user's authorization
  Given that I am not logged in
  When I open the site
  Then I am redirected to the login page
  And I should see a page with email and password fields

Scenario: logging in with valid credentials
  Given that I am not logged in
  And I opened the login page
  When I enter my email and password
  Then I should see a message about successful login
  And I should see the users list

Scenario: logging off
  Given that I am logged into the site
  And I see the log off link
  When I click on the log off link
  Then I see the login page
  And I see a message about successful log off
