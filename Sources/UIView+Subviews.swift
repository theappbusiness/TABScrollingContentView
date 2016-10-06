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

public extension UIView {
  
  // MARK: - Vertical
  
  public func add(verticalSubviews subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), verticalSpacing: Double = 0) {
    var previousView: UIView? = nil
    for subview in subviews {
      subview.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(subview)
      addConstraints(fromSubiew: subview, previousView: previousView, margins: margins, verticalSpacing: verticalSpacing)
      previousView = subview
    }
    previousView?.pin(edge: .bottom, toEdge: .bottom, ofView: self, margin: margins.bottom)
  }
  
  private func addConstraints(fromSubiew subview: UIView, previousView: UIView?, margins: EdgeMargins, verticalSpacing: Double) {
    subview.pin(edges: .leftAndRight, toView: self, margins: margins)
    if let previousView = previousView {
      previousView.pin(edge: .bottom, toEdge: .top, ofView: subview, margin: CGFloat(verticalSpacing))
    } else {
      subview.pin(edge: .top, toEdge:.top, ofView: self, margin: margins.top)
    }
  }
  
  // MARK: - Horizontal
  
  public func add(horizontalSubviews subviews: [UIView], withMargins margins: EdgeMargins = EdgeMargins(), horizontalSpacing: Double = 0) {
    var previousView: UIView? = nil
    for subview in subviews {
      subview.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(subview)
      addConstraints(fromSubview: subview, toView: previousView, margins: margins, horizontalSpacing: horizontalSpacing)
      previousView = subview
    }
    previousView?.pin(edge: .right, toEdge: .right, ofView: self, margin: margins.right)
  }
  
  private func addConstraints(fromSubview subview: UIView, toView previousView: UIView?, margins: EdgeMargins, horizontalSpacing: Double) {
    subview.pin(edges: .topAndBottom, toView: self, margins: margins)
    if let previousView = previousView {
      previousView.pin(edge: .right, toEdge: .left, ofView: subview, margin: CGFloat(horizontalSpacing))
    } else {
      subview.pin(edge: .left, toEdge:.left, ofView: self, margin: margins.left)
    }
  }
  
}
