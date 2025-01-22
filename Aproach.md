# Below step-by-step description of how I approached this project and the reasoning behind each step.

It describes my thought process as I worked through the requirements:

## 1. Getting Started

I started by setting up a clear folder structure to separate the core logic (in `lib/`) from the test suite (in `spec/`). I included a `Gemfile` to manage dependencies, primarily `rspec` for testing. Running `rspec --init` generated the `spec_helper.rb`, which helped me configure the test suite from the start.

## 2. Modeling the Problem

I knew I needed a way to represent sales in a standardized format, so I created a `Transaction` class. This class captures key attributes like `type` (e.g., `good` or `service`), `buyer_country`, `buyer_type`, and potentially a `service_location` if it’s an onsite service. I put this in `lib/models/transaction.rb`.

To manage validation and behavior, I added methods like `buyer_in_spain?` and `digital?`. Early on, I recognized that distinguishing between digital and onsite services would be important, as the VAT logic differs significantly between them.

## 3. Handling Tax Logic

Next, I built a `TaxCalculator` class to encapsulate the different VAT scenarios. Rather than stuffing all logic in one place, I split it into private methods:

- `calculate_goods_tax`
- `calculate_digital_service_tax`
- `calculate_onsite_service_tax`

Each of these checks the `Transaction` attributes (such as the buyer’s country and whether they’re an individual or company) and returns the correct VAT or flags (like `reverse charge` or `export`).

## 4. Validating Countries and VAT Rates

I created a `CountryValidator` to confirm whether a given country is recognized and if it’s in the EU. Meanwhile, `VATRates` holds the numeric VAT values for different EU countries. Non-EU countries default to no defined rate or zero, which helps keep the logic consistent.

## 5. Writing Tests Early & Often

From the beginning, I wrote RSpec tests for each piece of functionality:

- **`transaction_spec.rb`** checks input validation, ensuring that invalid transaction types or buyer countries raise errors. I also wrote tests to confirm the behavior of `digital?` and other helper methods.
- **`tax_calculator_spec.rb`** tests each category of VAT application (goods in Spain, goods in other EU countries, exports outside the EU, onsite vs. digital services, etc.).
- **`country_validator_spec.rb`** and a **`vat_rates_spec.rb`** further validate the supporting classes. I made sure to test edge cases (e.g., unknown countries should raise errors).

## 6. The Core Challenge: Distinguishing Digital vs. Onsite

One tricky requirement was differentiating a “missing” service location from one that was explicitly passed as `nil`. In normal Ruby semantics, if someone omits a parameter, it’s simply `nil`, so the code can’t automatically tell “omitted” from “explicitly set to nil.” However, my tests insisted on two scenarios:

1. If `service_location` is **not provided**, it’s assumed “onsite but missing,” so it should raise an error.
2. If `service_location` is **explicitly `nil`**, that’s interpreted as a digital service, and thus it’s valid.

To fix these, I used a **“sentinel value”** approach. Essentially, I set a default of `:unspecified` for `service_location` if the parameter was omitted. Then, if `service_location` truly is `nil`, I treat it as a digital service. If it’s `:unspecified`, I raise an error for “onsite service missing a location.” This hack ensures both test cases can coexist without changing the tests themselves.

## 7. Iteration & Debugging

I iterated on the solution many times, using RSpec results to guide me. Whenever a test failed, I added debugging statements in methods like `validate!` to see the exact values of `service_location` and confirm whether `digital?` was returning true or false. Then I refined the logic until each scenario—goods, digital services, onsite services, and invalid inputs—passed as expected.

## 8. Final Demonstration & Commits

In a final pass, I created or updated a `main.rb` script with hardcoded examples for demonstration. This isn’t required by the spec, but it can be helpful for anyone who wants to run the project manually. Although I ended up with a working solution in one chunk, I would ideally make frequent commits reflecting each step—e.g., initial setup, transaction model, tax calculator logic, country validator, test expansions, and final refinements for edge cases.

---

### Conclusion

The result is a **modular system** that:

- Correctly calculates VAT for goods, digital services, and onsite services under various EU and non-EU conditions.
- Thoroughly validates transaction inputs (types, countries, buyer types).
- Passes all RSpec tests, including the tricky scenario distinguishing a missing `service_location` from an explicitly `nil` (digital) location.

If this were a real production scenario, I might refine the domain model further or have a dedicated “service type” (`:digital` vs. `:onsite`) instead of using a sentinel hack. But for the purpose of meeting the existing specs—especially the contradictory test scenarios—this solution works as expected.
