//
//  ViewController.swift
//  PAWMODORO
//
//  Created by Tom Laurel on 12/28/20.
//

    //to add
    // short break button
    // short break button will 
    // long break button
    // cat fact button

/*
 captain's log
 
    have the main functionality of the app working.
 need to work on implementing the API and creating different scenes
 
to do:
 
    make it so that i can press cat facts while the timer stays actives
    //what if its not an alert??? what if i made it show up in a new page? try that tomorrow
    // EXCITED TO WORK ON IT
    //
 
    add list? look up how to implement a to do list on swift
 
    set an alert to go off when the timer hits 0 DONE
    
    make the short break button work -- DONE
 
    IMPLEMENT CAT FACTS API NEEDS TO BE DONE
 
    current problem: the timer wont run in the background
 
    what if, instead of an alert, the cat fact button showed a message on screen
    
    EUREKA!!!
    If the cat fact button just changed it's label when pressed to display a cat fact, then I won't need to open up an alert. PLUS THE CHANGING OF THE LABEL DOESN'T INTERFERE WITH THE TIMER.
 
    for some reason, its not wokring anymore!!! never mind i got it to work again. It wasnt working when the functionality was attached to the cat fact button.
 
    to do for tomorrow:
    create to do list
    implement api
 
  API HAS BEEN IMPLEMENTED
    the cat fact button doesnt seem to work when the timer is counting down.......
 
    GOT IT TO WORK!!!
 
    known problem: if i spam the resume and pause button at the same time as the catfact button, the timetracker value gets wonky. I don't know how to fix that.
    
 */

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var catFactLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var catFactButton: UIButton!
    
    @IBOutlet weak var longBreakButton: UIButton!
    
    @IBOutlet weak var shortBreakButton: UIButton!
    
    
    var randomNum = 0
        
    var timer = Timer()
    var hasTimerStarted = false
    var time = 1500 // 25 minutes
    var timeTracker = 0
    var isCatFactPressed = false
    var catFactString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        catFactButton.backgroundColor = .clear
        catFactButton.layer.cornerRadius = 5
        catFactButton.layer.borderWidth = 1
        catFactButton.backgroundColor = UIColor.systemYellow
        catFactButton.layer.borderColor = UIColor.black.cgColor
        /*
        let catFactProvider: CatFactProvider! = CatFactApi()
        catFactProvider.randomFact {
            switch $0 {
            case .failure(_):
                print("fail")
            case let .success(fact):
                print(fact.text ?? "")
            }
        }
        */
        
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if !hasTimerStarted{
            
            startTimer()
            longBreakButton.isHidden = true
            shortBreakButton.isHidden = true
            hasTimerStarted = true
            
            //once the timer has started need the ability to pause
            
            //placeholder
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.orange, for: .normal)
            //once the timer is paused need to add a resume
            
            
        }
        
        else {
            
            timer.invalidate()
            hasTimerStarted = false
            longBreakButton.isHidden = false
            shortBreakButton.isHidden = false
            
            //create the ability to resume
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
            
            
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        timer.invalidate()
        longBreakButton.isHidden = false
        shortBreakButton.isHidden = false
        time = 1500
        hasTimerStarted = false
        timeLabel.text = "25:00"
        
        startButton.setTitle("Start", for: .normal)
        
    }
    
    //func setTimer(){}
    
    func startTimer(){
        
        //when this function is called it isnt constantly updating
        //only checks the time on call, not as it is decreasing
        //print(time)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    //doesnt work
    func killTimer(){
        
        timer.invalidate()
        hasTimerStarted = false
        
        let alert = UIAlertController(title: "TIME IS UP" ,
                                      message: nil,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Got it!", style: .default,
                                   handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        shortBreakButton.isHidden = false
        longBreakButton.isHidden = false
        
        time = 1500
        
        timeLabel.text = "25:00"
        startButton.setTitle("Start", for: .normal)
        
    }
    
    @objc func updateTimer(){
        
        time -= 1
        timeLabel.text = formatTime()
        
        //TIMER NOW STOPS AT ZERO
        if (time == 0){
            killTimer()
        }
        
        
    }
    
    func formatTime()->String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    @IBAction func longBreakButton(_ sender: Any) {
        time = 15 * 60
        
        if !hasTimerStarted {
        startTimer()
        longBreakButton.isHidden = true
        shortBreakButton.isHidden = true
        hasTimerStarted = true
        
        //once the timer has started need the ability to pause
        
        //placeholder
        startButton.setTitle("Pause", for: .normal)
        startButton.setTitleColor(UIColor.orange, for: .normal)
        //once the timer is paused need to add a resume
        }
        
    
        else {
        
        timer.invalidate()
        hasTimerStarted = false
        
        //create the ability to resume
        startButton.setTitle("Resume", for: .normal)
        startButton.setTitleColor(UIColor.green, for: .normal)
        
        }
        
    }
    
    
    @IBAction func shortBreakButton(_ sender: Any) {
        time = 60 * 5
        //print(time)
        
        if !hasTimerStarted {
        startTimer()
        longBreakButton.isHidden = true
        shortBreakButton.isHidden = true
        hasTimerStarted = true
        
        //once the timer has started need the ability to pause
        
        //placeholder
        startButton.setTitle("Pause", for: .normal)
        startButton.setTitleColor(UIColor.orange, for: .normal)
        //once the timer is paused need to add a resume
        }
    
        else {
        
        timer.invalidate()
        hasTimerStarted = false
        
        //create the ability to resume
        startButton.setTitle("Resume", for: .normal)
        startButton.setTitleColor(UIColor.green, for: .normal)
        
        }
        
    }
    
    @IBAction func catFactButtonPressed() {
                
        
        /*
        randomNum = Int.random(in: 0...999999)

        let alert = UIAlertController(title: "Cat Fact #\(randomNum)" ,
                                      message: "Cat Fact Placeholder",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default,
                                   handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        */
        }
    
    
    @IBAction func testButton(_ sender: Any) {
        
        if (hasTimerStarted == true){
            timeTracker = time
            timer.invalidate()
            hasTimerStarted = false
        }
        
        
        randomNum = Int.random(in: 0...999999)
        
        let catFactProvider: CatFactProvider! = CatFactApi()
        catFactProvider.randomFact {
            switch $0 {
            case .failure(_):
                print("fail")
            case let .success(fact):
                //print(fact.text ?? "")
                self.catFactString = fact.text ?? ""
                //print(catFactString)
                //if i take this out of the switch statement it doesn't cause any errors but it doesn't update the UILabel text... hmm
                //self.catFactLabel.text = fact.text ?? ""
            }
        }
        
        //EUREKA IT WORKS
        print(catFactString)
        self.catFactLabel.text = catFactString
        
        if (hasTimerStarted == false && time < 1500) {
            time = timeTracker
            startTimer()
            hasTimerStarted = true
        }
        
        //catFactLabel.text = catFactString
        //catFactLabel.text = "Cat Fact #\(randomNum): \n " + catFactString
        
        //catFactLabel = fact.text ?? ""
        
        //print(catFactString)
        
        //how do i get the cat fact button to not interfere with the timer???
        //snapshot the time, invalidate the timer, call api, update the label, resume timer.

    }

}

