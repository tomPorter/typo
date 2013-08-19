Feature: Merge Two Articles
  As a blog administrator
  In order to better organize my blog
  I want to be able to merge existing articles on my blog

  Background:
    Given the blog is set up
    #And I am logged out
    And the following articles exist:
    |title       |body                |
    |FooBar      |foobar is foobar    |
    |BarBaz      |barbaz is barbaz    | 

  Scenario: Non-admin should not see Merge Articles form on an article page
    When I go to the home page
    Then I should see "FooBar"
    When I follow "FooBar"
    Then I should see "foobar is foobar"
    And I should not see "Merge Articles"

  Scenario: Merged articles should contain text for both articles
    Given I am logged into the admin panel
    And I follow "All Articles"
    Then I should see "FooBar"
    And  I should see "BarBaz"
    When I follow "FooBar"
    Then I should see "Merge Articles"
    And  I fill in 'Article ID' with the ID for "BarBaz"
    And  I press "Merge"
    Then I should see "foobar is foobar\Nbarbaz is barbaz"  