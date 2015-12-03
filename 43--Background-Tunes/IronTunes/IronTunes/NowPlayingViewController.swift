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
        
//        controlCenter.nowPlayingInfo = ["]
    }
    
    // MARK: - Action handlers
    
    @IBAction func playPauseTapped(sender: UIButton)
    {
        togglePlayback(!nowPlaying)
    }
    
    @IBAction func skipForwardTapped(sender: UIButton)
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
    
    @IBAction func skipBackTapped(sender: UIButton)
    {
        avQueuePlayer.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
        if !nowPlaying
        {
            togglePlayback(true)
        }
    }
    
    // MARK: - Private methods
    
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
                
                let timeString = String(format: "%02.2f", seconds)
                
                print(seconds, duration)
                
                let progress = Float(seconds / duration)
                self.progressBar.setProgress(progress, animated: false)
                print(progress)
                
                if UIApplication.sharedApplication().applicationState == .Active
                {
                    print("Foreground: \(timeString)")
                }
                else
                {
                    let timeRemaining = UIApplication.sharedApplication().backgroundTimeRemaining
                
                    print("Background: \(timeString), time remaining: \(timeRemaining)")
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}