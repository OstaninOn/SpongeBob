import UIKit
import AVFoundation

class GamesViewController: UIViewController {
    
    //var audioPlayer = AVAudioPlayer()
    
    // MARK: - Private properties
    var image = UIImage(named: "fish")
    lazy var imageView = UIImageView(image: image)
    private lazy var imageViewSecond = UIImageView(image: image)
    private lazy var imageViewThird = UIImageView(image: image)
    
    var meduza2 = UIImage(named: "meduza2")
    lazy var imageMeduza2 = UIImageView(image: meduza2)
    lazy var imageViewMeduza3 = UIImageView(image: meduza2)
    
    let burger1 = UIImage(named: "burger1")
    lazy var imageBurger1 = UIImageView(image: burger1)
    lazy var imageBurger2 = UIImageView(image: burger1)
    
    lazy var catX: CGFloat = view.frame.width / 2
    lazy var catY: CGFloat = view.frame.height * 2 / 3
    
    var isGaming = true
    
    var timer = Timer()
    var time = 3 {
        didSet {
            timerLabel.text = "\(time)"
        }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var catView: UIImageView!
    
    @IBOutlet weak var ScoreLebel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var RezultLebel: UILabel!
    
    var score = 0
    
    var rezult = 0
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Override methods
    
    override func viewDidLayoutSubviews() {
        catView.center = CGPoint(x: catX, y: catY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 30, y: -100, width: 50, height: 50)
        view.addSubview(imageViewSecond)
        imageViewSecond.frame = CGRect(x: 150, y: -150, width: 50, height: 50)
        view.addSubview(imageViewThird)
        imageViewThird.frame = CGRect(x: 300, y: -150, width: 50, height: 50)
        
        view.addSubview(imageMeduza2)
        imageMeduza2.frame = CGRect(x: 30, y: -150, width: 130, height: 130)
        view.addSubview(imageViewMeduza3)
        imageViewMeduza3.frame = CGRect(x: 270, y: -80, width: 130, height: 130)
        
        view.addSubview(imageBurger1)
        imageBurger1.frame = CGRect(x: 80, y: -150, width: 80, height: 80)
        view.addSubview(imageBurger2)
        imageBurger2.frame = CGRect(x: 300, y: -60, width: 80, height: 80)
        
        catView.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragTheView))
        catView.addGestureRecognizer(panGestureRecognizer)
        
        catView.layer.shadowOffset = CGSize(width: 5, height: 5)
        catView.layer.shadowOpacity = 0.5
        catView.layer.shadowRadius = 2
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        rezult = StoreManager.shared.scores.first?.score ?? 0
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc func tick() {
        time -= 1
        if time == 0 {
            timer.invalidate()
            timerLabel.text = nil
        }
    }
    
    @objc func dragTheView(recognizer: UIPanGestureRecognizer) {
        
        if recognizer.state == .began {
        } else if recognizer.state == .changed {
            
            let translation = recognizer.translation(in: self.view)
            tiltTheView(with: translation)
            
            let newX = catView.center.x + translation.x
            let newY = catView.center.y + translation.y
            
            catView.center = CGPoint(x: newX, y: newY)
            catX = newX
            catY = newY
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        } else if recognizer.state == .ended {
            
            if catView.center.x < 20 {
                UIView.animate(withDuration: 0.6, animations: { [unowned self] in
                    self.catView.center.x = -self.catView.frame.size.width
                })
            } else if catView.center.x > self.view.frame.size.width + 20 {
                UIView.animate(withDuration: 0.6, animations: { [unowned self] in
                    self.catView.center.x = self.view.frame.size.width + self.catView.frame.size.width
                })
            }
            
            UIView.animate(withDuration: 0.6, delay: 0, animations: {
                self.catView.transform = .identity
                self.catView.center = self.view.center
            })
        }
        
    }
    
    // MARK: - Private methods
    
    private func tiltTheView(with translationValue: CGPoint) {
        _ = self.view.center.x - self.catView.center.x
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        UIView.animate(withDuration: 4, delay: 4, options: [
            .curveLinear, .repeat], animations: {
                self.imageView.frame.origin.y +=
                self.view.frame.width + 900
            })
        
        UIView.animate(withDuration: 3, delay: 5, options: [
            .curveLinear, .repeat], animations: {
                self.imageViewSecond.frame.origin.y +=
                self.view.frame.width + 600
            })
        
        UIView.animate(withDuration: 8, delay: 2, options: [
            .curveLinear, .repeat], animations: {
                self.imageViewThird.frame.origin.y +=
                self.view.frame.width + 900
            })
        
        UIView.animate(withDuration: 6, delay: 10, options: [
            .curveLinear, .repeat], animations: {
                self.imageMeduza2.frame.origin.y +=
                self.view.frame.width + 600
            })
        
        UIView.animate(withDuration: 8, delay: 3, options: [
            .curveLinear, .repeat], animations: {
                self.imageViewMeduza3.frame.origin.y +=
                self.view.frame.width + 800
            })
        
        UIView.animate(withDuration: 5, delay: 3, options: [
            .curveLinear, .repeat], animations: {
                self.imageBurger1.frame.origin.y +=
                self.view.frame.width + 800
            })
        
        UIView.animate(withDuration: 12, delay: 8, options: [
            .curveLinear, .repeat], animations: {
                self.imageBurger2.frame.origin.y +=
                self.view.frame.width + 700
            })
        
        intersects()
        intersectsFirstFish()
        intersectsSecondFish()
        intersectsThirdFish()
        intersectsimageBurgerFirst()
        intersectsBurgerSecond()
        
        setupVisualEffectView()
        
        RezultLebel.text = String(rezult)
        ScoreLebel.text = String(score)
        
    }
    
    func intersects() {
        
        guard isGaming else { return }
        if checkIntersect(catView, imageMeduza2)
            || checkIntersect(catView, imageViewMeduza3) {
            print("GAME OVER")
            animateIn()
            imageMeduza2.layer.removeAllAnimations()
            imageViewMeduza3.layer.removeAllAnimations()
            imageView.layer.removeAllAnimations()
            imageViewSecond.layer.removeAllAnimations()
            imageViewThird.layer.removeAllAnimations()
            imageBurger1.layer.removeAllAnimations()
            imageBurger2.layer.removeAllAnimations()
            isGaming = false
            saveRecord()
            MusicHelper.shared.stopBackgroundMusic()
            MusicHelper.shared.audioPlayer.currentTime = 0
            
  // ВИБРО
            AudioServicesPlaySystemSound(SystemSoundID(4095))
       
          let alert = UIAlertController(title: "GAME OVER", message: "saving", preferredStyle: .alert)
            
    guard let viewBack = storyboard?.instantiateViewController(withIdentifier: "transition") else { return }
          let okButton = UIAlertAction(title: "OK", style: .default, handler: { [self]_ in self.navigationController?.pushViewController(viewBack, animated: true)
            })
            
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.intersects()
        }
    }

    func saveRecord() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let currentDateString = dateFormatter.string(from: Date())
        
        let userName = StoreManager.shared.name
        let newScore = ScoreModel(name: userName, score: score, date: currentDateString)
        
        var scores = StoreManager.shared.scores
        scores.append(newScore)
        scores.sort(by: >)
        StoreManager.shared.scores = scores
        }

    
    func intersectsFirstFish() {
        guard isGaming else { return }
        if checkIntersect(catView, imageView){
            print("fish")
            isGaming = true
            
            MusicSound.shared.playMusicSound()
            score += 1
            ScoreLebel.text = String(score)
            
            RezultLebel.text = String(rezult)
            
            imageView.frame = CGRect(x: 30, y: -100, width: 50, height: 50)
            UIView.animate(withDuration: 6, delay: 4, options: [
                .curveLinear, .repeat], animations: {
                    self.imageView.frame.origin.y +=
                    self.view.frame.width + 800
                })
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.intersectsFirstFish()
        }
    }
    
    func intersectsSecondFish() {
        guard isGaming else { return }
        if checkIntersect(catView, imageViewSecond){
            print("fish")
            isGaming = true
            MusicSound.shared.playMusicSound()
            score += 1
            ScoreLebel.text = String(score)
            
            RezultLebel.text = String(rezult)
            
            imageViewSecond.frame = CGRect(x: 150, y: -150, width: 50, height: 50)
            UIView.animate(withDuration: 3, delay: 5, options: [
                .curveLinear, .repeat], animations: {
                    self.imageViewSecond.frame.origin.y +=
                    self.view.frame.width + 600
                })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.intersectsSecondFish()
        }
    }
    
    func intersectsThirdFish() {
        guard isGaming else { return }
        if checkIntersect(catView, imageViewThird){
            print("fish")
            isGaming = true
            MusicSound.shared.playMusicSound()
            score += 1
            ScoreLebel.text = String(score)
            
            RezultLebel.text = String(rezult)
            
            imageViewThird.frame = CGRect(x: 300, y: -150, width: 50, height: 50)
            UIView.animate(withDuration: 8, delay: 2, options: [
                .curveLinear, .repeat], animations: {
                    self.imageViewThird.frame.origin.y +=
                    self.view.frame.width + 900
                })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.intersectsThirdFish()
        }
    }
    
    func intersectsimageBurgerFirst() {
        guard isGaming else { return }
        if checkIntersect(catView, imageBurger1){
            print("fish")
            isGaming = true
            MusicSound.shared.playMusicSound()
            score += 1
            ScoreLebel.text = String(score)
            
            RezultLebel.text = String(rezult)
            
            imageBurger1.frame = CGRect(x: 80, y: -150, width: 80, height: 80)
            UIView.animate(withDuration: 5, delay: 3, options: [
                .curveLinear, .repeat], animations: {
                    self.imageBurger1.frame.origin.y +=
                    self.view.frame.width + 800
                })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.intersectsimageBurgerFirst()
        }
        
    }
    
    func intersectsBurgerSecond() {
        guard isGaming else { return }
        if checkIntersect(catView, imageBurger2){
            print("fish")
            isGaming = true
            MusicSound.shared.playMusicSound()
            score += 1
            ScoreLebel.text = String(score)
            
            RezultLebel.text = String(rezult)
            
            imageBurger2.frame = CGRect(x: 300, y: -60, width: 80, height: 80)
            UIView.animate(withDuration: 5, delay: 8, options: [
                .curveLinear, .repeat], animations: {
                    self.imageBurger2.frame.origin.y +=
                    self.view.frame.width + 400
                })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.intersectsBurgerSecond()
        }
    }
    
    func checkIntersect(_ first: UIView, _ second: UIView) -> Bool {
        guard let firstFrame = first.layer.presentation()?.frame,
              let secondFrame = second.layer.presentation()?.frame else { return true }
        
        return firstFrame.intersects(secondFrame)
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    func animateIn() {
        UIView.animate(withDuration: 2) {
            self.visualEffectView.alpha = 0.7
            
        }
        
    }
}

