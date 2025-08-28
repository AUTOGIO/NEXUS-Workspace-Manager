---
name: ❓ Question
description: Ask a question about NEXUS
title: "[QUESTION] "
labels: ["question", "triage"]
assignees: []
body:
  - type: markdown
    attributes:
      value: |
        # ❓ Question

        Have a question about NEXUS? We're here to help!

        ## 📋 Before You Ask

        - [ ] I have searched the [documentation](https://github.com/yourusername/NEXUS/blob/main/README.md)
        - [ ] I have searched existing issues for similar questions
        - [ ] I have checked the [FAQ](https://github.com/yourusername/NEXUS/blob/main/docs/FAQ.md) (if it exists)

  - type: dropdown
    id: question-category
    attributes:
      label: Question Category
      description: What is your question about?
      options:
        - Installation & Setup
        - Configuration
        - Usage & Features
        - Troubleshooting
        - Development
        - Integration (BetterTouchTool, Keyboard Maestro, etc.)
        - Performance
        - Other
    validations:
      required: true

  - type: textarea
    id: question
    attributes:
      label: Your Question
      description: Please ask your question clearly and concisely
      placeholder: "What would you like to know about NEXUS?"
    validations:
      required: true

  - type: textarea
    id: context
    attributes:
      label: Context
      description: Provide any relevant context or background information
      placeholder: |
        - What are you trying to accomplish?
        - What have you tried so far?
        - What is your setup/environment?

  - type: input
    id: version
    attributes:
      label: NEXUS Version
      description: What version of NEXUS are you using?
      placeholder: "e.g., v2.0.0, latest, dev"

  - type: textarea
    id: additional-info
    attributes:
      label: Additional Information
      description: Any additional information that might be helpful
      placeholder: |
        - Error messages
        - Screenshots
        - Configuration files
        - Logs

  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      description: Please check all that apply
      options:
        - label: I have searched the documentation
        - label: This is not a bug report (use bug template instead)
        - label: This is not a feature request (use feature template instead)
