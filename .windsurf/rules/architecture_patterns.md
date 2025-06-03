---
trigger: model_decision
description: Simplified architectural patterns and standards for the codebase
globs: 
---
# Architecture Pattern Standards

<rule>
name: architecture_patterns
description: |
  Enforced architectural patterns and standards.
  Emphasizes Rails conventions and simple patterns over complex abstractions.

  Forbidden Patterns:
  - Service Objects
  - Presenters
  - Decorators
  - Repository Pattern
  - Additional architectural layers beyond MVC
  - Complex abstraction layers

  Approved Patterns:
  - Standard Rails MVC
  - ActiveRecord patterns
  - Concerns for shared behavior
  - Noticed for notifications
  - Hotwire/Turbo/Stimulus.js for frontend
  - Solid Queue for background jobs
  - Minitest for testing

filters:
  - type: file_extension
    pattern: "\\.rb$"
  - type: content
    pattern: "class\\s+|module\\s+|concern\\s+"

actions:
  - type: reject
    message: |
      New architectural patterns must follow our simplified standards:

      1. Model Layer:
         - ActiveRecord models inherit from ApplicationRecord
         - Use concerns for shared behavior
         - Follow SOLID principles within Rails conventions
         - Avoid service objects and complex patterns

      2. Controller Layer:
         - Standard RESTful actions
         - Basic before_actions
         - Noticed for notifications
         - Hotwire responses

      3. View Layer:
         - Hotwire/Turbo/Stimulus.js
         - Standard Rails helpers
         - No presenters or decorators

      4. Background Jobs:
         - Use Solid Queue
         - Standard ActiveJob interface

examples:
  - input: |
      # Bad - Complex service object
      class UserProcessingService
        def self.process(data)
          # Complex processing
        end
      end

      # Good - Standard ActiveRecord model
      class User < ApplicationRecord
        include Searchable

        validates :email, presence: true, uniqueness: true

        def activate!
          update(active: true)
        end
      end
    output: "Using standard Rails MVC pattern"

metadata:
  priority: critical
  version: 1.1
  related_rules:
    - rails_conventions
    - active_record_patterns
    - testing_standards
  responsibility: "Architectural pattern simplification"
  standard_patterns:
    inheritance:
      models:
        - ApplicationRecord
    patterns:
      - Rails MVC
      - Concerns
      - ActiveRecord
    testing:
      - Minitest
    frontend:
      - Hotwire
      - Turbo
      - Stimulus.js
    background_jobs:
      - Solid Queue
</rule>