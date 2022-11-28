Feature: Basic Usage
  Because Everyone wants a stable tool
  The typical command line options should work

  Scenario: bnzops help
    Given I reset my options
    And I add action 'help'
    Then My output should contain 'Usage'
