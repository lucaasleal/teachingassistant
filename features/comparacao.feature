Feature: As a professor
         I want to see the classes performance graph
         So that I can compare the classes of a course

Scenario: Comparing students frequency in the graph
Given I am at the performance comparison page
And I see the graph showing "Students grades average" x "Classes"
When I set the graph to show "Students frequency average"
Then I can see the graph showing "Students frequency average" x "Classes"