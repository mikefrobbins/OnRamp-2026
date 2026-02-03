# OnRamp Curriculum Learning Objectives

These objectives align directly with the OnRamp agenda and reflect the skills participants develop
through guided instruction and hands-on labs.

## Pre-Conference Setup

_Complete before arrival. Optional assistance is available outside scheduled sessions. All setup
must be finished before the Tuesday Source Control workshop._

- Install the following software:
  - PowerShell 7
  - Visual Studio Code (VS Code)
  - PowerShell extension for VS Code
  - Git
  - GitHub CLI
  - posh-git PowerShell module
- Create a GitHub account (if you don't have one)

## Monday - Getting Started, Discoverability, and Core Pipeline Concepts

### OnRamp Welcome & Orientation

- Understand the purpose and structure of the OnRamp program
- Review expectations and participation requirements
- Meet instructors and learn how to get help
- Locate the OnRamp GitHub repository and Slack channel

### Get Started

- Explain what PowerShell is and where it fits in IT automation
- Understand side-by-side PowerShell installations
- Locate and launch PowerShell using least privilege
  - UAC considerations
- Determine your PowerShell version using `$PSVersionTable`
- Configure execution policy and explain its purpose
- Identify the three core PowerShell discovery cmdlets
- Discover commands using `Get-Command`
  - Recognize `Verb-Noun` naming patterns
- Differentiate PowerShell cmdlets from native commands
- Create and run basic PowerShell scripts

### The Help System

- Use PowerShell help effectively
  - `Get-Help`, `-Examples`, `-Online`
  - Update help content
- Interpret command syntax
  - Parameters
  - Parameter sets
  - Positional parameters
  - Switch parameters
- Find commands using Help
- Locate About topics for deeper learning
- Apply a simplified approach to understanding syntax

### Discovering objects, properties, and methods

- Use `Get-Member` to discover object types, properties, and methods
- Explain how PowerShell passes objects through the pipeline
- Inspect object output before automating
- Find commands that accept specific object types

### One-liners and the pipeline

- Understand PowerShell one-liners
- Select and reshape output using `Select-Object`
- Filter results using `Where-Object`
  - Command sequencing for effective filtering
- Perform pipeline iteration with `ForEach-Object`
- Apply the _filter left, format right_ principle
- Understand formatting vs objects
- Structure pipelines using natural line breaks
- Build readable, maintainable one-liners
- Avoid aliases in reusable code

## Tuesday - Remoting, Scripting, and Source Control

### Remoting & Automation at Scale

- Explain WinRM vs SSH remoting
- Enable PowerShell remoting
- One-to-one remoting
- One-to-many remoting
- Invoke commands across multiple systems
- Understand deserialized objects and their limitations
- Create and reuse persistent PowerShell sessions
- Authenticate using alternate credentials
- Invoke methods inside remote sessions
- Remove remote sessions when finished

### Scripting Fundamentals

- Write and run PowerShell scripts
- Use variables
- Apply basic flow control
  - If statements
  - Comparison operators
  - Loops (`for`, `foreach`, `do`, `while`)
  - Use `break`, `continue`, and `return`
- Use the range operator
- Format scripts for readability and maintainability
- Understand basic scope behavior
- Use profiles for customization

## Source Control workshop

- Initialize Git repositories
- Track changes using commits
- Push and pull code using GitHub
- Clone repositories
- Contribute using forks and pull requests

## Wednesday - Functions, Modules, Testing, and Tooling

### Advanced Functions & Tooling

- Use approved verbs and consistent naming
- Create simple functions
- Convert scripts into reusable functions
- Define parameters
- Create advanced functions
- Implement `SupportsShouldProcess`
- Apply parameter validation
- Add verbose output
- Accept pipeline input
- Handle errors
- Implement comment-based help

### Script Modules

- Dot-source scripts when appropriate
- Package functions into script modules
- Create module manifests
- Understand module autoloading
- Install, update, and uninstall modules
- Differentiate between removing a module from a session and uninstalling it permanently

### Pester

- Understand the purpose of Pester
- Run basic Pester tests
- Test PowerShell code using automated validation

## Thursday - Debugging and Hands-on Practice

### Debugging

- Debug scripts using breakpoints
- Step through code
- Inspect variables
- View inline values
- Use structured troubleshooting techniques
- Diagnose common scripting errors
- Resolve issues through inspection and iteration

### Rapid Review

- Review key concepts from the week
- Clarify areas of confusion
- Address outstanding questions
- Cover anything that may have been missed
- Share bonus tips and practical insights
- Reinforce best practices

### PowerShell Hands-on Lab

- Apply the concepts learned throughout the week
- Complete guided automation labs
- Reinforce concepts through practical exercises
- Build confidence using PowerShell in real environments
