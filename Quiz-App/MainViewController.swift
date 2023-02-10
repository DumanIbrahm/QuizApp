//
//  MainViewController.swift
//  Quiz-App
//
//  Created by İbrahim Duman on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    let questions = ["Mustafa Kemal Atatürk’ün Nüfusa Kayıtlı Olduğu İl Hangisidir?",
                     "Tsunami Felaketinde En Fazla Zarar Gören Güney Asya Ülkesi Aşağıdakilerden Hangisidir?",
                     "“Sinekli Bakkal” Romanının Yazarı Aşağıdakilerden Hangisidir?",
                     "Aşağıda Verilen İlk Çağ Uygarlıklarından Hangisi Yazıyı İcat Etmiştir?",
                     "Bir Gün Kaç Saniyedir?",
                     "Cevdet Bey ve Oğulları Eseri Kime Aittir?",]
    
    
    let answers = [["Gaziantep","Bursa","İstanbul"],
                   ["Endonezya","Srilanka","Tayland"],
                   ["Halide Edip Adıvar","Reşat Nuri Güntekin","Ziya Gökalp"],
                   ["Sümerler","Urartular","Elamlar"],
                   ["86400","84800","88600"],
                   ["Orhan Pamuk","Yahya Kemal Bayatlı","Atilla İlhan"],
    ]

    var currentQuestion = 0
    var score = 0
    var rightAnswer:UInt32 = 0
    var timeText = 0
    var defaults = UserDefaults.standard
    var timer = Timer()
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var soru: UILabel!
    @IBOutlet weak var BtnA: UIButton!
    @IBOutlet weak var BtnC: UIButton!
    @IBOutlet weak var BtnB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeCount()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
        BtnA.layer.cornerRadius = 10
        BtnB.layer.cornerRadius = 10
        BtnC.layer.cornerRadius = 10
    }
    func timeCount(){
        for _ in questions{
            timeText += 3
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        nextQuestion()
    }
    @objc func decreaseTime(){
        time.text = "Süre : \(timeText)"
        timeText -= 1
        if timeText == 0 {
            timer.invalidate()
            let alert = UIAlertController(title: "Süre Bitti!", message: "Puanın : \(score) ", preferredStyle: .alert)
            let replayButton = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.defaults.set(String(self.score), forKey: "score")
                self.defaults.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(replayButton)
            self.present(alert, animated: true)

        }
    }
    
    func nextQuestion(){
        soru.text = questions[currentQuestion]
        rightAnswer = arc4random_uniform(3) + 1
        var button = UIButton()
        var x = 1
        for i in 1...3{
            button = view.viewWithTag(i) as! UIButton
            if i == Int(rightAnswer){
                button.setTitle(answers[currentQuestion][0], for: .normal)
            }else{
                button.setTitle(answers[currentQuestion][x], for: .normal)
                x = 2
            }
           
        }
        currentQuestion += 1
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        if sender.tag == Int(rightAnswer){
            print("Right")
            score += 1
        }else{
            print("Wrong")
        }
        if currentQuestion != questions.count{
            nextQuestion()
        }else{
            defaults.set(String(score), forKey: "score")
            defaults.synchronize()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    

}
