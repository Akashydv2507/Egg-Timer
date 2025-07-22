//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player : AVAudioPlayer!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // Time in minutes (you can change these to actual seconds if needed)
    let eggTimes = [ "Soft": 3, "Medium": 7, "Hard": 12 ]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        
        // Invalidate any existing timer
        timer.invalidate()
        progressView.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // Lookup time based on hardness and calculate total seconds
        let result = eggTimes[hardness]
        totalTime = eggTimes[hardness]!
        
        // Start timer
        timer = Timer.scheduledTimer(timeInterval: 1,target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime{
            
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed)/Float(totalTime))
            
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            //print(titleLabel)
            playSound()
        }
    }
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
}
