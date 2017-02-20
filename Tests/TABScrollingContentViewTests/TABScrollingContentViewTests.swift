//
//  TABScrollingContentViewTests.swift
//  TABScrollingContentViewTests
//
//  Created by Kane Cheshire on 20/02/2017.
//  Copyright © 2017 The App Business. All rights reserved.
//

import XCTest
@testable import TABScrollingContentView

class TABScrollingContentViewTests: XCTestCase {
  
  var scrollingContentView: VerticalScrollingContentView!
  
  override func setUp() {
    super.setUp()
    scrollingContentView = VerticalScrollingContentView()
  }
  
  override func tearDown() {
    scrollingContentView = nil
    super.tearDown()
  }
  
  func test_removingAllSubviews() {
    XCTAssertEqual(scrollingContentView.contentView.subviews, [])
    let views = createViews()
    scrollingContentView.add(subviews: views)
    XCTAssertEqual(views, scrollingContentView.contentView.subviews)
    scrollingContentView.removeAllSubviews()
    XCTAssertEqual(scrollingContentView.contentView.subviews, [])
  }
  
  func test_replacingAllSubviews() {
    XCTAssertEqual(scrollingContentView.contentView.subviews, [])
    let views = createViews()
    scrollingContentView.add(subviews: views)
    XCTAssertEqual(views, scrollingContentView.contentView.subviews)
    let newViews = createViews(2)
    scrollingContentView.replaceSubviews(with: newViews)
    XCTAssertEqual(scrollingContentView.contentView.subviews, newViews)
  }
  
  private func createViews(_ count: Int = 10) -> [UIView] {
    return (0 ..< count).map { _ in UIView() }
  }
  
}
