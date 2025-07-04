---
trigger: model_decision
description: 
globs: 
---
 ---
description: Database best practices and patterns
globs: ["db/**/*.rb", "app/models/**/*.rb"]
---
# Database Standards and Patterns

<rule>
name: database_patterns
description: Standards for database design and usage

filters:
  - type: file_extension
    pattern: "\\.rb$"
  - type: path
    pattern: "db/|app/models/"

actions:
  - type: suggest
    message: |
      When working with databases:

      1. Schema Design:
         ```ruby
         create_table :records do |t|
           t.references :user, null: false, foreign_key: true, index: true
           t.string :status, null: false
           t.jsonb :metadata, default: {}
           t.timestamps
         end
         ```

      2. Indexing:
         - Index foreign keys
         - Index frequently queried columns
         - Use composite indexes when appropriate
         - Consider partial indexes

      3. Query Optimization:
         - Use eager loading
         - Implement proper caching
         - Avoid N+1 queries
         - Use batch processing

examples:
  - input: |
      add_index :users, :email, unique: true
    output: "Proper database indexing pattern"

metadata:
  priority: high
  version: 1.0
</rule>