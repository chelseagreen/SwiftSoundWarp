//
//  RecordedAudio.swift
//  Pitch Perf
//
//  Created by Chelsea Green on 12/12/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}