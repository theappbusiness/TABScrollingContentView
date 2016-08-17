/*
  Copyright © 2015 The App Business. All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

  THIS SOFTWARE IS PROVIDED BY THE APP BUSINESS `AS IS' AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
  EVENT SHALL THE APP BUSINESS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import TABSwiftLayout

enum ScrollDirection {
  case Vertical
  case Horizontal
}

/**
 *  A horizontal scrolling content view that respects the auto-layout constraints of its subviews and resizes its content view
 *  and the content size of its scrollable area accordingly.
 */
public class HorizontalScrollingContentView: VerticalScrollingContentView {
  override class var scrollDirection: ScrollDirection { return .Horizontal }
  
  /**
   Adds all the given subviews to the contentView, horizontally one after the other spaced accordingly.
   
   - parameter subviews: The views to add as subviews of the contentView.
   - parameter margins:  The margins for the left of the first subview, the right of the last subview and the top and bottom
   of all subviews.
   - parameter viewSpacing: The vertical spacing between each subview.
   */
  override public func addSubviews(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), viewSpacing: Double = 0) {
    contentView.addHorizontalSubviews(subviews, withMargins: margins, horizontalSpacing: viewSpacing)
  }
}

/**
*  A vertical scrolling content view that respects the auto-layout constraints of its subviews and resizes its content view
*  and the content size of its scrollable area accordingly.
*/
public class VerticalScrollingContentView: UIView {

  // MARK: Public properties
  
  /// The scroll view created and owned by the VerticalScrollingContentView. NOTE: you should never add subviews to this directly, this should instead be handled by the addSubviews(subviews: [UIView], _ , _ ) on the instance of VerticalScrollingContentView.
  let scrollView: UIScrollView
  
  /// The delegate of the underlying scroll view.
  public weak var delegate: UIScrollViewDelegate? {
    get {
      return scrollView.delegate
    }
    set {
      scrollView.delegate = newValue
    }
  }
  
  /// The content view, to which you should add subviews. Don't add subviews directly to the scroll view.
  public let contentView: UIView
  
  // MARK: Private properties
  
  class var scrollDirection: ScrollDirection { return .Vertical }
  
  // MARK: - Initialization
  
  required public init?(coder aDecoder: NSCoder) {
    scrollView = VerticalScrollingContentView.newScrollView()
    contentView = VerticalScrollingContentView.newContentView()
    super.init(coder: aDecoder)
    setupInitialConstraints()
  }
  
  override public init(frame: CGRect) {
    scrollView = VerticalScrollingContentView.newScrollView()
    contentView = VerticalScrollingContentView.newContentView()
    super.init(frame: frame)
    setupInitialConstraints()
  }
  
  // MARK: Populating
  
  /**
   Adds all the given subviews to the contentView, vertically one after the other spaced accordingly.
  
   - parameter subviews: The views to add as subviews of the contentView.
   - parameter margins:  The margins for the top of the first subview, the bottom of the last subview and the left and right
   of all subviews.
   - parameter viewSpacing: The vertical spacing between each subview.
   */
  public func addSubviews(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), viewSpacing: Double = 0) {
    contentView.addVerticalSubviews(subviews, withMargins: margins, verticalSpacing: viewSpacing)
  }
  
  // MARK: Private

  private func setupInitialConstraints() {
    addSubview(scrollView)
    scrollView.pin(EdgeMask.All, toView: self, margins: EdgeMargins())
    scrollView.addSubview(contentView)
    
    let topAttribute: NSLayoutAttribute = self.dynamicType.scrollDirection == .Vertical ? .Top : .Leading
    let bottomAttribute: NSLayoutAttribute = self.dynamicType.scrollDirection == .Vertical ? .Bottom : .Trailing
    let leadingAttribute: NSLayoutAttribute = self.dynamicType.scrollDirection == .Vertical ? .Leading : .Top
    let trailingAttribute: NSLayoutAttribute = self.dynamicType.scrollDirection == .Vertical ? .Trailing : .Bottom
    
    // the content view is constrained to the top and bottom of the scroll view
    addConstraintToView(scrollView, targetAttribute: topAttribute, fromContentViewAttribute: topAttribute)
    addConstraintToView(scrollView, targetAttribute: bottomAttribute, fromContentViewAttribute: bottomAttribute)
    
    // the content view is constrained to the left and right of the view itself (not its scrollview!)
    addConstraintToView(self, targetAttribute: leadingAttribute, fromContentViewAttribute: leadingAttribute)
    addConstraintToView(self, targetAttribute: trailingAttribute, fromContentViewAttribute: trailingAttribute)
  }
  
  private func addConstraintToView(targetView: UIView, targetAttribute: NSLayoutAttribute, fromContentViewAttribute sourceAttribute: NSLayoutAttribute) {
    let constraint = NSLayoutConstraint(item: contentView, attribute: sourceAttribute, relatedBy: NSLayoutRelation.Equal, toItem: targetView, attribute: targetAttribute, multiplier: 1, constant: 0)
    targetView.addConstraint(constraint)
  }
  
  // MARK: Static helpers
  
  private static func newScrollView() -> UIScrollView {
    let scrollView = UIScrollView(frame: CGRectZero)
    scrollView.backgroundColor = UIColor.clearColor()
    scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.alwaysBounceVertical = true
    return scrollView
  }
  
  private static func newContentView() -> UIView {
    let contentView = UIView(frame: CGRectZero)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.backgroundColor = UIColor.clearColor()
    return contentView
  }

}
