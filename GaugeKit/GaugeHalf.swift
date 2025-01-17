//
//  Gauge.swift
//  SWGauge
//
//  Created by Petr Korolev on 02/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
import QuartzCore

protocol GaugeHalf {
    func getHalfGauge(_ rotatengle: Double) -> CAShapeLayer
}

extension Gauge: GaugeHalf {
    func getHalfGauge(_ rotateAngle: Double) -> CAShapeLayer {

        let gaugeLayer = CAShapeLayer()

        //        let rotatedBounds = CGRectMake(10, 10, bounds.height, bounds.width)
        let newBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.height, height: bounds.width * 2 - lineWidth)
        //        var newBounds = bounds
        if bgLayer == nil {
            bgLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 0.5, strokeColor: _bgStartColor,
                    fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: newBounds, rotateAngle: pi_2, isCircle: isCircle)
            bgLayer.frame = theLayer.bounds
            bgLayer.position = CGPoint(x: bgLayer.position.x + bounds.width - lineWidth, y: bgLayer.position.y)
        }

        if bgGradientLayer == nil {
            bgGradientLayer = CAGradientLayer()
            if isCircle && (theLayer.bounds.width < theLayer.bounds.height) {
                let adjust: CGFloat = (theLayer.bounds.height - theLayer.bounds.width) / 2 / theLayer.bounds.height
                bgGradientLayer.startPoint = CGPoint(x: 0.5, y: 1 - adjust)
                bgGradientLayer.endPoint = CGPoint(x: 0.5, y: adjust)
            } else {
                bgGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
                bgGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            }
            bgGradientLayer.colors = [_bgStartColor.cgColor, _bgEndColor.cgColor]
            bgGradientLayer.frame = theLayer.bounds
            bgGradientLayer.mask = bgLayer
            gaugeLayer.addSublayer(bgGradientLayer)
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 0.5, strokeColor: startColor,
                    fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: newBounds, rotateAngle: pi_2, isCircle: isCircle)
            ringLayer.frame = theLayer.bounds
            ringLayer.position = CGPoint(x: ringLayer.position.x + bounds.width - lineWidth, y: ringLayer.position.y)
        }

        if ringGradientLayer == nil {
            ringGradientLayer = CAGradientLayer()
            if isCircle && (theLayer.bounds.width < theLayer.bounds.height) {
                let adjust: CGFloat = (theLayer.bounds.height - theLayer.bounds.width) / 2 / theLayer.bounds.height
                ringGradientLayer.startPoint = CGPoint(x: 0.5, y: 1 - adjust)
                ringGradientLayer.endPoint = CGPoint(x: 0.5, y: adjust)
            } else {
                ringGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
                ringGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            }
            ringGradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            ringGradientLayer.frame = theLayer.bounds
            ringGradientLayer.mask = ringLayer
            gaugeLayer.addSublayer(ringGradientLayer)
        }

        if roundCap {
            ringLayer.lineCap = .round
            bgLayer.lineCap = .round
        }

        gaugeLayer.frame = theLayer.bounds
        gaugeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gaugeLayer.transform = CATransform3DRotate(gaugeLayer.transform, CGFloat(rotateAngle), 0, 0, 1)
        if reverse {
            reverseY(gaugeLayer)
        }

        if type == .right {
            reverseX(gaugeLayer)
        }

        return gaugeLayer
    }
}
