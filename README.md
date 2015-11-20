![The App Business](https://github.com/theappbusiness/TABScrollingContentView/blob/master/assets/logo.png)

# Scrolling Content View

A simple way of adding content views to a scroll view, such that the scroll view's content size is determined automatically based on the auto layout constraints of its subviews.

This is similar to a `UIStackView` in that its subviews will layout nicely in a horizontal or vertical direction, but it supports scrolling content.

## Included in the Library

This library provides two scrolling content views:

* `VerticalScrollingContentView`
* `HorizontalScrollingContentView`

The useful thing about these views is that they infer their content size based on the subviews that are added (to the `contentView` property). As long as all of the subviews have a size defined by auto layout and the `contentView` can infer its size from the auto layout constraints between its subviews and itself.

Included is also a really simple way to add a set of vertical subviews or horizontal subviews.

## Instantiating

The best way to instantiate a scrolling content view is by setting the custom class in Interface Builder to either `VerticalScrollingContentView` or `HorizontalScrollingContentView`.

You can also use `init?(coder:)` and `init(frame:)`.

## Populating

Call the `addSubviews(subviews:)` or `addSubviews(subviews:, withMargins:, viewSpacing:)` method.

This will internally add the given subviews to the underlying `contentView` of the object on which the method is invoked. Subviews are added one after the other in a vertical or horizontal fashion, with the given spacing between each. By default, the margins at the top, left, bottom, and right are all 0. And the spacing between each view is also 0 by default.

You can alternatively add subviews yourself. If doing so, you should add the subviews to the `contentView` rather than to the scrolling content view itself.

There are also the following methods that can be used to add vertical or horizontal subviews to any type of view.

```
addVerticalSubviews(_:withMargins:verticalSpacing:)
addHorizontalSubviews(_:withMargins:horizontalSpacing:)
```
