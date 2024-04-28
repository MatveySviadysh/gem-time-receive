


**time_receive**

This Ruby gem provides a collection of utility methods for working with time-related tasks, including formatting, parsing, countdown timers, and date calculations.

**Features:**

* Format time objects into various string representations using custom formats.
* Parse time strings into Time objects using a specified format.
* Create countdown timers that display the remaining time until a user-defined deadline.
* Check if a time falls on the current date.
* Calculate the number of days until a target date.
* Add specific time periods (hours, minutes, or days) to a Time object.
* Calculate the elapsed time between two Time objects.

**Installation**

1. Add the gem to your Gemfile:

   ```ruby
   gem 'time_receive'
   ```

2. Install the gem:

   ```bash
   bundle install
   ```

**Usage**

1. Require the `time_receive` module in your Ruby code:

   ```ruby
   require 'time_receive'
   ```

2. Use the provided methods:

   **Formatting Time:**

   ```ruby
   formatted_time = TimeReceive.now("%d/%m/%Y %H:%M")  # Output: 28/04/2024 00:58
   ```

   **Parsing Time String:**

   ```ruby
   time_object = TimeReceive.parse_time("2024-05-09 10:00:00", "%Y-%m-%d %H:%M:%S")
   ```

   **Countdown Timer:**

   ```ruby
   deadline = Time.now + 60 * 60  # One hour from now
   TimeReceive.timer(deadline) do
     puts "Time is up!"
   end
   ```

   **Other Methods:**

   See the code documentation for details on `today?`, `days_until`, `add_time_period`, and `calculate_elapsed_time`.

**Error Handling**

`TimeReceive` raises `TimeReceiveError` if invalid arguments are provided to methods. Ensure you pass appropriate types (e.g., `Time` objects, `Date` objects, valid time strings, and supported time periods).

**Contributing**

We welcome contributions to this project! Feel free to fork the repository, make changes, and submit a pull request.

**License**

This gem is licensed under the MIT License. See the LICENSE file for details.
```

**Explanation:**

* **Clear and concise title:** The title "time_receive" is straightforward.
* **Informative description:** The description explains the gem's purpose and key features.
* **Detailed installation steps:** The guide covers adding the gem to the Gemfile and running `bundle install`.
* **Comprehensive usage examples:** The examples demonstrate various functionalities with clear explanations.
* **Error handling guidance:** Users are informed about potential errors and how to avoid them.
* **Contribution guidelines (optional):** If you plan to accept contributions, include instructions.
* **License information:** Specify the license under which the gem is distributed.

**Additional Tips:**

* Consider adding a badge for the Ruby version supported by the gem.
* Include links to the source code repository (if applicable) and any relevant documentation.
* Maintain up-to-date documentation as the gem evolves.

I hope this enhanced README file serves you well!