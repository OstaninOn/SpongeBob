//
//  TitleViewController.swift
//  GestureCat
//
//  Created by  aleksandr on 3.10.22.


import UIKit
import AVFoundation
import Lottie

class TitleViewController: UIViewController {
    
    @IBOutlet weak var TopRecord: UIButton!
    
    @IBOutlet weak var Settings: UIButton!
    
    @IBOutlet weak var StartTitle: UIView!
    
    @IBOutlet weak var BackgroundImage: BackgroundImageView!
    
    @IBOutlet weak var catDinaic: UIImageView!
    
    @IBOutlet weak var LottieStartImage: UIView!
    
    @IBOutlet weak var lottieRecordImage: UIView!
    
    @IBOutlet weak var lottieSettingImage: UIView!
    
    @IBOutlet weak var CatBottom: UIView!
    
    
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MusicHelper.sharedGame.stopBackgroundMusicGame()
        BackgroundImage.makeBlur()
//        MusicHelper.shared.playBackgroundMusic()
//        MusicHelper.shared.audioPlayer.currentTime = 0
//        StartTitle.dropShadow()
 //       StartTitle.layerGradient()
        
//        Settings.dropShadowSetting()
 //       Settings.layerGradientSetting()
        
//        TopRecord.dropShadowRecord()
//        TopRecord.layerGradientRecord()
        
        
        
// gradient bottom
        
//        let gradientTopRecord = CAGradientLayer()
//        gradientTopRecord.colors = [UIColor.white.cgColor,UIColor.yellow.cgColor,]
//        gradientTopRecord.frame = TopRecord.bounds
//        TopRecord.layer.insertSublayer(gradientTopRecord, at: 0)
//        TopRecord.layer.cornerRadius = 16.0
//        TopRecord.layer.masksToBounds = true
        
        
        
//        let gradientSettings = CAGradientLayer()
//        gradientSettings.colors = [UIColor.white.cgColor,UIColor.systemRed.cgColor,]
//        gradientSettings.frame = Settings.bounds
//        Settings.layer.insertSublayer(gradientSettings, at: 0)
//        Settings.layer.cornerRadius = 16.0
//        Settings.layer.masksToBounds = true
        
        
//        let gradientView = CAGradientLayer()
//        gradientView.colors = [UIColor.black.cgColor,UIColor.systemPink.cgColor]
//        gradientView.frame = view.bounds
//        view.layer.insertSublayer(gradientView, at: 0)
//        view.layer.masksToBounds = false
        
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [catDinaic])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [catDinaic])
        collision.addBoundary(withIdentifier: "CatBottom" as NSCopying, for: UIBezierPath(rect: CatBottom.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [catDinaic])
        itemBehaviour.elasticity = 1.06
        animator.addBehavior(itemBehaviour)
        movie()
        
        addAnimePlay()
        addAnimeSettings()
        addAnimeRecord()
        
        
        
    // animate view top and bottom
        
        
    //        UIView.animate(withDuration: 1, animations: {
    //            self.StartTitle.backgroundColor = .brown
    //            self.StartTitle.frame.size.width += 10
    //            self.StartTitle.frame.size.height += 10
    //        }) { _ in
    //            UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
    //                self.StartTitle.frame.origin.y -= 20
    //            })
    //        }
            
        
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
    

    @IBAction func startButton(_ sender: Any) {
        MusicSound.shared.playSoundTitle()
    }
    
    @IBAction func recordButton(_ sender: Any) {
        MusicSound.shared.playSoundTitle()
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        MusicSound.shared.playSoundTitle()
    }
    
    
    
    
    
    func addAnimePlay() {
        let animeLoadView = LottieAnimationView(name: "f7ba78d7-b1de-4790-a81e-9d78a42c6731")
        animeLoadView.contentMode = .scaleToFill
        animeLoadView.frame = self.LottieStartImage.bounds
        animeLoadView.loopMode = .loop
        animeLoadView.play()
        self.LottieStartImage.addSubview(animeLoadView)
    
    }
    
    func addAnimeRecord() {
        let animeLoadView = LottieAnimationView(name: "cup")
        animeLoadView.contentMode = .scaleToFill
        animeLoadView.frame = self.lottieRecordImage.bounds
        animeLoadView.loopMode = .loop
        animeLoadView.play()
        //animeLoadView.animationSpeed = 0.5
        self.lottieRecordImage.addSubview(animeLoadView)
    
    }
    
    func addAnimeSettings() {
        let animeLoadView = LottieAnimationView(name: "sett")
        animeLoadView.contentMode = .scaleAspectFill
        animeLoadView.frame = self.lottieSettingImage.bounds
        animeLoadView.loopMode = .loop
        animeLoadView.play()
        //animeLoadView.animationSpeed = 0.6
        self.lottieSettingImage.addSubview(animeLoadView)
    }
    
    
    func movie() {
        
        let alpha = catDinaic.alpha
        let center = catDinaic.center
        let transform = catDinaic.transform
        
        UIView.animate(withDuration: 2, animations: {
            self.catDinaic.alpha = 1
            self.catDinaic.center = CGPoint(x: 200, y: 800)
            self.catDinaic.transform = CGAffineTransform(scaleX: 1, y: 1)
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



//extension UIView {
//
//        func dropShadow() {
//
//            var shadowLayer: CAShapeLayer!
//            let cornerRadius: CGFloat = 16.0
//            let fillColor: UIColor = UIColor(named: "ColorSetting")!
//
//            if shadowLayer == nil {
//                shadowLayer = CAShapeLayer()
//
//                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//                shadowLayer.fillColor = fillColor.cgColor
//
//                shadowLayer.shadowColor = UIColor.black.cgColor
//                shadowLayer.shadowPath = shadowLayer.path
//                shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//                shadowLayer.shadowOpacity = 0.8
//                shadowLayer.shadowRadius = 3
//
//                layer.insertSublayer(shadowLayer, at: 0)
//            }
//        }
//    }






// add button shadow and corner radius




//extension UIView {
//    func layerGradient() {
//        let layer : CAGradientLayer = CAGradientLayer()
//        layer.frame.size = self.frame.size
//        layer.frame.origin = CGPointMake(0.0, -2.0)
//        layer.cornerRadius = CGFloat(frame.width / 6.0)
//
//        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
//        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
//        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
//        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
//        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
//        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
//        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
//
//        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
//        self.layer.insertSublayer(layer, at: 0)
//    }
//
//}

//extension UIView {
//
//        func dropShadowRecord() {
//
//            var shadowLayer: CAShapeLayer!
//            let cornerRadius: CGFloat = 16.0
//            let fillColor: UIColor = UIColor(named: "ColorRecord")!
//
//            if shadowLayer == nil {
//                shadowLayer = CAShapeLayer()
//
//                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//                shadowLayer.fillColor = fillColor.cgColor
//
//                shadowLayer.shadowColor = UIColor.black.cgColor
//                shadowLayer.shadowPath = shadowLayer.path
//                shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//                shadowLayer.shadowOpacity = 0.8
//                shadowLayer.shadowRadius = 3
//
//                layer.insertSublayer(shadowLayer, at: 0)
//            }
//        }
//    }

//
//extension UIView {
//    func layerGradientRecord() {
//        let layer : CAGradientLayer = CAGradientLayer()
//        layer.frame.size = self.frame.size
//        layer.frame.origin = CGPointMake(0.0, -2.0)
//        layer.cornerRadius = CGFloat(frame.width / 2)
//
//        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
//        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
//        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
//        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
//        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
//        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
//        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
//
//        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
//        self.layer.insertSublayer(layer, at: 0)
//    }
//
//}
//



//extension UIView {
//
//        func dropShadowSetting() {
//
//            var shadowLayer: CAShapeLayer!
//            let cornerRadius: CGFloat = 16.0
//            let fillColor: UIColor = UIColor(named: "ColorSetting")!
//
//            if shadowLayer == nil {
//                shadowLayer = CAShapeLayer()
//
//                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//                shadowLayer.fillColor = fillColor.cgColor
//
//                shadowLayer.shadowColor = UIColor.black.cgColor
//                shadowLayer.shadowPath = shadowLayer.path
//                shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//                shadowLayer.shadowOpacity = 0.8
//                shadowLayer.shadowRadius = 3
//
//                layer.insertSublayer(shadowLayer, at: 0)
//            }
//        }
//    }


//extension UIView {
//    func layerGradientSetting() {
//        let layer : CAGradientLayer = CAGradientLayer()
//        layer.frame.size = self.frame.size
//        layer.frame.origin = CGPointMake(0.0, -2.0)
//        layer.cornerRadius = CGFloat(frame.width / 2)
//
//        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
//        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
//        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
//        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
//        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
//        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
//        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
//
//        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
//        self.layer.insertSublayer(layer, at: 0)
//    }
//
//}
