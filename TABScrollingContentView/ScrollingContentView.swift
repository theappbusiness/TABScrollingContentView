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

/**
*  A scrolling content view that respects the auto-layout constraints of its subviews and resizes its content view
*  and the content size of its scrollable area accordingly.
*/
public class ScrollingContentView: UIView {

  // MARK: Public properties
  
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
  
  private let scrollView: UIScrollView
  
  // MARK: - Initialization
  
  required init?(coder aDecoder: NSCoder) {
    scrollView = ScrollingContentView.newScrollView()
    contentView = ScrollingContentView.newContentView()
    super.init(coder: aDecoder)
    setupInitialConstraints()
  }
  
  override init(frame: CGRect) {
    scrollView = ScrollingContentView.newScrollView()
    contentView = ScrollingContentView.newContentView()
    super.init(frame: frame)
    setupInitialConstraints()
  }
  
  // MARK: Private

  private func setupInitialConstraints() {
    addSubview(scrollView)
    scrollView.pin(EdgeMask.All, toView: self, margins: EdgeMargins())
    scrollView.addSubview(contentView)
    
    // the content view is constrained to the top and bottom of the scroll view
    addConstraintToView(scrollView, targetAttribute: .Top, fromContentViewAttribute: .Top)
    addConstraintToView(scrollView, targetAttribute: .Bottom, fromContentViewAttribute: .Bottom)
    
    // the content view is constrained to the left and right of the view itself (not its scrollview!)
    addConstraintToView(self, targetAttribute: .Leading, fromContentViewAttribute: .Leading)
    addConstraintToView(self, targetAttribute: .Trailing, fromContentViewAttribute: .Trailing)
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
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }
  
  private static func newContentView() -> UIView {
    let contentView = UIView(frame: CGRectZero)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.backgroundColor = UIColor.clearColor()
    return contentView
  }

}
