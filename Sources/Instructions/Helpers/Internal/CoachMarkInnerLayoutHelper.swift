// CoachMarkInnerLayoutHelper.swift
//
// Copyright (c) 2016 Frédéric Maquin <fred@ephread.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class CoachMarkInnerLayoutHelper {
    func horizontalArrowConstraints(for coachMarkViews: CoachMarkViews,
                                    withPosition position: ArrowPosition,
                                    horizontalOffset: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: coachMarkViews.arrowView, attribute: .centerX, relatedBy: .equal,
            toItem: coachMarkViews.bodyView, attribute: position.layoutAttribute,
            multiplier: 1, constant: adaptedOffset(for: position, offset: horizontalOffset)
        )
    }

    func verticalConstraints(for coachMarkViews: CoachMarkViews, in parentView: UIView,
                             withProperties properties: CoachMarkViewProperties)
    -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()

        let verticalArrowOffset = properties.verticalArrowOffset

        if properties.orientation == .top {
            constraints = topOrientationConstraints(for: coachMarkViews, in: parentView,
                                                    verticalArrowOffset: verticalArrowOffset)
        } else if properties.orientation == .bottom {
            constraints = bottomOrientationConstraints(for: coachMarkViews, in: parentView,
                                                       verticalArrowOffset: verticalArrowOffset)
        }

        return constraints
    }

    private func topOrientationConstraints(for coachMarkViews: CoachMarkViews,
                                           in parentView: UIView, verticalArrowOffset: CGFloat)
    -> [NSLayoutConstraint] {
        let offset = adaptedOffset(for: .top, offset: verticalArrowOffset)

        let constraint1 = NSLayoutConstraint(item: coachMarkViews.arrowView, attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: coachMarkViews.bodyView, attribute: .top,
                                             multiplier: 1.0, constant: offset)

        let constraint2 = NSLayoutConstraint(item: parentView, attribute: .top,
                                             relatedBy: .equal,
                                             toItem: coachMarkViews.arrowView, attribute: .top,
                                             multiplier: 1.0, constant: 0)

        let constraint3 = NSLayoutConstraint(item: coachMarkViews.bodyView, attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: parentView, attribute: .bottom,
                                             multiplier: 1.0, constant: 0)

        return [constraint1, constraint2, constraint3]
    }

    private func bottomOrientationConstraints(for coachMarkViews: CoachMarkViews,
                                              in parentView: UIView, verticalArrowOffset: CGFloat)
    -> [NSLayoutConstraint] {
        let offset = adaptedOffset(for: .bottom, offset: verticalArrowOffset)

        let constraint1 = NSLayoutConstraint(item: coachMarkViews.arrowView, attribute: .top,
                                             relatedBy: .equal,
                                             toItem: coachMarkViews.bodyView, attribute: .bottom,
                                             multiplier: 1.0, constant: offset)

        let constraint2 = NSLayoutConstraint(item: parentView, attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: coachMarkViews.arrowView, attribute: .bottom,
                                             multiplier: 1.0, constant: 0)

        let constraint3 = NSLayoutConstraint(item: coachMarkViews.bodyView, attribute: .top,
                                             relatedBy: .equal,
                                             toItem: parentView, attribute: .top,
                                             multiplier: 1.0, constant: 0)

        return [constraint1, constraint2, constraint3]
    }

    private func adaptedOffset(for arrowPosition: ArrowPosition, offset: CGFloat) -> CGFloat {
        switch arrowPosition {
        case .leading: return offset
        case .center: return -offset
        case .trailing: return -offset
        }
    }

    private func adaptedOffset(for arrowOrientation: CoachMarkArrowOrientation,
                               offset: CGFloat) -> CGFloat {
        switch arrowOrientation {
        case .top: return offset
        case .bottom: return -offset
        }
    }
}

typealias CoachMarkViews = (bodyView: UIView, arrowView: UIView)
typealias CoachMarkViewProperties = (orientation: CoachMarkArrowOrientation,
                                     verticalArrowOffset: CGFloat)
