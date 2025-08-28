---
name: 📚 Documentation
description: Report documentation issues or suggest improvements
title: "[DOCS] "
labels: ["documentation", "triage"]
assignees: []
body:
  - type: markdown
    attributes:
      value: |
        # 📚 Documentation Issue

        Help us improve NEXUS documentation!

        ## 📋 Before You Submit

        - [ ] I have searched existing documentation issues
        - [ ] I have checked the latest documentation
        - [ ] This is not a bug report (use bug template instead)

  - type: dropdown
    id: doc-type
    attributes:
      label: Documentation Type
      description: What type of documentation needs improvement?
      options:
        - Installation Guide
        - User Guide
        - API Documentation
        - Configuration Guide
        - Troubleshooting Guide
        - README.md
        - Other
    validations:
      required: true

  - type: dropdown
    id: issue-type
    attributes:
      label: Issue Type
      description: What type of documentation issue is this?
      options:
        - Missing Information
        - Outdated Information
        - Unclear Explanation
        - Incorrect Information
        - Formatting/Structure Issue
        - New Feature Documentation Needed
        - Translation Issue
        - Other
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Please describe the documentation issue
      placeholder: "What's wrong with the current documentation?"
    validations:
      required: true

  - type: textarea
    id: location
    attributes:
      label: Location
      description: Where is this documentation located?
      placeholder: |
        - File path: docs/user-guides/INSTALLATION.md
        - Section: "Installation Steps"
        - URL: https://github.com/yourusername/NEXUS/blob/main/docs/...

  - type: textarea
    id: suggestion
    attributes:
      label: Suggested Improvement
      description: How would you improve this documentation?
      placeholder: "Describe what changes you would make"

  - type: dropdown
    id: priority
    attributes:
      label: Priority
      description: How important is fixing this documentation?
      options:
        - Low - Minor improvement
        - Medium - Affects usability
        - High - Blocks users from using NEXUS
        - Critical - Incorrect information
    validations:
      required: true

  - type: textarea
    id: additional-context
    attributes:
      label: Additional Context
      description: Add any additional context or examples
      placeholder: |
        - Screenshots
        - Examples of good documentation
        - Related issues

  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      description: Please check all that apply
      options:
        - label: I am willing to help improve this documentation
        - label: I can provide examples or corrections
