---
name: 🐛 Bug Report
description: Report a bug or issue with NEXUS
title: "[BUG] "
labels: ["bug", "triage"]
assignees: []
body:
  - type: markdown
    attributes:
      value: |
        # 🐛 Bug Report

        Thank you for reporting a bug in NEXUS! Please fill out the information below to help us understand and fix the issue.

        ## 📋 Before You Submit

        - [ ] I have searched existing issues to avoid duplicates
        - [ ] I have tested this on the latest version
        - [ ] I have included all relevant information

  - type: dropdown
    id: bug-type
    attributes:
      label: Bug Type
      description: What type of bug are you reporting?
      options:
        - Window Management Issue
        - Profile Switching Problem
        - AI Integration Failure
        - Script Execution Error
        - Configuration Problem
        - Installation Issue
        - Performance Problem
        - Other
    validations:
      required: true

  - type: input
    id: version
    attributes:
      label: NEXUS Version
      description: What version of NEXUS are you using?
      placeholder: "e.g., v2.0.0, latest, dev"
    validations:
      required: true

  - type: dropdown
    id: os
    attributes:
      label: Operating System
      description: What operating system are you using?
      options:
        - macOS 12 (Monterey)
        - macOS 13 (Ventura)
        - macOS 14 (Sonoma)
        - macOS 15 (Sequoia)
        - Other (please specify)
    validations:
      required: true

  - type: input
    id: mac-hardware
    attributes:
      label: Mac Hardware
      description: What Mac hardware are you using?
      placeholder: "e.g., MacBook Pro M3, iMac Intel, Mac Studio M2 Ultra"
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Please provide a clear and concise description of the bug
      placeholder: "Describe what you expected to happen and what actually happened"
    validations:
      required: true

  - type: textarea
    id: reproduction
    attributes:
      label: Steps to Reproduce
      description: Please provide step-by-step instructions to reproduce the issue
      placeholder: |
        1. Go to '...'
        2. Click on '...'
        3. Run command '...'
        4. See error
    validations:
      required: true

  - type: textarea
    id: expected-behavior
    attributes:
      label: Expected Behavior
      description: What should happen when the bug occurs?
      placeholder: "Describe what you expected to happen"
    validations:
      required: true

  - type: textarea
    id: actual-behavior
    attributes:
      label: Actual Behavior
      description: What actually happens when the bug occurs?
      placeholder: "Describe what actually happened"
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: Logs and Error Messages
      description: Please include any relevant log files or error messages
      placeholder: |
        ```
        Paste error messages or log output here
        ```
      render: shell

  - type: textarea
    id: additional-context
    attributes:
      label: Additional Context
      description: Add any other context about the problem here
      placeholder: |
        - Screenshots
        - Configuration files
        - Environment details
        - Related issues

  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      description: Please check all that apply
      options:
        - label: I have read the [documentation](https://github.com/yourusername/NEXUS/blob/main/README.md)
        - label: I have checked that this is not a duplicate issue
        - label: I have provided all necessary information
        - label: I am willing to help debug this issue
