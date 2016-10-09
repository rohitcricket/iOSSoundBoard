//
//  SoundViewController.swift
//  Sound Board
//
//  Created by ROHIT GUPTA on 10/7/16.
//  Copyright © 2016 ROHIT GUPTA. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRecorder()
        playButton.isEnabled = false
        
    }
    
    func setupRecorder(){
        // create audio session
        do {
        
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.overrideOutputAudioPort(.speaker)
        try session.setActive(true)
        
        // create url for audio file
        
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
        
        // settings for audioRecorder
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
        
        
        // create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: AnyObject) {
        
        if audioRecorder!.isRecording{
            // stop the recording
            audioRecorder?.stop()
            
            // change button title to record
            recordButton.setTitle("Record", for: .normal)
            
            playButton.isEnabled = true
            
        } else {
            // start recording
            audioRecorder?.record()
            
            // change button title to stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    
    @IBAction func playTapped(_ sender: AnyObject) {
        
        do {
        
        try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
            
        } catch {
            
        }
    }
    
    

    @IBAction func addTapped(_ sender: AnyObject) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sound = Sound(context: context)

    }
    
    
}
