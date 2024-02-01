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
        
        let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 1
            addSubview(blurEffectView)
            
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
            blurEffectView.alpha = 0
              }, completion: nil)
        
    }
}
