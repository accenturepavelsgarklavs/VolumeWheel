//
//  CircleView.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 15/03/2022.
//

import UIKit

class CircleView: UIControl {
    
    private let circle = CAShapeLayer()
    private let circleLayer = CAShapeLayer()
    private let smallAdjustmentCircle = ThumbLayer()
    private let percentageLabel = UILabel()
    
    private var angle: CGFloat = 0 {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    private var radius: CGFloat { bounds.width / 2 }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItems()
        setupPercentageLabel()
        setupCircleLayer()
        setupAdjustmentCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupItems()
        setupCircleLayer()
        setupAdjustmentCircle()
        setupPercentageLabel()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let inset: CGFloat = 4
        
        if smallAdjustmentCircle.frame.insetBy(dx: inset, dy: inset).contains(location) {
            smallAdjustmentCircle.highlighted = true
        }
        
        return smallAdjustmentCircle.highlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let x = location.x - radius
        let y = location.y - radius
        let divisor = radius*radius + x*x + y*y - (bounds.midX-location.x)*(bounds.midX-location.x) - (bounds.minY-location.y)*(bounds.minY-location.y)
        let deminator = 2 * radius * sqrt(x*x + y*y)
        
        let cosAngle = max(min(divisor/deminator, 1), -1)
        var angle = (location.x <= bounds.midX ? 2 * .pi : 0) + acos(cosAngle) * (location.x <= bounds.midX ? -1 : 1)
        
        if angle < 0 {
            let factor = -1 * angle / 2 / .pi + 1
            angle = angle + factor * .pi
        }
        
        if angle > 2 * .pi {
            let factor = angle / 2 / .pi
            angle = angle - factor * 2 * .pi
        }
        
        self.angle = angle
        
        if smallAdjustmentCircle.highlighted {
            CATransaction.setDisableActions(true)
            updateSmallAdjustmentCircle()
            updateCircleLayer()
            CATransaction.setDisableActions(false)
        }
        
        return true
        
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        smallAdjustmentCircle.highlighted = false
    }
    
    
}

private extension CircleView {
    func updateCircleLayer() {
        let path = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: -(.pi/2), endAngle: angle - .pi/2, clockwise: true)
        circleLayer.path = path.cgPath
    }
    
    func setupCircleLayer() {
        layer.addSublayer(circleLayer)
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = 3
    }
    
    func updateSmallAdjustmentCircle() {
        let radius = radius
        let x = self.radius + radius * cos(angle - .pi / 2)
        let y = self.radius + radius * cos(angle + .pi)
        
        smallAdjustmentCircle.frame = CGRect(x: x-15, y: y-15, width: 30, height: 30)
        smallAdjustmentCircle.setNeedsDisplay()
    }
    
    func updateItems(with point: CGPoint = .zero) {
        let degree = point.angle(to: CGPoint(x: bounds.midX, y: bounds.midY))
        
        let linePath = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY),
                                    radius: radius,
                                    startAngle: .pi, endAngle: degree.toRadians - .pi,
                                    clockwise: true)
        
        circle.path = linePath.cgPath
        
        percentageLabel.text = "\(CalculatePrecentageOfCircle.calculate(value: degree))%"
    }
    
    func setupAdjustmentCircle() {
        layer.addSublayer(smallAdjustmentCircle)
        
        updateSmallAdjustmentCircle()
        
        smallAdjustmentCircle.fillColor = UIColor.black.cgColor
    }
    
    func setupItems() {
        layer.addSublayer(circle)
        
        circle.strokeColor = UIColor.blue.cgColor
        circle.fillColor = UIColor.clear.cgColor
        circle.lineWidth = 15
    }
    
    func setupPercentageLabel() {
        addSubview(percentageLabel)
        
        percentageLabel.font = .systemFont(ofSize: 48, weight: .bold)
        percentageLabel.textAlignment = .center
    
        percentageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    
    }
}

