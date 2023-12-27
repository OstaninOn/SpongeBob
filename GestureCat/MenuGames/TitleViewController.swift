//
//  TitleViewController.swift
//  GestureCat
//
//  Created by  aleksandr on 3.10.22.
//

import UIKit
import AVFoundation

class TitleViewController: UIViewController {
    
    @IBOutlet weak var TopRecord: UIButton!
    
    @IBOutlet weak var Settings: UIButton!
    
    @IBOutlet weak var StartTitle: UIView!
        
    @IBOutlet weak var BackgroundImage: BackgroundImageView!
    
    @IBOutlet weak var catDinaic: UIImageView!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackgroundImage.makeBlur()
        
        let gradientTopRecord = CAGradientLayer()
        gradientTopRecord.colors = [UIColor.magenta.cgColor,UIColor.systemYellow.cgColor,]
        gradientTopRecord.frame = TopRecord.bounds
        TopRecord.layer.insertSublayer(gradientTopRecord, at: 0)
        TopRecord.layer.cornerRadius = 17
        TopRecord.layer.masksToBounds = true
        TopRecord.layer.borderWidth = 1
        
        let gradientStartTitle = CAGradientLayer()
        gradientStartTitle.colors = [UIColor.systemTeal.cgColor,UIColor.systemGreen.cgColor,]
        gradientStartTitle.frame = StartTitle.bounds
        StartTitle.layer.insertSublayer(gradientStartTitle, at: 0)
        StartTitle.layer.cornerRadius = 17
        StartTitle.layer.masksToBounds = true
        StartTitle.layer.borderWidth = 1
        
        
        let gradientSettings = CAGradientLayer()
        gradientSettings.colors = [UIColor.systemFill.cgColor,UIColor.systemRed.cgColor,]
        gradientSettings.frame = Settings.bounds
        Settings.layer.insertSublayer(gradientSettings, at: 0)
        Settings.layer.cornerRadius = 17
        Settings.layer.masksToBounds = true
        Settings.layer.borderWidth = 1
        
        let gradientView = CAGradientLayer()
        gradientView.colors = [UIColor.black.cgColor,UIColor.systemPink.cgColor]
        gradientView.frame = view.bounds
        view.layer.insertSublayer(gradientView, at: 0)
        view.layer.masksToBounds = false
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [catDinaic])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [catDinaic])
        collision.addBoundary(withIdentifier: "StartTitle" as NSCopying, for: UIBezierPath(rect: StartTitle.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [catDinaic])
        itemBehaviour.elasticity = 1.05
        animator.addBehavior(itemBehaviour)
        movie()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MusicHelper.shared.playBackgroundMusic()
        
        checkUserName() { isConfirmed in
            if !isConfirmed {
                self.BigJapan()
            }
        }
    }
    
    func movie() {
        
        let alpha = catDinaic.alpha
        let center = catDinaic.center
        let transform = catDinaic.transform
        
        UIView.animate(withDuration: 3, animations: {
            self.catDinaic.alpha = 2
            self.catDinaic.center = CGPoint(x: 500, y: 900)
            self.catDinaic.transform = CGAffineTransform(scaleX: 1.0, y: 9.0)
        }) { (isFinished) in
            if isFinished {
                self.catDinaic.alpha = alpha
                self.catDinaic.center = center
                self.catDinaic.transform = transform
        }
    }
}
   
    // MARK: - Private methods
    
    private func BigJapan() {
        guard let url = URL(string: "https://www.youtube.com/watch?v=sjGl-pq4RxQ") else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func checkUserName(handler: ((_ isConfirmed: Bool) -> ())? = nil) {
        
        guard StoreManager.shared.name.count == 0 else {
            handler?(true)
            return
        }
        
        let alert = UIAlertController(title: "Enter your name", message: "saving scores", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        let confirmAction = UIAlertAction(title: "Save", style: .default) { action in
            let name = alert.textFields?.first?.text ?? ""
            StoreManager.shared.name = name
            if name.count == 0 {
                handler?(false)
            } else {
                handler?(true)
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            handler?(false)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true)
        
    }
}
