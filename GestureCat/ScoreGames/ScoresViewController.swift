//
//  ScoresViewController.swift
//  GestureCat
//
//  Created by  aleksandr on 18.11.22.
//

import UIKit

class ScoresViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "ScoreCell"
    
    private lazy var scores = StoreManager.shared.scores
    
    private var selectedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self

        let cellNib = UINib(nibName: "ScoreCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "ScoreCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ScoreViewController,
        selectedIndex >= 0, selectedIndex < scores.count else { return }
        
        destination.name = scores[selectedIndex].name
        destination.place = "\(selectedIndex + 1)"
        destination.score = scores[selectedIndex].score.makeScore()
        destination.date = scores[selectedIndex].date
        
        selectedIndex = -1
    }
    
}

extension ScoresViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { scores.count }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        selectedIndex = index
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openScore", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ScoreCell,
              index >= 0,
              index < scores.count
        else {
            return UITableViewCell()
        }
        
        cell.setup(with: scores[index])
        
        switch index {
        case 0:
            cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case 1:
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case 2:
            cell.backgroundColor = #colorLiteral(red: 0.9732971787, green: 0.6099481583, blue: 0.4317957163, alpha: 1)
        default:
            
            cell.backgroundColor = index % 2 == 1 ? #colorLiteral(red: 0, green: 3, blue: 0, alpha: 0.1) : #colorLiteral(red: 0, green: 0, blue: 3, alpha: 0.1)
        }
        
        return cell
        
    }
    
}



