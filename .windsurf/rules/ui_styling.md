---
trigger: model_decision
description: UI styling standards using Tailwind CSS with dark mode support and mobile-first design
globs: 
---

# UI Styling Standards

<rule>
name: ui_styling
description: Standards for implementing consistent UI styling using Tailwind CSS with dark mode support and mobile-first design principles

filters:
  - type: file_extension
    pattern: "\\.html\\.erb$|\\.css$|\\.js$|\\.jsx$"
  - type: content
    pattern: "class=|className=|@apply"

actions:
  - type: suggest
    message: |
      When styling UI components:

      1. Color System:
         ```javascript
         // Define in tailwind.config.js
         colors: {
           primary: colors.green,
           secondary: colors.gray,
           danger: colors.red,
           success: colors.green,
           warning: colors.yellow,
           info: colors.blue
         }
         ```

      2. Component Patterns:
         ```css
         @layer components {
           .card {
             @apply bg-white dark:bg-gray-800 rounded-lg shadow-sm p-4;
           }
           
           .btn-primary {
             @apply bg-primary-600 hover:bg-primary-700 text-white font-medium rounded-md px-4 py-2;
           }
           
           .btn-secondary {
             @apply bg-gray-100 hover:bg-gray-200 dark:bg-gray-700 dark:hover:bg-gray-600 text-gray-700 dark:text-gray-200 font-medium rounded-md px-4 py-2;
           }
         }
         ```

      3. Dark Mode Implementation:
         ```erb
         <div class="bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100">
           <h1 class="text-2xl font-bold text-gray-900 dark:text-white">
             <%= title %>
           </h1>
         </div>
         ```

      4. Mobile-First Design:
         ```erb
         <div class="flex flex-col sm:flex-row">
           <div class="w-full sm:w-1/2 p-4 sm:p-6">
             <%= content %>
           </div>
         </div>
         ```

      5. Layout Components:
         ```erb
         <%# Container %>
         <div class="container mx-auto px-4 sm:px-6 lg:px-8">
           
         <%# Card %>
         <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-4 sm:p-6">
           
         <%# Section %>
         <section class="py-6 sm:py-8 lg:py-12">
         ```

      6. Typography Scale:
         ```css
         .h1 { @apply text-4xl font-bold }
         .h2 { @apply text-3xl font-bold }
         .h3 { @apply text-2xl font-bold }
         .h4 { @apply text-xl font-semibold }
         .body-lg { @apply text-lg }
         .body { @apply text-base }
         .body-sm { @apply text-sm }
         ```

      7. Spacing System:
         ```erb
         <%# Consistent spacing classes %>
         <div class="space-y-4 sm:space-y-6 lg:space-y-8">
         <div class="gap-4 sm:gap-6 lg:gap-8">
         <div class="p-4 sm:p-6 lg:p-8">
         ```

      8. Interactive States:
         ```css
         .btn {
           @apply transition-colors duration-150;
           @apply hover:bg-opacity-90;
           @apply active:bg-opacity-100;
           @apply disabled:opacity-50 disabled:cursor-not-allowed;
         }
         ```

examples:
  - input: |
      # Bad - Inconsistent styling
      <div style="margin: 20px; padding: 15px;">
        <button style="background: #007bff;">Click me</button>
      </div>
      
      # Good - Using design system
      <div class="m-4 sm:m-6 p-4 sm:p-6">
        <button class="btn btn-primary">Click me</button>
      </div>
    output: "Using consistent spacing and component classes"

  - input: |
      # Bad - No dark mode support
      <div class="bg-white text-black">
        <h1 class="text-2xl">Title</h1>
      </div>
      
      # Good - Dark mode support
      <div class="bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100">
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Title</h1>
      </div>
    output: "Proper dark mode implementation"

  - input: |
      # Bad - Not mobile-first
      <div class="sm:flex-col flex-row">
        <div class="sm:w-full w-1/2">
      
      # Good - Mobile-first
      <div class="flex-col sm:flex-row">
        <div class="w-full sm:w-1/2">
    output: "Mobile-first responsive design"

metadata:
  priority: high
  version: 1.0
  related_rules:
    - ux_standards
    - accessibility_standards
  responsibility: "UI styling consistency and maintainability"
  standard_patterns:
    layout:
      - container
      - card
      - section
    spacing:
      - m-{size}
      - p-{size}
      - gap-{size}
      - space-{y|x}-{size}
    breakpoints:
      - sm: "640px"
      - md: "768px"
      - lg: "1024px"
      - xl: "1280px"
      - 2xl: "1536px"
</rule>