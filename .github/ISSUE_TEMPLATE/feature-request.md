---
name: ✨ Feature Request
description: Suggest a new feature or enhancement for NEXUS
title: "[FEATURE] "
labels: ["enhancement", "triage"]
assignees: []
body:
  - type: markdown
    attributes:
      value: |
        # ✨ Feature Request

        Thank you for suggesting a new feature for NEXUS! Your ideas help make NEXUS better for everyone.

        ## 📋 Before You Submit

        - [ ] I have searched existing issues to avoid duplicates
        - [ ] I have checked the [roadmap](https://github.com/yourusername/NEXUS/blob/main/docs/ROADMAP.md) (if it exists)
        - [ ] This feature would benefit other users, not just me

  - type: dropdown
    id: feature-type
    attributes:
      label: Feature Type
      description: What type of feature are you requesting?
      options:
        - New Workspace Profile
        - AI Integration Enhancement
        - Window Management Improvement
        - Automation Script Addition
        - Configuration Enhancement
        - UI/Dashboard Improvement
        - Third-party Integration
        - Performance Optimization
        - Documentation Improvement
        - Other
    validations:
      required: true

  - type: textarea
    id: problem
    attributes:
      label: Problem Statement
      description: What problem are you trying to solve?
      placeholder: "Describe the problem this feature would solve"
    validations:
      required: true

  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
      description: Describe your proposed solution
      placeholder: "How would you like this feature to work?"
    validations:
      required: true

  - type: textarea
    id: alternatives
    attributes:
      label: Alternative Solutions
      description: Have you considered any alternative solutions?
      placeholder: "Describe any alternative approaches you've considered"

  - type: dropdown
    id: priority
    attributes:
      label: Priority
      description: How important is this feature to you?
      options:
        - Nice to have
        - Would be helpful
        - Important for my workflow
        - Critical for my productivity
    validations:
      required: true

  - type: textarea
    id: additional-context
    attributes:
      label: Additional Context
      description: Add any other context or screenshots about the feature request
      placeholder: |
        - Screenshots/mockups
        - Related issues
        - Examples from other tools
        - Use cases

  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      description: Please check all that apply
      options:
        - label: I have read the [contributing guidelines](https://github.com/yourusername/NEXUS/blob/main/CONTRIBUTING.md)
        - label: This feature request is not a duplicate
        - label: I understand this is a suggestion and may not be implemented
