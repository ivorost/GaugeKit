//
//  Utility.swift
//  GaugeKit
//
//  Created by Ivan Kh on 10.01.2023.
//  Copyright © 2023 Petr Korolev. All rights reserved.
//

#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
public typealias UIView = NSView
public typealias UIColor = NSColor
#endif


extension UIView {
    var theLayer: CALayer {
        #if canImport(AppKit)
        return layer!
        #else
        return layer
        #endif
    }

    #if canImport(AppKit)
    func setNeedsLayout() {
        needsLayout = true
    }
    #endif
}


#if canImport(AppKit)
extension NSBezierPath {
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)

            switch type {
            case .moveTo:
                path.move(to: points[0])

            case .lineTo:
                path.addLine(to: points[0])

            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])

            case .closePath:
                path.closeSubpath()

            @unknown default:
                break
            }
        }
        return path
    }
}
#endif
