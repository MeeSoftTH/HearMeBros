//
//  ViewController.swift
//  hearmebros
//
//  Created by Pawarit_Bunrith on 7/27/2558 BE.
//  Copyright (c) 2558 Pawarit_Bunrith. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import AssetsLibrary
import MobileCoreServices
import Social
import Accounts

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UnityAdsDelegate {
    
    var soundRecorder: AVAudioRecorder!
    var soundPlayer:AVAudioPlayer!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var recordTime: UILabel!
    @IBOutlet var acctionButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var personButton1: UIButton!
    @IBOutlet var personButton2: UIButton!
    @IBOutlet var personButton3: UIButton!
    @IBOutlet var personButton4: UIButton!
    
    @IBOutlet var personButton5: UIButton!
    @IBOutlet var personButton6: UIButton!
    @IBOutlet var personButton7: UIButton!
    
    
    @IBOutlet var actionIndicator: UIActivityIndicatorView!
    @IBOutlet var topRightButton: UIButton!
    
    var meterTimer:NSTimer!
    
    var isAskOn: Bool = true
    var isPreview: Bool = false
    var questionSound: Bool = false
    var answerSound: Bool = false
    var correctSound: Bool = false
    var recordSound: Bool = false
    var isShare: Bool = false
    var isUpdateVisible: Bool = false
    
    var ansSelected: String = ""
    var imageSelected: String = ""
    var yourRecordSound: String = "recorder.m4a"
    var tempAudio1 = "tempAudio1.caf"
    var tempAudio2 = "tempAudio2.caf"
    var fileDestinationUrl : NSURL = NSURL()
    var avalible = [Int]()
    var buttonIndexSelected: Int = 0
    var countDown: Int = 10
    var hiLastSelected: Int = 0
    var answerArray = [Int]()
    
    var path: String = ""
    var hiPath: String = ""
    var imagePath: String = ""
    
    var mode: String = ""
    
    var isSeleccted: Int = 0
    
    var buttonIsOn1: Bool = false
    var buttonIsOn2: Bool = false
    var buttonIsOn3: Bool = false
    var buttonIsOn4: Bool = false
    var buttonIsOn5: Bool = false
    
    var buttonIsOn6: Bool = false
    var buttonIsOn7: Bool = false
    
    let quetion: String = AppConfiguration.audioPath.startQ
    let endQuesion: String = AppConfiguration.audioPath.endQ
    let answerQ: String = AppConfiguration.audioPath.startA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        self.actionIndicator.hidden = true
    }
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button1(sender: UIButton) {
        self.changeColor(personButton1)
        
        if isAskOn == true {
            self.sayHello(1)
        }else if isAskOn == false {
            if self.buttonIsOn1 == false {
                self.buttonIndexSelected = 1
                self.openAds()
                
            }else {
                self.answer(1)
            }
        }
    }
    
    @IBAction func button2(sender: UIButton) {
        self.changeColor(personButton2)
        
        if isAskOn == true {
            self.sayHello(2)
        }else if isAskOn == false {
            if self.buttonIsOn2 == false {
                self.buttonIndexSelected = 2
                self.openAds()
                
            }else {
                self.answer(2)
            }
        }
    }
    
    @IBAction func button3(sender: UIButton) {
        self.changeColor(personButton3)
        
        if isAskOn == true {
            self.sayHello(3)
        }else if isAskOn == false {
            if self.buttonIsOn3 == false {
                self.buttonIndexSelected = 3
                self.openAds()
                
            }else {
                self.answer(3)
            }
        }
    }
    
    @IBAction func button4(sender: UIButton) {
        self.changeColor(personButton4)
        
        if isAskOn == true {
            self.sayHello(4)
        }else if isAskOn == false {
            if self.buttonIsOn4 == false {
                self.buttonIndexSelected = 4
                self.openAds()
                
            }else {
                self.answer(4)
            }
        }
    }
    
    @IBAction func button5(sender: UIButton) {
        self.changeColor(personButton5)
        
        if isAskOn == true {
            self.sayHello(5)
        }else if isAskOn == false {
            if self.buttonIsOn5 == false {
                self.buttonIndexSelected = 5
                self.openAds()
                
            }else {
                self.answer(5)
            }
        }
    }
    
    @IBAction func button6(sender: UIButton) {
        self.changeColor(personButton6)
        
        if isAskOn == true {
            self.sayHello(6)
        }else if isAskOn == false {
            if self.buttonIsOn6 == false {
                self.buttonIndexSelected = 6
                self.openAds()
                
            }else {
                self.answer(6)
            }
        }
    }
    
    @IBAction func button7(sender: UIButton) {
        self.changeColor(personButton7)
        
        if isAskOn == true {
            self.sayHello(7)
        }else if isAskOn == false {
            if self.buttonIsOn7 == false {
                self.buttonIndexSelected = 7
                self.openAds()
                
            }else {
                self.answer(7)
            }
        }
    }
    
    
    @IBAction func topAction(sender: UIButton) {
        
        if sender.titleLabel?.text == "Redo" {
            self.resetState()
            
        }else if(sender.titleLabel?.text == "Share") {
            
            self.acctionButton.enabled = false
            self.topRightButton.enabled = false
            
            self.resetColor()
            
            self.personButton1.enabled = false
            self.personButton2.enabled = false
            self.personButton3.enabled = false
            self.personButton4.enabled = false
            
            self.personButton5.enabled = false
            self.personButton6.enabled = false
            self.personButton7.enabled = false
            
            self.statusLabel.text = "Processing..."
            self.actionIndicator.hidden = false
            self.actionIndicator.startAnimating()
            self.acctionButton.enabled = false
            
            compressFile()
        }
    }
    
    @IBAction func askThem(sender: UIButton) {
        if (sender.titleLabel?.text == "Ask"){
            
            self.resetState()
            
            self.isUpdateVisible = false
            
            sender.setTitle("Stop", forState: .Normal)
            
            delay(1.0) {
                self.audioPlayer(self.quetion)
                self.mode = "REC"
                self.acctionButton.enabled = false
                
            }
            
            self.resetColor()
            
            self.personButton1.enabled = false
            self.personButton2.enabled = false
            self.personButton3.enabled = false
            self.personButton4.enabled = false
            
            self.personButton5.enabled = false
            self.personButton6.enabled = false
            self.personButton7.enabled = false
            
            UnityAds.sharedInstance().delegate = self
            UnityAds.sharedInstance().startWithGameId("57599")
            
            self.recordTime.text = "Recording 10"
            
            self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,
                target:self,
                selector:"updateAudioMeter:",
                userInfo:nil,
                repeats:true)
        } else if (sender.titleLabel?.text == "Stop"){
            self.mode = "STOP"
            soundRecorder.stop()
            self.audioPlayer(self.endQuesion)
        }
    }
    
    func resetColor() {
        self.personButton1.backgroundColor = UIColor.whiteColor()
        self.personButton1.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton1.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton1.layer.cornerRadius = 20.0;
        
        self.personButton2.backgroundColor = UIColor.whiteColor()
        self.personButton2.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton2.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton2.layer.cornerRadius = 20.0;
        
        self.personButton3.backgroundColor = UIColor.whiteColor()
        self.personButton3.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton3.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton3.layer.cornerRadius = 20.0;
        
        self.personButton4.backgroundColor = UIColor.whiteColor()
        self.personButton4.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton4.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton4.layer.cornerRadius = 20.0;
        
        
        self.personButton5.backgroundColor = UIColor.whiteColor()
        self.personButton5.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton5.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton5.layer.cornerRadius = 20.0;
        
        self.personButton6.backgroundColor = UIColor.whiteColor()
        self.personButton6.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton6.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton6.layer.cornerRadius = 20.0;
        
        self.personButton7.backgroundColor = UIColor.whiteColor()
        self.personButton7.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton7.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton7.layer.cornerRadius = 20.0;
    }
    
    func sayHello(index: Int) {
        
        if self.hiLastSelected != index
        {
            let person = index
            let personSound = randomIndex(3, end: 1)
            self.hiLastSelected = index
            
            self.hiPath = ""
            
            if person == 1 {
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello1a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello1b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello1c
                }
            }else if person == 2 {
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello2a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello2b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello2c
                }
            }else if person == 3 {
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello3a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello3b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello3c
                }
            }else if person == 4 {
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello4a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello4b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello4c
                }
            }else if person == 5 {
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello5a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello5b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello5c
                }
            }else if person == 6{
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello6a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello6b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello6c
                }
            }else if person == 7 {
                if personSound == 1 {
                    self.hiPath = AppConfiguration.audioPath.hello7a
                }else if personSound == 2 {
                    self.hiPath = AppConfiguration.audioPath.hello7b
                }else if personSound == 3 {
                    self.hiPath = AppConfiguration.audioPath.hello7c
                }
                
            }
        }
        self.audioPlayer(self.hiPath)
    }
    
    func answer(index: Int) {
        self.mode = "ANS"
        self.topRightButton.enabled = false
        
        
        if self.isSeleccted != index {
            
            self.isSeleccted = index
            
            let person = index
            
            let soundIndex = self.answerArray
            
            if person == 1{
                
                if soundIndex[0] == 1 {
                    self.path = AppConfiguration.audioPath.ans1a
                }else if soundIndex[0] == 2 {
                    self.path = AppConfiguration.audioPath.ans1b
                }else if soundIndex[0] == 3 {
                    self.path = AppConfiguration.audioPath.ans1c
                }else if soundIndex[0] == 4 {
                    self.path = AppConfiguration.audioPath.ans1d
                    
                }else if soundIndex[0] == 5 {
                    self.path = AppConfiguration.audioPath.ans1e
                }else if soundIndex[0] == 6 {
                    self.path = AppConfiguration.audioPath.ans1f
                }else if soundIndex[0] == 7 {
                    self.path = AppConfiguration.audioPath.ans1g
                }else if soundIndex[0] == 8 {
                    self.path = AppConfiguration.audioPath.ans1h
                }
                
                imagePath = AppConfiguration.imagePath.ans1On
                
            }else if person == 2 {
                
                if soundIndex[1] == 1 {
                    self.path = AppConfiguration.audioPath.ans2a
                }else if soundIndex[1] == 2 {
                    self.path = AppConfiguration.audioPath.ans2b
                }else if soundIndex[1] == 3 {
                    self.path = AppConfiguration.audioPath.ans2c
                }else if soundIndex[1] == 4 {
                    self.path = AppConfiguration.audioPath.ans2d
                    
                }else if soundIndex[1] == 5 {
                    self.path = AppConfiguration.audioPath.ans2e
                }else if soundIndex[1] == 6 {
                    self.path = AppConfiguration.audioPath.ans2f
                }else if soundIndex[1] == 7 {
                    self.path = AppConfiguration.audioPath.ans2g
                }else if soundIndex[1] == 8 {
                    self.path = AppConfiguration.audioPath.ans2h
                }
                
                imagePath = AppConfiguration.imagePath.ans2On
                
            }else if person == 3 {
                
                if soundIndex[2] == 1 {
                    self.path = AppConfiguration.audioPath.ans3a
                }else if soundIndex[2] == 2 {
                    self.path = AppConfiguration.audioPath.ans3b
                }else if soundIndex[2] == 3 {
                    self.path = AppConfiguration.audioPath.ans3c
                }else if soundIndex[2] == 4 {
                    self.path = AppConfiguration.audioPath.ans3d
                    
                }else if soundIndex[2] == 5 {
                    self.path = AppConfiguration.audioPath.ans3e
                }else if soundIndex[2] == 6 {
                    self.path = AppConfiguration.audioPath.ans3f
                }else if soundIndex[2] == 7 {
                    self.path = AppConfiguration.audioPath.ans3g
                }else if soundIndex[2] == 8 {
                    self.path = AppConfiguration.audioPath.ans3h
                }
                
                imagePath = AppConfiguration.imagePath.ans3On
                
            }else if person == 4 {
                
                if soundIndex[3] == 1 {
                    self.path = AppConfiguration.audioPath.ans4a
                }else if soundIndex[3] == 2 {
                    self.path = AppConfiguration.audioPath.ans4b
                }else if soundIndex[3] == 3 {
                    self.path = AppConfiguration.audioPath.ans4c
                }else if soundIndex[3] == 4 {
                    self.path = AppConfiguration.audioPath.ans4d
                    
                }else if soundIndex[3] == 5 {
                    self.path = AppConfiguration.audioPath.ans4e
                }else if soundIndex[3] == 6 {
                    self.path = AppConfiguration.audioPath.ans4f
                }else if soundIndex[3] == 7 {
                    self.path = AppConfiguration.audioPath.ans4g
                }else if soundIndex[3] == 8 {
                    self.path = AppConfiguration.audioPath.ans4h
                }
                
                imagePath = AppConfiguration.imagePath.ans4On
                
            }else if person == 5 {
                
                if soundIndex[4] == 1 {
                    self.path = AppConfiguration.audioPath.ans5a
                }else if soundIndex[4] == 2 {
                    self.path = AppConfiguration.audioPath.ans5b
                }else if soundIndex[4] == 3 {
                    self.path = AppConfiguration.audioPath.ans5c
                }else if soundIndex[4] == 4 {
                    self.path = AppConfiguration.audioPath.ans5d
                    
                }else if soundIndex[4] == 5 {
                    self.path = AppConfiguration.audioPath.ans5e
                }else if soundIndex[4] == 6 {
                    self.path = AppConfiguration.audioPath.ans5f
                }else if soundIndex[4] == 7 {
                    self.path = AppConfiguration.audioPath.ans5g
                }else if soundIndex[4] == 8 {
                    self.path = AppConfiguration.audioPath.ans5h
                }
                
                imagePath = AppConfiguration.imagePath.ans5On
                
            }else if person == 6 {
                if soundIndex[5] == 1 {
                    self.path = AppConfiguration.audioPath.ans6a
                }else if soundIndex[5] == 2 {
                    self.path = AppConfiguration.audioPath.ans6b
                }else if soundIndex[5] == 3 {
                    self.path = AppConfiguration.audioPath.ans6c
                }else if soundIndex[5] == 4 {
                    self.path = AppConfiguration.audioPath.ans6d
                    
                }else if soundIndex[5] == 5 {
                    self.path = AppConfiguration.audioPath.ans6e
                }else if soundIndex[5] == 6 {
                    self.path = AppConfiguration.audioPath.ans6f
                }else if soundIndex[5] == 7 {
                    self.path = AppConfiguration.audioPath.ans6g
                }else if soundIndex[5] == 8 {
                    self.path = AppConfiguration.audioPath.ans6h
                }
                
                imagePath = AppConfiguration.imagePath.ans6On
                
            }else if person == 7 {
                
                if soundIndex[6] == 1 {
                    self.path = AppConfiguration.audioPath.ans7a
                }else if soundIndex[6] == 2 {
                    self.path = AppConfiguration.audioPath.ans7b
                }else if soundIndex[6] == 3 {
                    self.path = AppConfiguration.audioPath.ans7c
                }else if soundIndex[6] == 4 {
                    self.path = AppConfiguration.audioPath.ans7d
                    
                }else if soundIndex[6] == 5 {
                    self.path = AppConfiguration.audioPath.ans7e
                }else if soundIndex[6] == 6 {
                    self.path = AppConfiguration.audioPath.ans7f
                }else if soundIndex[6] == 7 {
                    self.path = AppConfiguration.audioPath.ans7g
                }else if soundIndex[6] == 8 {
                    self.path = AppConfiguration.audioPath.ans7h
                }
                imagePath = AppConfiguration.imagePath.ans7On
            }
        }
        
        self.ansSelected = self.path
        self.imageSelected = imagePath
        self.audioPlayer(self.path)
        
        self.topRightButton.setTitle("Share", forState: .Normal)
    }
    
    func sayStop() {
        let person = randomIndex(7, end: 1)
        let personSound = randomIndex(3, end: 1)
        
        var stopPath: String = ""
        
        if person == 1 {
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop1a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop1b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop1b
            }
        }else if person == 2 {
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop2a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop2b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop2c
            }
        }else if person == 3 {
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop3a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop3b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop3c
            }
        }else if person == 4 {
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop4a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop4b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop4c
            }
        }else if person == 5 {
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop5a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop5b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop5c
            }
        }else if person == 6{
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop6a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop6b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop6c
            }
        }else if person == 7 {
            if personSound == 1 {
                stopPath = AppConfiguration.audioPath.stop7a
            }else if personSound == 2 {
                stopPath = AppConfiguration.audioPath.stop7b
            }else if personSound == 3 {
                stopPath = AppConfiguration.audioPath.stop7c
            }
            
        }
        
        self.audioPlayer(stopPath)
        self.mode = "STOP"
        
    }
    
    func randomIndex(start: Int, end: Int)-> Int {
        var randomNumber = arc4random_uniform(UInt32(start)) + UInt32(end)
        return Int(randomNumber)
    }
    
    func audioPlayer(strPath: String) {
        
        var error: NSError?
        println("String path = \(strPath)")
        
        let resourcePath = NSBundle.mainBundle().URLForResource(strPath, withExtension: "m4a")!
        
        soundPlayer = AVAudioPlayer(contentsOfURL: resourcePath, error: nil)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        if !session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error:&error) {
            println("could not set output to speaker")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        
        if let err = error {
            println("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            println("AVAudioPlayer Play: \(resourcePath)")
            soundPlayer.stop()
            soundPlayer.delegate = self
            soundPlayer.volume = 1.0
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        }
    }
    
    
    func recordPlayer() {
        
        var error: NSError?
        
        soundPlayer = AVAudioPlayer(contentsOfURL: getFileURL(self.yourRecordSound), error: &error)
        
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        if !session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error:&error) {
            println("could not set output to speaker")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        
        if let err = error {
            println("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            soundPlayer.stop()
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
            soundPlayer.play()
        }
    }
    
    func setupRecorder() {
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        var error: NSError?
        
        soundRecorder = AVAudioRecorder(URL: getFileURL(self.yourRecordSound), settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        if let err = error {
            println("AVAudioRecorder error: \(err.localizedDescription)")
        } else {
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }
    }
    
    func getFileURL(fileName: String) -> NSURL {
        
        let path = getCacheDirectory().stringByAppendingPathComponent(fileName)
        let filePath = NSURL(fileURLWithPath: path)
        return filePath!
    }
    
    func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory,.UserDomainMask, true) as! [String]
        
        return paths[0]
    }
    
    func updateAudioMeter(timer:NSTimer) {
        
        if soundRecorder.recording {
            let sec = Int(soundRecorder.currentTime % 60)
            
            recordTime.text = "Recording \(String(self.countDown - sec))"
            soundRecorder.updateMeters()
            
            println("This time is \(sec)")
            
            if sec == 10 {
                soundRecorder.stop()
                sayStop()
            }
        }
    }
    
    func sucessRecord() {
        
        //self.acctionButton.enabled = false
        self.acctionButton.setTitle("Ask", forState: .Normal)
        //self.acctionButton.backgroundColor = UIColor.grayColor()
        self.isAskOn = false
        //self.topRightButton.hidden = false
        
        self.personButton1.enabled = true
        self.personButton2.enabled = true
        self.personButton3.enabled = true
        self.personButton4.enabled = true
        
        self.personButton5.enabled = true
        self.personButton6.enabled = true
        self.personButton7.enabled = true
        
        self.random7Answer()
        self.updateAnswerVisible()
        
        println("This time is CLICK")
    }
    
    func changeColor(buttonBackground: UIButton) {
        
        if isAskOn == true {
            self.personButton1.backgroundColor = UIColor.whiteColor()
            self.personButton1.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton1.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton1.layer.cornerRadius = 20.0;
            
            self.personButton2.backgroundColor = UIColor.whiteColor()
            self.personButton2.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton2.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton2.layer.cornerRadius = 20.0;
            
            self.personButton3.backgroundColor = UIColor.whiteColor()
            self.personButton3.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton3.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton3.layer.cornerRadius = 20.0;
            
            self.personButton4.backgroundColor = UIColor.whiteColor()
            self.personButton4.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton4.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton4.layer.cornerRadius = 20.0;
            
            
            self.personButton5.backgroundColor = UIColor.whiteColor()
            self.personButton5.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton5.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton5.layer.cornerRadius = 20.0;
            
            self.personButton6.backgroundColor = UIColor.whiteColor()
            self.personButton6.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton6.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton6.layer.cornerRadius = 20.0;
            
            self.personButton7.backgroundColor = UIColor.whiteColor()
            self.personButton7.layer.borderColor = UIColor.clearColor().CGColor
            self.personButton7.layer.borderWidth = 2.5
            // Set image corner radius
            self.personButton7.layer.cornerRadius = 20.0;
            
            
        } else if isAskOn == false {
            self.updateAnswerVisible()
        }
        
        //buttonBackground.backgroundColor = UIColor.blueColor()
        
        // Create a white border with defined width
        buttonBackground.layer.borderColor = UIColor.blueColor().CGColor
        buttonBackground.layer.borderWidth = 2.5
        
        // Set image corner radius
        buttonBackground.layer.cornerRadius = 20.0;
    }
    
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Error while playing audio \(error.localizedDescription)")
    }
    
    func compressFile() {
        
        self.acctionButton.setTitle("Waiting", forState: .Normal)
        self.acctionButton.enabled = false
        
        if self.imageSelected != "" {
            println("Start process")
            self.makeVideo()
        }
    }
    
    func getStringFileURL(fileName: String) -> String {
        let path = getCacheDirectory().stringByAppendingPathComponent(fileName)
        return path
    }
    
    func makeVideo() {
        var frames: NSMutableArray = []
        var iconImg = UIImage(named: self.imageSelected)!
        
        
        println("IMAGE PATH = \(self.imageSelected)")
        
        println(iconImg.size.width)
        println(iconImg.size.height)
        
        let newHeight = iconImg.size.height
        let newWidth = iconImg.size.width
        
        var settings = CEMovieMaker.videoSettingsWithCodec(AVVideoCodecH264, withWidth: newWidth, andHeight: newHeight)
        
        var movieMaker: CEMovieMaker = CEMovieMaker(setting: settings)
        
        // Make 1 sec video (default engine is 10 frames per sec.)
        for i in 1...10 { //
            frames.addObject(iconImg)
        }
        
        movieMaker.createMovieFromImages(frames as[AnyObject], withCompletion: {(fileURL: NSURL!) in
            println(fileURL)
            
            let newRecord = self.getStringFileURL(self.yourRecordSound)
            
            var fileURL1 = NSBundle.mainBundle().URLForResource(self.quetion, withExtension: "m4a")
            var fileURL2 = NSURL(fileURLWithPath: newRecord)
            
            println("A1: \(fileURL1)")
            println("A2: \(fileURL2)")
            
            self.mergeTwoAudios(fileURL1!, audio2: fileURL2!, tempSound: self.tempAudio1, index: 0)
        })
    }
    
    
    
    func mergeTwoAudios(audio1: NSURL, audio2:  NSURL, tempSound: String, index: Int) {
        var tempPath = tempSound
        //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
        var composition = AVMutableComposition()
        var compositionAudioTrack1:AVMutableCompositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        var compositionAudioTrack2:AVMutableCompositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        //create new file to receive data
        var documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as! NSURL
        fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent(tempPath)
        println(fileDestinationUrl)
        
        // Clear old file.
        var dirs : [String] = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String])!
        var dir = dirs[0] //documents directory
        var path = dir.stringByAppendingPathComponent(tempPath)
        var pathURLarray:Array = (NSURL(fileURLWithPath: path)!).pathComponents!
        var pathURL:String = ""
        var final = ""
        var debut = ""
        
        for i in 1...(pathURLarray.count-1) {
            if i == pathURLarray.count-1 {
                final = ""
            } else {
                final = "/"
            }
            if i == 1 {
                debut = "/"
            } else {
                debut = ""
            }
            pathURL = debut + pathURL + (pathURLarray[i] as! String) + final
        }
        
        var checkValidation = NSFileManager.defaultManager()
        if checkValidation.fileExistsAtPath(pathURL) {
            println("file exist")
            if NSFileManager.defaultManager().removeItemAtURL(fileDestinationUrl, error: nil) {
                println("delete")
            }
        } else {
            println("no file")
        }
        
        // Do combine four files.
        let audioAsset1 = AVURLAsset(URL: audio1, options: nil)
        let audioAsset2 = AVURLAsset(URL: audio2, options: nil)
        
        let tracks1 =  audioAsset1.tracksWithMediaType(AVMediaTypeAudio)
        let tracks2 =  audioAsset2.tracksWithMediaType(AVMediaTypeAudio)
        
        
        var assetTrack1:AVAssetTrack = tracks1[0] as! AVAssetTrack
        var assetTrack2:AVAssetTrack = tracks2[0] as! AVAssetTrack
        
        let duration1: CMTime = assetTrack1.timeRange.duration
        let duration2: CMTime = assetTrack2.timeRange.duration
        
        let timeRange1 = CMTimeRangeMake(kCMTimeZero, duration1)
        let timeRange2 = CMTimeRangeMake(kCMTimeZero, duration2)
        
        println("duration1 = \(duration1)")
        println("duration2 = \(duration2)")
        
        let insertRes1 = compositionAudioTrack1.insertTimeRange(timeRange1, ofTrack: assetTrack1, atTime: kCMTimeZero, error: nil)
        
        println("insertRes = \(insertRes1)")
        
        if insertRes1 {
            let insertRes2 = compositionAudioTrack2.insertTimeRange(timeRange2, ofTrack: assetTrack2, atTime: duration1, error: nil)
            
            if insertRes2 {
                println("success")
                var assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
                assetExport.outputFileType = AVFileTypeAppleM4A
                assetExport.outputURL = fileDestinationUrl
                
                assetExport.exportAsynchronouslyWithCompletionHandler({
                    switch assetExport.status{
                    case  AVAssetExportSessionStatus.Failed:
                        println("failed \(assetExport.error)")
                    case AVAssetExportSessionStatus.Cancelled:
                        println("cancelled \(assetExport.error)")
                    case AVAssetExportSessionStatus.Completed:
                        println("complete")
                        
                        
                        if index == 0 {
                            
                            var fileURL3 = NSBundle.mainBundle().URLForResource(self.answerQ, withExtension: "m4a")
                            var fileURL4 = NSBundle.mainBundle().URLForResource(self.ansSelected, withExtension: "m4a")
                            
                            self.mergeTwoAudios(fileURL3!, audio2: fileURL4!, tempSound: self.tempAudio2, index: 1)
                            
                        }else if index == 1 {
                            
                            let filePath1 = documentDirectoryURL.URLByAppendingPathComponent(self.tempAudio1)
                            
                            let filePath2 = documentDirectoryURL.URLByAppendingPathComponent(self.tempAudio2)
                            
                            
                            self.mergeTwoAudios(filePath1, audio2: filePath2, tempSound: "resultmerge.caf", index: 2)
                            
                        }else if index == 2{
                            
                            var documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as! NSURL
                            
                            let audioPath = documentDirectoryURL.URLByAppendingPathComponent("resultmerge.caf")
                            
                            let videoPath = documentDirectoryURL.URLByAppendingPathComponent("export.mov")
                            
                            
                            println("Audio Path = \(audioPath)")
                            
                            self.createVideoWithImage(videoPath, audio: audioPath)
                            
                        }
                        
                        
                    default:
                        println("unknow error")
                    }
                })
            }
        }
    }
    
    func createVideoWithImage(video: NSURL, audio:  NSURL) {
        var tempPath = "video.mov"
        //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
        var mixComposition = AVMutableComposition()
        var compositionVideoTrack:AVMutableCompositionTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
        var compositionAudioTrack:AVMutableCompositionTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        //create new file to receive data
        var documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as! NSURL
        fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent(tempPath)
        println(fileDestinationUrl)
        
        // Clear old file.
        var dirs : [String] = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String])!
        var dir = dirs[0] //documents directory
        
        var path = dir.stringByAppendingPathComponent(tempPath)
        var pathURLarray:Array = (NSURL(fileURLWithPath: path)!).pathComponents!
        var pathURL:String = ""
        var final = ""
        var debut = ""
        
        for i in 1...(pathURLarray.count-1) {
            if i == pathURLarray.count-1 {
                final = ""
            } else {
                final = "/"
            }
            if i == 1 {
                debut = "/"
            } else {
                debut = ""
            }
            pathURL = debut + pathURL + (pathURLarray[i] as! String) + final
        }
        
        var checkValidation = NSFileManager.defaultManager()
        if checkValidation.fileExistsAtPath(pathURL) {
            println("file exist")
            if NSFileManager.defaultManager().removeItemAtURL(fileDestinationUrl, error: nil) {
                println("delete")
            }
        } else {
            println("no file")
        }
        
        // Do combine two files.
        let sourceAsset = AVURLAsset(URL: video, options: nil)
        let audioAsset = AVURLAsset(URL: audio, options: nil)
        
        let tracks = sourceAsset.tracksWithMediaType(AVMediaTypeVideo)
        let audios = audioAsset.tracksWithMediaType(AVMediaTypeAudio)
        
        println(tracks)
        println(audios)
        
        let assetTrack1:AVAssetTrack = tracks[0] as! AVAssetTrack
        let assetTrack2:AVAssetTrack = audios[0] as! AVAssetTrack
        
        var duration1: CMTime = assetTrack1.timeRange.duration
        var duration2: CMTime = assetTrack2.timeRange.duration
        
        var timeRange1 = CMTimeRangeMake(kCMTimeZero, duration1)
        var timeRange2 = CMTimeRangeMake(kCMTimeZero, duration2)
        
        
        let insertRes1 = compositionVideoTrack.insertTimeRange(timeRange1, ofTrack: assetTrack1, atTime: kCMTimeZero, error: nil)
        if insertRes1 {
            
            let insertRes2 = compositionAudioTrack.insertTimeRange(timeRange2, ofTrack: assetTrack2, atTime: kCMTimeZero, error: nil)
            
            if insertRes1 {
                println("success")
                
                var assetExport = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
                assetExport.outputFileType = AVFileTypeMPEG4
                assetExport.outputURL = fileDestinationUrl
                assetExport.exportAsynchronouslyWithCompletionHandler({
                    switch assetExport.status{
                    case  AVAssetExportSessionStatus.Failed:
                        println("failed \(assetExport.error)")
                    case AVAssetExportSessionStatus.Cancelled:
                        println("cancelled \(assetExport.error)")
                    default:
                        println("complete")
                        
                        let assetsLib = ALAssetsLibrary()
                        assetsLib.writeVideoAtPathToSavedPhotosAlbum(assetExport.outputURL, completionBlock: {(url: NSURL!, error: NSError!)  in
                            println("SAVED URL %@",url);
                            
                            if error != nil{
                                
                            }
                            
                            self.delay(1.0){
                                self.actionIndicator.hidesWhenStopped = true
                                self.actionIndicator.stopAnimating()
                                self.actionIndicator.hidden = true
                                
                                self.delay(1.0) {
                                    self.socialOption(url)
                                }
                            }
                        })
                    }
                })
            }
        }
    }
    
    func socialOption(url: NSURL) {
        var chooseDialog = UIAlertController(title: "Post to social network", message: "Choose your social network?",preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        chooseDialog.addAction(UIAlertAction(title: "Facebook", style: .Default, handler: { (action: UIAlertAction!) in
            
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                // 2
                var controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                // 3
                /*controller.setInitialText("Posting to Facebook by Hear Me Bros Apps")
                controller.addURL(url)
                self.presentViewController(controller, animated:true, completion:nil)*/
                
                var facebookAccount = ACAccount()
                let accountStore: ACAccountStore = ACAccountStore.alloc()
                
                let facebookAccountType: ACAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
                
                let accounts: NSArray = accountStore.accountsWithAccountType(facebookAccountType)
                facebookAccount = accounts.lastObject as! ACAccount
                
                let videoURL: NSURL = NSURL(string: "https://graph.facebook.com/me/videos")!
                let filePath: NSString = NSBundle().pathForResource(url.absoluteString, ofType: "mov")!
                let pathURL: NSURL = NSURL(fileURLWithPath: url.absoluteString!, isDirectory: false)!
                let videoData: NSData = NSData(contentsOfURL: url)!
                
                let dictionary = ["title": "Post by Hear Me Bros App", "description": "www.meesoft.co.th"]
                
                
                let uploadRequest = SLRequest(forServiceType:
                    SLServiceTypeFacebook,
                    requestMethod: SLRequestMethod.POST,
                    URL: videoURL,
                    parameters: dictionary)
                
                
                uploadRequest.addMultipartData(videoData, withName: "source", type: "video/quicktime", filename: pathURL.absoluteString)
                
                uploadRequest.account = facebookAccount
                
                uploadRequest.performRequestWithHandler({
                    (responseData: NSData!,
                    urlResponse: NSHTTPURLResponse!,
                    error: NSError!) -> Void in
                    
                    if let err = error {
                        println("Error : \(err.localizedDescription)")
                    }
                    println("Facebook HTTP response \(urlResponse.statusCode)")
                })
                
            }else {
                // 3
                let alertController = UIAlertController(title: "Alert", message:
                    "Sign to Facebook first!", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action: UIAlertAction!) in
                    self.topRightButton.enabled = true
                    self.resetState()
                }))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }))
        
        /*chooseDialog.addAction(UIAlertAction(title: "Twitter", style: .Default, handler: { (action: UIAlertAction!) in
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tweetSheet.setInitialText("Post by Hear Me Bros Apps")
        tweetSheet.addURL(url)
        
        self.resetState()
        
        self.presentViewController(tweetSheet, animated: true, completion: nil)
        } else {
        let alertController = UIAlertController(title: "Alert", message:
        "Sign to Twitter first!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        })))*/
        
        chooseDialog.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            self.topRightButton.enabled = true
            self.resetState()
        }))
        
        presentViewController(chooseDialog, animated: true, completion: nil)
        
        shareSuccessfuly()
    }
    
    func shareSuccessfuly() {
        
        var refreshAlert = UIAlertController(title: "Successfuly", message: "Shared to social!", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.resetState()
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
    func updateAnswerVisible() {
        
        if self.isUpdateVisible == false {
            random3Visible()
            self.isUpdateVisible = true
        }
        
        delay(1.0) {
            self.recordTime.text = "\(String(self.avalible.count)) people want to answer."
        }
        
        println("Is visible = \(self.avalible)")
        
        let buttonOn1 = self.avalible[0]
        let buttonOn2 = self.avalible[1]
        let buttonOn3 = self.avalible[2]
        
        var araryNum = self.avalible.count
        
        var numberOfLoop = (araryNum * 1000) + 7000
        
        println("numberOfLoop = \(numberOfLoop)")
        println("Length = \(araryNum)")
        
        self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1Off), forState: UIControlState.Normal)
        self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2Off), forState: UIControlState.Normal)
        self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3Off), forState: UIControlState.Normal)
        self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4Off), forState: UIControlState.Normal)
        self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5Off), forState: UIControlState.Normal)
        self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6Off), forState: UIControlState.Normal)
        self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7Off), forState: UIControlState.Normal)
        
        self.personButton1.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton1.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton1.layer.cornerRadius = 20.0;
        
        self.personButton2.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton2.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton2.layer.cornerRadius = 20.0;
        
        self.personButton3.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton3.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton3.layer.cornerRadius = 20.0;
        
        self.personButton4.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton4.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton4.layer.cornerRadius = 20.0;
        
        
        self.personButton5.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton5.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton5.layer.cornerRadius = 20.0;
        
        self.personButton6.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton6.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton6.layer.cornerRadius = 20.0;
        
        self.personButton7.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton7.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton7.layer.cornerRadius = 20.0;
        
        // update 1
        if buttonOn1 == 1 {
            
            self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
            self.buttonIsOn1 = true
            
        }else if buttonOn1 == 2 {
            self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
            self.buttonIsOn2 = true
            
        }else if buttonOn1 == 3 {
            self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
            self.buttonIsOn3 = true
            
        }else if buttonOn1 == 4 {
            self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
            self.buttonIsOn4 = true
            
        }else if buttonOn1 == 5 {
            self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
            self.buttonIsOn5 = true
            
        }else if buttonOn1 == 6 {
            self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
            self.buttonIsOn6 = true
            
        }else if buttonOn1 == 7 {
            self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
            self.buttonIsOn7 = true
        }
        
        // update 2
        if buttonOn2 == 1 {
            
            self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
            self.buttonIsOn1 = true
            
        }else if buttonOn2 == 2 {
            self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
            self.buttonIsOn2 = true
            
        }else if buttonOn2 == 3 {
            self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
            self.buttonIsOn3 = true
            
        }else if buttonOn2 == 4 {
            self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
            self.buttonIsOn4 = true
            
        }else if buttonOn2 == 5 {
            self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
            self.buttonIsOn5 = true
            
        }else if buttonOn2 == 6 {
            self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
            self.buttonIsOn6 = true
            
        }else if buttonOn2 == 7 {
            self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
            self.buttonIsOn7 = true
        }
        // update 3
        if buttonOn3 == 1 {
            
            self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
            self.buttonIsOn1 = true
            
        }else if buttonOn3 == 2 {
            self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
            self.buttonIsOn2 = true
            
        }else if buttonOn3 == 3 {
            self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
            self.buttonIsOn3 = true
            
        }else if buttonOn3 == 4 {
            self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
            self.buttonIsOn4 = true
            
        }else if buttonOn3 == 5 {
            self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
            self.buttonIsOn5 = true
            
        }else if buttonOn3 == 6 {
            self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
            self.buttonIsOn6 = true
            
        }else if buttonOn3 == 7 {
            self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
            self.buttonIsOn7 = true
        }
        
        if araryNum > 3 {
            
            for var i: Int = 3; i < araryNum + 1; i++ {
                
                if i == 4 {
                    let buttonOn4 = self.avalible[3]
                    
                    // update 4
                    if buttonOn4 == 1 {
                        
                        self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
                        self.buttonIsOn1 = true
                        
                    }else if buttonOn4 == 2 {
                        self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
                        self.buttonIsOn2 = true
                        
                    }else if buttonOn4 == 3 {
                        self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
                        self.buttonIsOn3 = true
                        
                    }else if buttonOn4 == 4 {
                        self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
                        self.buttonIsOn4 = true
                        
                    }else if buttonOn4 == 5 {
                        self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
                        self.buttonIsOn5 = true
                        
                    }else if buttonOn4 == 6 {
                        self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
                        self.buttonIsOn6 = true
                        
                    }else if buttonOn4 == 7 {
                        self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
                        self.buttonIsOn7 = true
                    }
                }
                
                if i == 5 {
                    let buttonOn5 = self.avalible[4]
                    
                    // update 5
                    if buttonOn5 == 1 {
                        
                        self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
                        self.buttonIsOn1 = true
                        
                    }else if buttonOn5 == 2 {
                        self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
                        self.buttonIsOn2 = true
                        
                    }else if buttonOn5 == 3 {
                        self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
                        self.buttonIsOn3 = true
                        
                    }else if buttonOn5 == 4 {
                        self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
                        self.buttonIsOn4 = true
                        
                    }else if buttonOn5 == 5 {
                        self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
                        self.buttonIsOn5 = true
                        
                    }else if buttonOn5 == 6 {
                        self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
                        self.buttonIsOn6 = true
                        
                    }else if buttonOn5 == 7 {
                        self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
                        self.buttonIsOn7 = true
                    }
                }
                
                if i == 6 {
                    let buttonOn6 = self.avalible[5]
                    
                    // update 6
                    if buttonOn6 == 1 {
                        
                        self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
                        self.buttonIsOn1 = true
                        
                    }else if buttonOn6 == 2 {
                        self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
                        self.buttonIsOn2 = true
                        
                    }else if buttonOn6 == 3 {
                        self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
                        self.buttonIsOn3 = true
                        
                    }else if buttonOn6 == 4 {
                        self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
                        self.buttonIsOn4 = true
                        
                    }else if buttonOn6 == 5 {
                        self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
                        self.buttonIsOn5 = true
                        
                    }else if buttonOn6 == 6 {
                        self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
                        self.buttonIsOn6 = true
                        
                    }else if buttonOn6 == 7 {
                        self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
                        self.buttonIsOn7 = true
                    }
                }
                
                if i == 7 {
                    let buttonOn7 = self.avalible[6]
                    
                    // update 7
                    if buttonOn7 == 1 {
                        
                        self.personButton1.setImage(UIImage(named: AppConfiguration.imagePath.ans1On), forState: UIControlState.Normal)
                        self.buttonIsOn1 = true
                        
                    }else if buttonOn7 == 2 {
                        self.personButton2.setImage(UIImage(named: AppConfiguration.imagePath.ans2On), forState: UIControlState.Normal)
                        self.buttonIsOn2 = true
                        
                    }else if buttonOn7 == 3 {
                        self.personButton3.setImage(UIImage(named: AppConfiguration.imagePath.ans3On), forState: UIControlState.Normal)
                        self.buttonIsOn3 = true
                        
                    }else if buttonOn7 == 4 {
                        self.personButton4.setImage(UIImage(named: AppConfiguration.imagePath.ans4On), forState: UIControlState.Normal)
                        self.buttonIsOn4 = true
                        
                    }else if buttonOn7 == 5 {
                        self.personButton5.setImage(UIImage(named: AppConfiguration.imagePath.ans5On), forState: UIControlState.Normal)
                        self.buttonIsOn5 = true
                        
                    }else if buttonOn7 == 6 {
                        self.personButton6.setImage(UIImage(named: AppConfiguration.imagePath.ans6On), forState: UIControlState.Normal)
                        self.buttonIsOn6 = true
                        
                    }else if buttonOn7 == 7 {
                        self.personButton7.setImage(UIImage(named: AppConfiguration.imagePath.ans7On), forState: UIControlState.Normal)
                        self.buttonIsOn7 = true
                    }
                }
            }
        }
    }
    
    func random3Visible() {
        
        var index1: Int = 0
        var index2: Int = 0
        var index3: Int = 0
        
        var n = 2
        while n > 1 {
            
            let randomVisible = randomIndex(7, end:1)
            
            println("Random is \(randomVisible)")
            if index1 == 0 {
                index1 = randomVisible
                println("index1 = \(index1) and \(randomVisible)")
                
            }else if index2 == 0 && randomVisible != index1 {
                index2 = randomVisible
                println("index2 = \(index2) and \(randomVisible)")
                
            }else if index3 == 0 && randomVisible != index1 && randomVisible != index2 {
                index3 = randomVisible
                println("index3 = \(index3) and \(randomVisible)")
                n = 0
            }
        }
        
        if index1 != 0 && index2 != 0 && index3 != 0 {
            self.avalible.append(index1)
            self.avalible.append(index2)
            self.avalible.append(index3)
        }
        
        println("Array is = \(self.avalible)")
    }
    
    
    
    func random7Answer() {
        
        var index1: Int = 0
        var index2: Int = 0
        var index3: Int = 0
        
        var index4: Int = 0
        var index5: Int = 0
        var index6: Int = 0
        var index7: Int = 0
        
        for var i = 0; i < 7; i++ {
            
            let randomAnswer = randomIndex(8, end:1)
            
            self.answerArray.append(randomAnswer)
        }
        
        println("random7Answer is = \(self.answerArray)")
    }
    
    
    func openAds() {
        
        UnityAds.sharedInstance().setViewController(self)
        UnityAds.sharedInstance().setZone("rewardedVideoZone")
        
        if UnityAds.sharedInstance().canShowAds(){
            var refreshAlert = UIAlertController(title: "Unlock person", message: "Watch ads for unlock person?", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                
                UnityAds.sharedInstance().show()
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            
            self.presentViewController(refreshAlert, animated: true, completion: nil)
        }else {
            var refreshAlert = UIAlertController(title: "Not avalible", message: "This person not avalible!", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.presentViewController(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func unityAdsVideoCompleted(rewardItemKey: String, skipped: Bool) -> Void{
        if !skipped {
            
            self.avalible.append(self.buttonIndexSelected)
            
            if self.buttonIndexSelected == 1 {
                self.changeColor(self.personButton1)
                self.buttonIsOn1 = true
                
            }else if self.buttonIndexSelected == 2 {
                self.changeColor(self.personButton2)
                self.buttonIsOn2 = true
                
            }else if self.buttonIndexSelected == 3 {
                self.changeColor(self.personButton3)
                self.buttonIsOn3 = true
                
            }else if self.buttonIndexSelected == 4 {
                self.changeColor(self.personButton4)
                self.buttonIsOn4 = true
                
            }else if self.buttonIndexSelected == 5 {
                self.changeColor(self.personButton5)
                self.buttonIsOn5 = true
                
            }else if self.buttonIndexSelected == 6 {
                self.changeColor(self.personButton6)
                self.buttonIsOn6 = true
                
            }else if self.buttonIndexSelected == 7 {
                self.changeColor(self.personButton7)
                self.buttonIsOn7 = true
            }
            
            delay(1.0) {
                self.recordTime.text = "\(String(self.avalible.count)) people want to answer."
                
                self.answer(self.buttonIndexSelected)
            }
        }
    }
    
    
    func resetState() {
        
        self.actionIndicator.stopAnimating()
        self.actionIndicator.hidden = true
        self.isAskOn = true
        self.isPreview = false
        self.questionSound = false
        self.answerSound = false
        self.recordSound = false
        self.isShare = false
        
        self.ansSelected = ""
        self.imageSelected = ""
        self.yourRecordSound = "recorder.m4a"
        self.fileDestinationUrl = NSURL()
        self.avalible = [Int]()
        self.buttonIndexSelected = 0
        
        self.buttonIsOn1 = false
        self.buttonIsOn2 = false
        self.buttonIsOn3 = false
        self.buttonIsOn4 = false
        self.buttonIsOn5 = false
        
        self.buttonIsOn6 = false
        self.buttonIsOn7 = false
        
        self.path = ""
        self.imagePath = ""
        
        self.isSeleccted = 0
        
        
        self.acctionButton.enabled = true
        
        UnityAds.sharedInstance().delegate = self
        UnityAds.sharedInstance().startWithGameId("57599")
        
        self.statusLabel.text = "Ask them"
        self.recordTime.text = ""
        self.acctionButton.setTitle("Ask", forState: .Normal)
        self.isAskOn = true
        self.acctionButton.backgroundColor = UIColor.blueColor()
        self.acctionButton.enabled = true
        self.topRightButton.hidden = true
        
        self.personButton1.backgroundColor = UIColor.whiteColor()
        self.personButton1.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton1.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton1.layer.cornerRadius = 20.0;
        
        self.personButton2.backgroundColor = UIColor.whiteColor()
        self.personButton2.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton2.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton2.layer.cornerRadius = 20.0;
        
        self.personButton3.backgroundColor = UIColor.whiteColor()
        self.personButton3.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton3.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton3.layer.cornerRadius = 20.0;
        
        self.personButton4.backgroundColor = UIColor.whiteColor()
        self.personButton4.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton4.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton4.layer.cornerRadius = 20.0;
        
        
        self.personButton5.backgroundColor = UIColor.whiteColor()
        self.personButton5.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton5.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton5.layer.cornerRadius = 20.0;
        
        self.personButton6.backgroundColor = UIColor.whiteColor()
        self.personButton6.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton6.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton6.layer.cornerRadius = 20.0;
        
        self.personButton7.backgroundColor = UIColor.whiteColor()
        self.personButton7.layer.borderColor = UIColor.clearColor().CGColor
        self.personButton7.layer.borderWidth = 2.5
        // Set image corner radius
        self.personButton7.layer.cornerRadius = 20.0;
        
        self.personButton1.enabled = true
        self.personButton2.enabled = true
        self.personButton3.enabled = true
        self.personButton4.enabled = true
        
        self.personButton5.enabled = true
        self.personButton6.enabled = true
        self.personButton7.enabled = true
        
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if self.mode == "REC" {
            self.acctionButton.enabled = true
            self.mode = ""
            println("Start rec")
            self.soundRecorder.record()
        }else if self.mode == "ANS" {
            println("Enable Top Button")
            self.topRightButton.hidden = false
            self.topRightButton.enabled = true
            self.mode = ""
        }else if self.mode == "STOP" {
            delay(1.0){
                self.sucessRecord()
            }
        }
        
        self.mode = ""
    }
    
    
    // Dev test
    @IBAction func devTest(sender: UIButton) {
        
        delay(1.0) {
            
            self.audioPlayer(self.quetion)
            sleep(2)
            
            self.recordPlayer()
            sleep(5)
            
            self.audioPlayer(self.answerQ)
            sleep(2)
            
            self.audioPlayer(self.ansSelected)
            
        }
    }
}
