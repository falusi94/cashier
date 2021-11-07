Feature: adding items into the cart
  Background:
    Given a setup with basic items and pricing rules

  @checkout
  Scenario: successful case
    When add green tea into the cart
      And add strawberries into the cart
      And add green tea into the cart
      And add green tea into the cart
      And add coffee into the cart
    Then the total is '22.45'

  @checkout
  Scenario: second green tea is discounted
    When add green tea into the cart
      And add green tea into the cart
    Then the total is '3.11'

  @checkout
  Scenario: after the third package of strawberries a discount of 4.5£ is applied for all packages
    When add strawberries into the cart
      And add strawberries into the cart
      And add green tea into the cart
      And add strawberries into the cart
    Then the total is '16.61'

  @checkout
  Scenario: after the third package of coffee a discount of 33% is applied for all packages
    When add green tea into the cart
      And add coffee into the cart
      And add strawberries into the cart
      And add coffee into the cart
      And add coffee into the cart
    Then the total is '30.57'
