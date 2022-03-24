//
//  CalculatePrecentageOfCircle.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 17/03/2022.
//

import UIKit

struct CalculatePrecentageOfCircle {
    static func calculate(value: CGFloat) -> String {
        let result = (value / 360) * 100
        return Float(result.rounded(toPlaces: 0)).clean
    }
}
