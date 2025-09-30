---
# Configuration for the Jekyll template "Just the Docs"
parent: Decisions
nav_order: 2
title: Using an ExerciseLog model over adding information to the Exercise model.

---

# Using an ExerciseLog model over adding information to the Exercise model

## Decision Outcome

Chosen option: **Introduce `ExerciseLog` model**, because it clearly separates responsibilities:
- `Exercise` = current state (template for workouts).
- `ExerciseLog` = append-only history (immutable records).  
  This improves clarity, query simplicity, and scalability for future features.

### Consequences

* Logs remain immutable, simplifying reasoning and analytics.
* Current exercise state is always retrievable without filtering or grouping.
* Scales better with large histories.
* Introduces extra boilerplate (a second repository and box to maintain).

## Context and Problem Statement

The application needs to track workout history while also maintaining a "current state" of each exercise for progression (e.g., incrementing weight when all sets are completed).  
The initial approach was to extend the `Exercise` model with a `completedDate` and use a composite key of `(name, completedDate)` in Hive.  
This mixes the concepts of a reusable exercise template with its immutable history logs.

The question: **Should exercise history be tracked directly in `Exercise` or should a dedicated `ExerciseLog` model be introduced?**

## Decision Drivers

* Need to preserve **immutable workout history** for analytics and user review.
* Need to keep **current exercise progression** logic simple (only one canonical state per exercise).
* Anticipated growth of features such as charts, exports, or program variations.
* Desire to avoid scanning large log histories just to retrieve the current state.

## Considered Options

* Add `completedDate` to `Exercise` and store both templates and history in the same box (composite key).
* Introduce a separate `ExerciseLog` model with its own repository and box.

## Pros and Cons of the Options

### Option 1: Composite-key `Exercise` (single box)

* [+] simpler to implement (no new repository).
* [~] history is stored, but requires filtering by name and sorting by date.
* [-] mutable entities mix current state with history.
* [-] queries for “current exercise” are less efficient with large logs.

### Option 2: Separate `ExerciseLog` model (two boxes)

* [+] logs are append-only and immutable.
* [+] templates remain clean and only track current progression state.
* [+] queries are simpler (template vs history separation).
* [+] easier to extend with analytics and exports.
* [-] requires extra boilerplate and maintenance of two repositories.  
