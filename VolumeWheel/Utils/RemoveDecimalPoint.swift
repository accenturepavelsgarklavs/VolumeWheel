//
//  RemoveDecimalPoint.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 15/03/2022.
//

import UIKit

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
