@tool @tool_usertours
Feature: Steps can be navigated within a tour
  In order to use a tour effectively
  As a user
  I can navigate its steps

  @javascript
  Scenario: Clicking on items in the page should not end the tour
    Given I log in as "admin"
    And I add a new user tour with:
      | Name                | Calendar tour |
      | Description         | Calendar tour |
      | Apply to URL match  | /my/% |
      | Tour is enabled     | 1 |
    And I add steps to the "Calendar tour" tour:
      | targettype | Block    | Title           | id_content                 | Content type   |
      | Block      | Calendar | Calendar events | This is the calendar block | Manual |
    And I change window size to "large"
    And I follow "Dashboard"
    And I wait until the page is ready
    And I should see "This is the calendar block"
    When I click on ".block_calendar_month .calendar-controls .next" "css_element"
    And I wait until the page is ready
    Then I should see "Calendar events"

  @javascript
  Scenario: Orphaned tour steps remain visible after scrolling
    Given I log in as "admin"
    And I add a new user tour with:
      | Name                 | Scrolled tour |
      | Description          | Scrolled tour |
      | Apply to URL match   | /my/% |
      | Tour is enabled      | 1 |
      | Display step numbers | 1 |
    And I add steps to the "Scrolled tour" tour:
      | targettype | targetvalue_selector | Title       | id_content                    | Content type |
      | Selector   | #page-footer         | Page footer | This step scrolls the page.    | Manual       |
    And I add steps to the "Scrolled tour" tour:
      | targettype                | Title         | id_content                         | Content type |
      | Display in middle of page | Orphaned step | This step remains in the viewport. | Manual       |
    And I change viewport size to "1024x768"
    When I am on homepage
    And I wait until the page is ready
    Then I should see "This step scrolls the page."
    And the page should be vertically scrolled
    When I click on "Next (1/2)" "button" in the "Page footer" "dialogue"
    And I wait until the page is ready
    Then I should see "This step remains in the viewport."
    And the user tour should be fully visible in the viewport

  @javascript
  Scenario: End tour button text for one step tours
    Given I log in as "admin"
    And I add a new user tour with:
      | Name                | Calendar tour |
      | Description         | Calendar tour |
      | Apply to URL match  | /my/% |
      | Tour is enabled     | 1 |
    And I add steps to the "Calendar tour" tour:
      | targettype | Block    | Title           | id_content                 | Content type   |
      | Block      | Calendar | Calendar events | This is the calendar block | Manual |
    And I change window size to "large"
    And I follow "Dashboard"
    And I wait until the page is ready
    And I should see "This is the calendar block"
    Then I should see "Got it"

  @javascript
  Scenario: End tour button text for multiple step tours
    Given I log in as "admin"
    And I add a new user tour with:
      | Name                | First tour |
      | Description         | My first tour |
      | Apply to URL match  | /my/% |
      | Tour is enabled     | 1 |
    And I add steps to the "First tour" tour:
      | targettype                | Title   | id_content                                                                                                                     | Content type   |
      | Display in middle of page | Welcome | Welcome to your personal learning space. We'd like to give you a quick tour to show you some of the areas you may find helpful | Manual |
    And I add steps to the "First tour" tour:
      | targettype | targetvalue_block | Title    | id_content                                                                    | Content type   |
      | Block      | Timeline          | Timeline | This is the Timeline. All of your upcoming activities can be found here       | Manual |
      | Block      | Calendar          | Calendar | This is the Calendar. All of your assignments and due dates can be found here | Manual |
    When I am on homepage
    Then I should see "Skip tour"
    And I should see "Next (1/3)"
    And I click on "Next (1/3)" "button" in the "Welcome" "dialogue"
    And I should see "Skip tour"
    And I click on "Next (2/3)" "button" in the "Timeline" "dialogue"
    And I should see "End tour"

  @javascript
  Scenario: Customised 'end tour' button text for one step tours
    Given I log in as "admin"
    And I add a new user tour with:
      | Name                    | Calendar tour |
      | Description             | Calendar tour |
      | Apply to URL match      | /my/%         |
      | Tour is enabled         | 1             |
      | End tour button's label | CustomText    |
    And I add steps to the "Calendar tour" tour:
      | targettype | Block    | Title           | id_content                 | Content type   |
      | Block      | Calendar | Calendar events | This is the calendar block | Manual |
    And I change window size to "large"
    And I follow "Dashboard"
    And I wait until the page is ready
    And I should see "This is the calendar block"
    Then I should see "CustomText"

  @javascript
  Scenario: Customised 'end tour' button text for one step tours can be translatable
    Given I log in as "admin"
    And I add a new user tour with:
      | Name                    | Calendar tour             |
      | Description             | Calendar tour             |
      | Apply to URL match      | /my/%                     |
      | Tour is enabled         | 1                         |
      | End tour button's label | exporttour,tool_usertours |
    And I add steps to the "Calendar tour" tour:
      | targettype | Block    | Title           | id_content                 | Content type   |
      | Block      | Calendar | Calendar events | This is the calendar block | Manual |
    And I change window size to "large"
    And I follow "Dashboard"
    And I wait until the page is ready
    And I should see "This is the calendar block"
    Then I should see "Export tour"
