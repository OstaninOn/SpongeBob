//
//  ShadowButtonStart.swift
//  GestureCat
//
//  Created by  aleksandr on 20.10.22.
//

import UIKit

protocol ShadowButtonStart where Self:UIView {
    func makeShadow(color: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat)
    func deleteShadow()
}

extension ShadowButtonStart {
    func makeShadow(
        color: UIColor = .black,
        shadowOpacity: Float = 1,
        shadowOffset: CGSize = .zero,
        shadowRadius: CGFloat = 10
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
    
    func deleteShadow() {
        layer.shadowOpacity = 0
    }
}
