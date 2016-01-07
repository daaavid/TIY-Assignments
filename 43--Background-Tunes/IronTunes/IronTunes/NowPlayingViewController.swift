//
//  ViewController.swift
//  IronTunes
//
//  Created by Ben Gohlke on 9/14/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class NowPlayingViewController: UIViewController
{
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumArtwork: UIImageView!
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let avQueuePlayer = AVQueuePlayer()
    var songs = Array<Song>()
    var currentSong: Song?
    var nowPlaying: Bool = false
    
    var audioTimer: NSTimer!
    
    lazy var controlCenter = MPNowPlayingInfoCenter()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupAudioSession()
        configurePlaylist()
        loadCurrentSong()

        avQueuePlayer
            .addObserver(self, forKeyPath: "currentItem", options: [.New, .Initial], context: nil)
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    // MARK: - Action handlers
    
    @IBAction func playPauseTapped(sender: UIButton)
    {
        togglePlayback(!nowPlaying)
    }
    
    @IBAction func skipForwardTapped(sender: UIButton)
    {
        skipForward()
    }
    
    @IBAction func skipBackTapped(sender: UIButton)
    {
        skipBack()
    }
    
    // MARK: - Private methods
    
    func skipForward()
    {
        let currentSongIndex = (songs as NSArray).indexOfObject(currentSong!)
        let nextSong: Int
        
        if currentSongIndex + 1 >= songs.count
        {
            nextSong = 0
        }
        else
        {
            nextSong = currentSongIndex + 1
        }
        currentSong = songs[nextSong]
        loadCurrentSong()
        togglePlayback(true)
    }
    
    func skipBack()
    {
        avQueuePlayer.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
        if !nowPlaying
        {
            togglePlayback(true)
        }
    }
    
    func configurePlaylist()
    {
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", filename: "happiness", albumArtwork: "Acoustic")
        songs.append(acoustic)
        currentSong = acoustic
        
        let dubstep = Song(title: "Dubstep", artist: "Benjamin Tissot", filename: "dubstep", albumArtwork: "Dubstep")
        songs.append(dubstep)
        
        let hiphop = Song(title: "Groovy Hip Hop", artist: "Benjamin Tissot", filename: "groovyhiphop", albumArtwork: "HipHop")
        songs.append(hiphop)
        
        let rock = Song(title: "Actionable", artist: "Benjamin Tissot", filename: "actionable", albumArtwork: "Rock")
        songs.append(rock)
        
        let funk = Song(title: "Funky Suspense", artist: "Benjamin Tissot", filename: "funkysuspense", albumArtwork: "Funk")
        songs.append(funk)
    }
    
    func loadCurrentSong()
    {
        avQueuePlayer.removeAllItems()
        if let song = currentSong
        {
            song.playerItem.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
            avQueuePlayer.insertItem(song.playerItem, afterItem: nil)
            songTitleLabel.text = song.title
            artistLabel.text = song.artist
            albumArtwork.image = UIImage(named: song.albumArtworkName)
            
            configureNowPlayingInfo(nil, songDuration: nil)
        }
    }
    
    func setupAudioSession()
    {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted
            {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch _ {
                }
            }
            else
            {
                print("Audio session could not be configured; user denied permission.")
            }
        })
    }
    
    func togglePlayback(play: Bool)
    {
        nowPlaying = play
        if play
        {
            playPauseButton.setImage(UIImage(named: "Pause"), forState: UIControlState.Normal)
            avQueuePlayer.play()
        }
        else
        {
            playPauseButton.setImage(UIImage(named: "Play"), forState: UIControlState.Normal)
            avQueuePlayer.pause()
        }
    }
    
    // MARK: - New
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        if keyPath == "currentItem", let player = object as? AVPlayer, currentItem = player.currentItem?.asset as? AVURLAsset
        {
            let interval = CMTimeMake(1, 100)
            let mainQueue = dispatch_get_main_queue()
            player.addPeriodicTimeObserverForInterval(interval, queue: mainQueue) {
                [unowned self] time in
                //without unowned self closure would still exist and memory would leak. creating a weak reference instead of a strong one
                //self own closure and closure owns self
                let seconds = CMTimeGetSeconds(time)
                let duration = CMTimeGetSeconds(currentItem.duration)
                
                let progress = Float(seconds / duration)
                self.progressBar.setProgress(progress, animated: false)
                
                let infoCenterProgress = NSNumber(double: seconds)
                let infoCenterDuration = NSNumber(double: CMTimeGetSeconds(currentItem.duration))
                
                self.configureNowPlayingInfo(infoCenterProgress, songDuration: infoCenterDuration)
                
                /*
                let timeString = String(format: "%02.2f", seconds)
                print(progress, seconds, duration)

                if UIApplication.sharedApplication().applicationState == .Active
                {
                    if progress % 2 == 0
                    {
                        print("Foreground: \(timeString)")
                    }
                }
                else
                {
                    if progress % 2 == 0
                    {
                        let timeRemaining = UIApplication.sharedApplication().backgroundTimeRemaining
                
                        print("Background: \(timeString), time remaining: \(timeRemaining)")
                    }
                }
                */
            }
        }
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent?)
    {
        print("received remote event main")
        
        if event?.type == .RemoteControl
        {
//            let mpCenter = MPRemoteCommandCenter.sharedCommandCenter()
            
            //weirdo error when trying to do this as a switch-case
            if event?.subtype == .RemoteControlPlay
            {
                togglePlayback(!nowPlaying)
            }
            else if event?.subtype == .RemoteControlPause
            {
                togglePlayback(!nowPlaying)
            }
            else if event?.subtype == .RemoteControlNextTrack
            {
                skipForward()
            }
            else if event?.subtype == .RemoteControlPreviousTrack
            {
                skipBack()
            }
        }
    }
    
    func configureNowPlayingInfo(elapsedTime: NSNumber?, songDuration: NSNumber?)
    {
        print("configure now playing info")
        
        let infoCenter = MPNowPlayingInfoCenter.defaultCenter()
        
        var newInfo = [
            MPMediaItemPropertyArtist : currentSong!.artist,
            MPMediaItemPropertyTitle : currentSong!.title,
            MPNowPlayingInfoPropertyElapsedPlaybackTime : NSNumber(integer: 0),
            MPNowPlayingInfoPropertyDefaultPlaybackRate : NSNumber(integer: 1),
            MPMediaItemPropertyPlaybackDuration : NSNumber(integer: 0)
        ]
        
        if elapsedTime != nil && songDuration != nil
        {
            newInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = elapsedTime
            newInfo[MPMediaItemPropertyPlaybackDuration] = songDuration
        }
        
        infoCenter.nowPlayingInfo = newInfo
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}