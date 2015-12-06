//
//  TypewriterClack.swift
//  Philosophone
//
//  Created by david on 12/5/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import AVFoundation

class TypewriterClack
{
    func playSound()
    {
        if GLOBAL_SETTINGS?.sound == true
        {
            if let soundURL = NSBundle.mainBundle().URLForResource("typewriter", withExtension: "wav") {
                var mySound: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL, &mySound)
                AudioServicesPlaySystemSound(mySound);
            }
        }
    }
}