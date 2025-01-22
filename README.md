# Tax Calculator

Since I pushed the solution in a single commit, I’ve included a separate file, **Approach.md**, detailing the reasoning and methodology behind this project. I believe this documentation offers clearer insight than multiple commits would.

This Ruby-based project calculates taxes for **goods**, **digital services**, and **onsite services** sold by **Munchitos S.A.**, a company operating from Spain (an EU member). It automatically applies the correct VAT rules or special statuses (e.g., **reverse charge**, **export**) depending on the buyer’s country and whether the buyer is an individual or a company.

### Features

- **Transaction Model**

  - Captures essential attributes: `type` (goods or service), `buyer_country`, `buyer_type`, and optional `service_location`.
  - Distinguishes between **goods**, **digital services**, and **onsite services**.

- **Tax Calculation**

  - **Physical Goods**: Applies the correct VAT or flags (reverse charge/export).
  - **Digital Services**: Similar VAT logic, but no tax for non-EU buyers.
  - **Onsite Services**: Enforces Spanish VAT if provided in Spain, no VAT otherwise.

- **Country Validator**

  - Differentiates between EU and non-EU countries.
  - Raises errors for unrecognized countries.

- **VAT Rates**

  - Stores and retrieves local VAT rates for EU countries.
  - Raises errors when encountering an undefined country.

- **Sentinel Value Handling**

  - Uses a sentinel approach (`:unspecified`) to distinguish between an **omitted** `service_location` (onsite service missing) and an **explicitly passed `nil`** (valid digital service).

- **RSpec Test Suite**
  - Covers valid/invalid transaction inputs, VAT application logic, and edge cases like missing data or unknown countries.

### Technologies

- **Ruby 3.2.0**
  - Core language for implementing the logic.
- **RSpec**
  - Testing framework ensuring correctness across transaction types and validation scenarios.

### Instructions

1. **Clone the Repository:**

   git clone <repository_url>
   cd tax_calculator

2. **Install Dependencies:**

   bundle install

3. **Run Tests:**

   rspec

4. **Demonstration:**
   Run the main.rb script to see hardcoded transactions and their VAT calculations:

   ruby main.rb

### Potential Improvements

- Explicit Service Subtypes: Instead of using a sentinel value (:unspecified), add a field like service_subtype: :digital or :onsite to eliminate confusion around “missing location vs. nil.”

- Additional Country/Tax Configurations: Expand CountryValidator and VATRates to handle more countries or special territories.

- CLI / API Integration: For production use, a command-line tool or HTTP API endpoints could make it easier to integrate this tax calculator with other systems.
