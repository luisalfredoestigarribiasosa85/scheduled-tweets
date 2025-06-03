---
trigger: model_decision
description: Enforces guidelines for configuring and managing logging in a Rails application with integrated Honeybadger error monitoring.
globs:
---

# Logging

<rule>
name: logging_standard
description: Ensures that Rails logging is configured appropriately for each environment and that Honeybadger is integrated for error monitoring, with logs formatted securely and effectively.

filters:
  - type: path
    pattern: "^(config/environments/.*\\.rb|config/initializers/honeybadger\\.rb)$"
    # Applies to environment configuration and Honeybadger initializer files

actions:
  - type: suggest
    message: |
      Logging configurations should:
      1. Set log levels appropriate for each environment (e.g., :debug in development, :info or :warn in production).
      2. Format logs for readability while avoiding the inclusion of sensitive data.
      3. Forward errors and exceptions to Honeybadger for monitoring.
      4. Ensure the Honeybadger initializer is configured with secure API key management via environment variables.
      5. Use tagging or structured logging where applicable to aid debugging.

examples:
  - input: |
      # Bad example: Using default log level in production and hardcoding sensitive information.
      # config/environments/production.rb
      Rails.application.configure do
        config.log_level = :debug
      end
      # config/initializers/honeybadger.rb with hardcoded API key:
      Honeybadger.configure do |config|
        config.api_key = "hardcoded_api_key"
      end
    output: "Avoid using verbose log levels in production and never hardcode API keys. Use environment variables instead."
  - input: |
      # Good example: Secure logging configuration with Honeybadger integration.
      # config/environments/production.rb
      Rails.application.configure do
        config.log_level = :info
        config.log_tags  = [ :request_id ]
      end
      # config/initializers/honeybadger.rb
      Honeybadger.configure do |config|
        config.api_key = ENV['HONEYBADGER_API_KEY']
        config.env = Rails.env
      end
    output: "Logging is configured with an appropriate log level, tagging, and secure Honeybadger integration for error monitoring."

metadata:
  priority: medium
  version: 1.1
  related_rules:
    - rails_project_standards
    - honeybadger_standards
  responsibility: "Standardize logging configurations and integrate Honeybadger for comprehensive error monitoring"
</rule>
