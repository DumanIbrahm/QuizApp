//
//  ViewController.swift
//  Quiz-App
//
//  Created by İbrahim Duman on 10.02.2023.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var btnBasla: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
}

    override func viewWillAppear(_ animated: Bool) {
        let score = UserDefaults.standard.string(forKey:"score") ?? "0"
        scoreLabel.text = "Last Score : \(score)"
    }


}

