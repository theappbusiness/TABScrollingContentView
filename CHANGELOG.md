# Change Log

## 2.1.0

## New Features

- Adds a more concise way of removing all subviews by calling `removeAllSubviews()`.
- Adds a more concise way of replacing all subviews by calling `replaceAllSubviews(with:margins:viewSpacing)`.
- Adds unit test target to project.

## 2.0.0

### New Features
- Support for Swift 3

### API updates
- Renamed TABScrollingContentView functions:

	-  `addHorizontalSubviews(_:withMargins:horizontalSpacing:)` to `add(horizontalSubviews:withMargins:horizontalSpacing:)`

	-  `addVerticalSubviews(_:withMargins:verticalSpacing:)` to `add(verticalSubviews:withMargins:verticalSpacing:)`

	-  `addSubviews(_:withMargins:viewSpacing:)` to `add(subviews:withMargins:viewSpacing:)`
