//
//  VolumeWheelViewController.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 15/03/2022.
//

import UIKit
import SnapKit

class VolumeWheelViewController: UIViewController {
    
    private let circleView = CircleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCircleView()
    }
}

private extension VolumeWheelViewController {
    func setupCircleView() {
        view.addSubview(circleView)
        
        circleView.addTarget(self, action: #selector(didTapCircle), for: .valueChanged)
        
        circleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
    }
    
    @objc func didTapCircle() {
    }
}

