Feature: Basis
  In order to promote the use of Ruby and Rails in Bellingham
  As a member of #bhamruby
  I should be able to record and share my activities.
  
  @wip
  Scenario: Basic Classes and Relationships
    Then a person should belong to a company
    And a person has many projects
    And a person has many events
    And a person has many attendances of events
    And a company should have many people
    And a company belongs to an owner
    And a company has many projects
    And a project has many people
    And a project belongs to a maintainer
    And a project has many companies
    And an event belongs to a coordinator
    And an event has many attending_people
    And an event has many declining_people
    And an event has many uncommitted_people
