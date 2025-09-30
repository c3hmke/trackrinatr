---
# Configuration for the Jekyll template "Just the Docs"
parent: Decisions
nav_order: 2
title: Using Provider for repositories instead of passing them in constructors.

---

# Using Provider for repositories instead of passing them in constructors

## Decision Outcome

Chosen option: **Use `Provider` for repositories**, because it decouples widgets from repository 
wiring, reduces boilerplate, and simplifies access across the app.

### Consequences

* Repositories are accessible anywhere in the widget tree without constructor clutter.
* Testability improves (can inject mock repositories via a test `Provider` tree).
* UI code remains focused on UI responsibilities instead of plumbing dependencies.
* Introduces an implicit dependency (harder to see what a widget depends on at a glance).
* Misuse can lead to over-reliance on global-like state if not managed carefully.

## Context and Problem Statement

The application relies on repositories (`WorkoutRepository`, `ExerciseRepository`) for persistence.  
A choice exists for how to make these repositories available to widgets throughout the widget tree:
1. Pass repositories explicitly via widget constructors (prop drilling).
2. Use a dependency injection mechanism (`Provider`) to expose them in the widget tree.

**Should repositories be provided globally with `Provider` or passed down through constructors?**

## Decision Drivers

* Need to reduce boilerplate and constructor noise as the widget tree grows.
* Improve maintainability and testability.
* Ensure repositories are easily accessible in deeply nested widgets without unnecessary coupling.
* Preserve flexibility for mocking or replacing repositories in tests.

## Considered Options

* Pass repositories via constructors through the widget tree.
* Use `Provider` for dependency injection.

## Pros and Cons of the Options

### Option 1: Pass repositories via constructors

* [+] dependencies are explicit in widget constructors.
* [+] there is no additional library or pattern required.
* [-] it creates constructor bloat and makes widget signatures harder to manage.
* [-] deeply nested widgets need repositories threaded through multiple layers, even if intermediate widgets don’t use them.
* [-] swapping repositories for tests requires changing many constructors.

### Option 2: Use Provider

* [+] dependencies are resolved at runtime with minimal boilerplate.
* [+] it’s easy to replace repositories in tests or different environments.
* [+] it keeps widget constructors clean and focused.
* [~] dependency injection is implicit, so tooling or conventions are needed to track dependencies.
* [-] misuse can lead to “hidden globals” and harder-to-trace dependency flow.  
