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
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRecorder()
        
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
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
        
        // settings for audioRecorder
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
        
        
        // create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
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
            
        } else {
            // start recording
            audioRecorder?.record()
            
            // change button title to stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    
    @IBAction func playTapped(_ sender: AnyObject) {
    }
    
    

    @IBAction func addTapped(_ sender: AnyObject) {
    }
    
    
}
