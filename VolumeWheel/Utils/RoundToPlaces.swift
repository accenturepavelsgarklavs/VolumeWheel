//
//  RoundToPlaces.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 15/03/2022.
//

import UIKit

extension CGFloat {
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
