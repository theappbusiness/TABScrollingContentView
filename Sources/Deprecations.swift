//
//  Deprecations.swift
//  TABScrollingContentView
//
//  Created by Daniela Bulgaru on 26/09/2016.
//  Copyright © 2016 TheAppBusiness. All rights reserved.
//

import Foundation
import TABSwiftLayout

extension View {
  
  @available(*, deprecated:2.0.0, renamed: "add(horizontalSubviews:withMargins:horizontalSpacing:)")
  public func addHorizontalSubviews(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), horizontalSpacing: Double = 0) {
    return add(horizontalSubviews: subviews, withMargins: margins, horizontalSpacing: horizontalSpacing)
  }
  
  @available(*, deprecated:2.0.0, renamed: "add(verticalSubviews:withMargins:verticalSpacing:)")
  public func addVerticalSubviews(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), verticalSpacing: Double = 0) {
    return add(verticalSubviews: subviews, withMargins: margins, verticalSpacing: verticalSpacing)
  }
  
}

extension VerticalScrollingContentView {
  
  @available(*, deprecated:2.0.0, renamed: "add(subviews:withMargins:viewSpacing:)")
  public func addSubviews(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), viewSpacing: Double = 0) {
    return add(subviews: subviews, withMargins: margins, viewSpacing: viewSpacing)
  }
  
}
