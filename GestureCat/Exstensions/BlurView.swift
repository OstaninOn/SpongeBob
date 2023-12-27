//
//
//
//
//


import UIKit

protocol BlurView where Self:UIView {
    func makeBlur()
}

extension BlurView {
    func makeBlur() {
        
        let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 3
            addSubview(blurEffectView)
            
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut, animations: {
            blurEffectView.alpha = 0
              }, completion: nil)
        
    }
}
