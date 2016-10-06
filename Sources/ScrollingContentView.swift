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
  case vertical
  case horizontal
}

/**
 *  A horizontal scrolling content view that respects the auto-layout constraints of its subviews and resizes its content view
 *  and the content size of its scrollable area accordingly.
 */
public class HorizontalScrollingContentView: VerticalScrollingContentView {
  override class var scrollDirection: ScrollDirection { return .horizontal }
  
  /**
   Adds all the given subviews to the contentView, horizontally one after the other spaced accordingly.
   
   - parameter subviews: The views to add as subviews of the contentView.
   - parameter margins:  The margins for the left of the first subview, the right of the last subview and the top and bottom
   of all subviews.
   - parameter viewSpacing: The vertical spacing between each subview.
   */
  override public func add(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), viewSpacing: Double = 0) {
    contentView.add(horizontalSubviews: subviews, withMargins: margins, horizontalSpacing: viewSpacing)
  }
}

/**
*  A vertical scrolling content view that respects the auto-layout constraints of its subviews and resizes its content view
*  and the content size of its scrollable area accordingly.
*/
public class VerticalScrollingContentView: UIView {

  // MARK: Public properties
  
  /// The scroll view created and owned by the Vertical or HorizontalScrollingContentView. NOTE: you should never add subviews to this directly, this should instead be handled by the addSubviews(subviews: [UIView], _ , _ ) on the instance of VerticalScrollingContentView.
  public let scrollView: UIScrollView
  
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
  
  class var scrollDirection: ScrollDirection { return .vertical }
  
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
  public func add(subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), viewSpacing: Double = 0) {
    contentView.add(verticalSubviews: subviews, withMargins: margins, verticalSpacing: viewSpacing)
  }
  
  // MARK: Private

  private func setupInitialConstraints() {
    addSubview(scrollView)
    scrollView.pin(edges: .all, toView: self, margins: EdgeMargins())
    scrollView.addSubview(contentView)
    
    let topAttribute: NSLayoutAttribute = type(of: self).scrollDirection == .vertical ? .top : .leading
    let bottomAttribute: NSLayoutAttribute = type(of: self).scrollDirection == .vertical ? .bottom : .trailing
    let leadingAttribute: NSLayoutAttribute = type(of: self).scrollDirection == .vertical ? .leading : .top
    let trailingAttribute: NSLayoutAttribute = type(of: self).scrollDirection == .vertical ? .trailing : .bottom
    
    // the content view is constrained to the top and bottom of the scroll view
    addConstraint(to: scrollView, targetAttribute: topAttribute, fromContentViewAttribute: topAttribute)
    addConstraint(to: scrollView, targetAttribute: bottomAttribute, fromContentViewAttribute: bottomAttribute)
    
    // the content view is constrained to the left and right of the view itself (not its scrollview!)
    addConstraint(to: self, targetAttribute: leadingAttribute, fromContentViewAttribute: leadingAttribute)
    addConstraint(to: self, targetAttribute: trailingAttribute, fromContentViewAttribute: trailingAttribute)
  }
  
  private func addConstraint(to targetView: UIView, targetAttribute: NSLayoutAttribute, fromContentViewAttribute sourceAttribute: NSLayoutAttribute) {
    let constraint = NSLayoutConstraint(item: contentView, attribute: sourceAttribute, relatedBy: NSLayoutRelation.equal, toItem: targetView, attribute: targetAttribute, multiplier: 1, constant: 0)
    targetView.addConstraint(constraint)
  }
  
  // MARK: Static helpers
  
  private static func newScrollView() -> UIScrollView {
    let scrollView = UIScrollView(frame: .zero)
    scrollView.backgroundColor = .clear
    scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.alwaysBounceVertical = true
    return scrollView
  }
  
  private static func newContentView() -> UIView {
    let contentView = UIView(frame: .zero)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.backgroundColor = .clear
    return contentView
  }

}
