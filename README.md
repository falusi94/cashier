# Cashier
A simple cashier function that adds products to a cart and displays the total price.

## Interface
```ruby
co = Checkout.new(pricing_rules)
co.scan(item)
co.scan(item)
price = co.total
```

Create items like this:
```ruby
Item.new(product_number: '123', name: 'My item', price: 3.5)
```

By default, there are three pricing rules defined:

- `Pricing::GetOneFreeAfterN`
- `Pricing::PriceDiscountAfterN`
- `Pricing::PriceDropAfterN`

To add a new one, just inherit the `Discount::BaseDiscount` and define the `#apply` method at least.
```ruby
module Pricing
  class NewFancyPricingRule < BasePricingRule
    def apply(items, total)
      # do calculations & return reduced price
    end
  end
end
```

## Test products

Product code | Name | Price
---|---|---
GR1 | Green tea | £3.11
SR1 | Strawberries | £5.00
CF1 | Coffee | £11.23

## Special conditions:
- The CEO is a big fan of buy-one-get-one-free offers and of green tea. He wants us to add a rule to do this.
- The COO, though, likes low prices and wants people buying strawberries to get a price discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to £4.50
- The CTO is a coffee addict. If you buy 3 or more coffees, the price of all coffees should drop to two thirds of the original price.

## Test data:
- Basket: GR1,SR1,GR1,GR1,CF1
  - Total price expected: ​£22.45
- Basket: GR1,GR1
  - Total price expected: ​£3.11
- Basket: SR1,SR1,GR1,SR1
  - Total price expected:​ £16.61
- Basket: GR1,CF1,SR1,CF1,CF1
  - Total price expected:​ £30.57
