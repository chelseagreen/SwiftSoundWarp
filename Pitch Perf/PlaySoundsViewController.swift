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
        // Do any additional setup after loading the view.
        // if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
        //   let filePathUrl = NSURL.fileURLWithPath(filePath)
        // audioPlayer = try!
        //   AVAudioPlayer(contentsOfURL: filePathUrl)
        // audioPlayer.enableRate = true
        // }else {
        //   print("The filePath is empty")
        //}
        audioPlayer = try! AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recievedAudio.filePathUrl)
    }
    
    @IBAction func PlaySlowSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.09
        audioPlayer.play()
    }
    
    @IBAction func PlayFastSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 6.0
        audioPlayer.play()
    }
    
    @IBAction func PlayChippyAudio(sender: UIButton) {
        playAudioWithVariablePitch(2000)
    }
    
    
    @IBAction func PlayDarthAudio(sender: UIButton) {
        playAudioWithVariablePitch(-400)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    
    @IBAction func StopPlaying(sender: UIButton) {
        audioPlayer.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
