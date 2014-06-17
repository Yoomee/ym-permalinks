Feature: Permalinks
  As an anonymous user
  I want to be able to follow permalinks
  In order to be able to see pages

  Scenario: I should be able to use a permalink if there is one
    Given there is a page with a permalink
    When I go to the permalink
    Then I should see the page

  Scenario: I should see the 404 page if the permalink doesn't exist
    Given there is not page with a permalink
    Then going to the non-existant page should raise a page not found error
