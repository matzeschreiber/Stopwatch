//
//  ViewController.swift
//  Stopwatch
//
//  Created by Matt on 05.04.18.
//  Copyright © 2018 Matt. All rights reserved.
//

import UIKit

extension Float {
    func toString() -> String {
        return String(self)
    }
}

class ViewController: UIViewController {

    //MARK: Properties
    let timeL: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Play Me", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .selected)
        button.backgroundColor = UIColor.green
        button.titleLabel?.font.withSize(30)
        button.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pauseBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .selected)
        button.backgroundColor = UIColor.blue
        button.titleLabel?.font.withSize(30)
        button.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isPaused: Bool = {
        return false
    }()
    
    var counter: Float = {
        return 0.0
    }()
    
    var timer: Timer = {
        let t = Timer()
        return t
    }()
    
    //MARK: Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(timeL)
        self.view.addSubview(playBtn)
        self.view.addSubview(pauseBtn)
        self.setup()
        
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Methods
    private func setup() { //AutoLayout
        timeL.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        timeL.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        timeL.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        playBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        playBtn.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        playBtn.rightAnchor.constraint(equalTo: pauseBtn.leftAnchor).isActive = true
        playBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        playBtn.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        pauseBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pauseBtn.leftAnchor.constraint(equalTo: playBtn.rightAnchor).isActive = true
        pauseBtn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        pauseBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        pauseBtn.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    @objc func playAction() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(increaseTime), userInfo: nil, repeats: true)
        timer.fire()
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        playBtn.backgroundColor = UIColor.lightGray
        isPaused = false
    }
    
    @objc func pauseAction() {
        timer.invalidate()
        
        if isPaused {
            //Reset timer-MVC -> Stop
            pauseBtn.setTitle("Pause", for: .normal)
            isPaused = false
            counter = 0.0
            timeL.text = counter.toString()
            
        } else {
            isPaused = true
            pauseBtn.setTitle("Stop", for: .normal)
            pauseBtn.backgroundColor = UIColor.red
        }
        
        playBtn.isEnabled = true
        playBtn.backgroundColor = UIColor.green
    }
    
    @objc func increaseTime() {
            counter += 0.1
            timeL.text = counter.toString()
    }
}

