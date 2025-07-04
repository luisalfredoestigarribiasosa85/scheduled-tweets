---
trigger: model_decision
description: Testing standards and best practices for RSpec
globs: ['spec/**/*_spec.rb']
---
# Testing Standards and Patterns

<rule>
name: testing_standards
description: Standards for writing and organizing tests using RSpec, FactoryBot, and related testing tools

filters:
  - type: file_extension
    pattern: "_spec\\.rb$"
  - type: path
    pattern: "spec/.*\\.rb$"

actions:
  - type: suggest
    message: |
      When writing tests:

      1. File Organization:
         ```ruby:spec/models/user_spec.rb
         require "rails_helper"

         RSpec.describe User, type: :model do
           # Group by functionality
           describe "validations" do
             it { is_expected.to validate_presence_of(:email) }
           end

           describe "associations" do
             it { is_expected.to have_many(:posts) }
           end

           # Group complex methods separately
           describe "#complex_method" do
             context "when condition is true" do
               it "does something specific" do
                 # Test implementation
               end
             end
           end
         end
         ```

      2. Factory Usage:
         ```ruby:spec/factories/users.rb
         FactoryBot.define do
           factory :user do
             email { Faker::Internet.email }
             
             # Use traits for variations
             trait :admin do
               admin { true }
             end

             # Use transient attributes for flexibility
             transient do
               posts_count { 0 }
             end

             # Use callbacks sparingly
             after(:create) do |user, evaluator|
               create_list(:post, evaluator.posts_count, user: user)
             end
           end
         end
         ```

      3. Shared Examples:
         ```ruby:spec/shared_examples/notifiable.rb
         RSpec.shared_examples "notifiable" do
           it { is_expected.to have_many(:notifications) }
           
           it "sends notifications" do
             expect { subject.notify! }
               .to change(Notification, :count).by(1)
           end
         end
         ```

      4. Testing Best Practices:
         - Use `subject` for the main object under test
         - Use `let` for setup, `let!` sparingly
         - Use meaningful example descriptions
         - One expectation per example (when practical)
         - Use proper setup/teardown with `before`/`after`
         - Mock external services with WebMock/VCR
         - Test edge cases and error conditions
         - Use shared examples for common behavior
         - Use shared contexts for common setup

      5. Required Test Coverage:
         - Models: validations, associations, methods
         - Controllers: each action, error cases
         - Mailers: delivery, content
         - Jobs: performance, retries
         - Services: success/failure cases
         - Notifications: delivery methods

      6. Notification Testing Pattern:
         ```ruby:spec/notifications/comment_notification_spec.rb
         RSpec.describe CommentNotification, type: :notification do
           let(:record) { create(:comment) }
           let(:recipient) { create(:user) }
           let(:notification) { described_class.with(record: record, action: "created") }

           it "delivers via database" do
             expect { notification.deliver(recipient) }
               .to change(Notification, :count).by(1)
           end

           describe "email delivery" do
             context "when enabled" do
               before { recipient.update!(email_notifications_enabled: true) }
               
               it "queues email" do
                 expect { notification.deliver(recipient) }
                   .to have_enqueued_mail(NotificationMailer, :notification_email)
               end
             end
           end
         end
         ```

examples:
  - input: |
      # Bad - Unclear structure, multiple expectations
      RSpec.describe User do
        it "is valid and sends email" do
          user = create(:user)
          expect(user).to be_valid
          expect { user.save }.to change { ActionMailer::Base.deliveries.count }
        end
      end

      # Good - Clear structure, specific validations
      RSpec.describe User, type: :model do
        describe "validations" do
          it { is_expected.to validate_presence_of(:email) }
          it { is_expected.to allow_value("user@example.com").for(:email) }
          it { is_expected.not_to allow_value("invalid_email").for(:email) }
        end

        describe "#save" do
          it "sends welcome email" do
            user = build(:user)
            expect { user.save }
              .to have_enqueued_mail(UserMailer, :welcome_email)
          end
        end
      end
    output: "Properly structured tests with clear responsibilities"

metadata:
  priority: high
  version: 1.0
  related_rules:
    - noticed_notification_standards
    - solid_principles
  responsibility: "Test structure and organization standards"
  standard_patterns:
    structure:
      - describe_blocks
      - context_blocks
      - single_expectation
    tools:
      - rspec
      - factory_bot
      - faker
      - webmock
      - vcr
    practices:
      - shared_examples
      - shared_contexts
      - proper_mocking
</rule>