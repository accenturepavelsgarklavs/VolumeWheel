//
//  ThumbLayer.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 18/03/2022.
//

import UIKit

class ThumbLayer: CAShapeLayer {
    public var highlighted = false
    
    override func layoutSublayers() {
        let circlePath = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY),
                                    radius: 15,
                                    startAngle: 0,
                                    endAngle: .pi * 2,
                                    clockwise: true)
        
        self.path = circlePath.cgPath
    }
}
