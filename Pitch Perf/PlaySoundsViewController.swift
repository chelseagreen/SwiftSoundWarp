//
//  PlaySoundsViewController.swift
//  Pitch Perf
//
//  Created by Chelsea Green on 12/12/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recievedAudio.filePathUrl)
    }
    
    @IBAction func PlaySlowSound(sender: UIButton) {
        stopPlayer()
        audioPlayer.rate = 0.35
        audioPlayer.play()
    }
    
    @IBAction func PlayFastSound(sender: UIButton) {
        stopPlayer()
        audioPlayer.rate = 3.5
        audioPlayer.play()
    }
    
    @IBAction func PlayChippyAudio(sender: UIButton) {
        playAudioWithVariablePitch(1500)
    }
    
    @IBAction func PlayDarthAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopPlayer()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func stopPlayer(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func StopPlaying(sender: UIButton) {
        stopPlayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
