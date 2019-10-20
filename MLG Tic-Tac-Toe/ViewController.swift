//
//  ViewController.swift
//  MLG Tic-Tac-Toe
//
//  Created by Mitchell Ryzuk on 5/23/16.
//  Copyright © 2016 Mitchell Ryzuk. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var menuSong:AVAudioPlayer! //Variable for the song that plays while in the main menu
    
    //My two animated gif images on the main menu
    @IBOutlet weak var snoopOne: UIImageView!
    @IBOutlet weak var snoopTwo: UIImageView!
    
    //Actions for the 'Player 1' and 'Player 2' buttons
    
    @IBAction func playerOne(sender: AnyObject) {
        menuSong.stop() //Stop the song
    }
    
    @IBAction func playerTwo(sender: AnyObject) {
        menuSong.stop() //Stop the song
        
    }
   
    //Function to send a value to the Game storyboard when one of the buttons are pressed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        //If the player 1 button was pressed, make the "playerOrComputer" variable in the 'Game' class 1
        if (segue.identifier == "playerOne") {
            let destination = segue.destinationViewController as! Game
            destination.playerOrComputer = 1
            
        }
        
        //If the player 2 button was pressed, make the "playerOrComputer" variable in the 'Game' class 2
        if (segue.identifier == "playerTwo") {
            let destination = segue.destinationViewController as! Game
            destination.playerOrComputer = 2
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*THIS WILL EXECUTE ON STARTUP OF THE PROGRAM*/
        
        //An array with all of the individual frames for my gif image
        let imageNames = ["snoop0.gif","snoop1.gif","snoop2.gif","snoop3.gif","snoop4.gif",
                          "snoop5.gif","snoop6.gif","snoop7.gif","snoop8.gif","snoop9.gif",
                          "snoop10.gif","snoop11.gif","snoop12.gif","snoop13.gif","snoop14.gif",
                          "snoop15.gif","snoop16.gif","snoop17.gif","snoop18.gif","snoop19.gif",
                          "snoop20.gif","snoop21.gif","snoop22.gif","snoop23.gif","snoop24.gif",
                          "snoop25.gif","snoop26.gif","snoop27.gif","snoop28.gif","snoop29.gif",
                          "snoop30.gif","snoop31.gif","snoop32.gif","snoop33.gif","snoop34.gif",
                          "snoop35.gif","snoop36.gif","snoop37.gif","snoop38.gif","snoop39.gif",
                          "snoop40.gif","snoop41.gif","snoop42.gif","snoop43.gif","snoop44.gif",
                          "snoop45.gif","snoop46.gif","snoop47.gif","snoop48.gif","snoop49.gif",
                          "snoop50.gif","snoop51.gif","snoop52.gif","snoop53.gif","snoop54.gif",
                          "snoop55.gif","snoop56.gif","snoop57.gif"]
        //Another array that will contain images
        var images = [UIImage]()
        
        //Loop to initialize each value in that array
       for i in 0..<imageNames.count {
            images.append(UIImage(named: imageNames[i])!)
        }
        //Making the two gifs animated
        snoopOne.animationImages = images
        snoopTwo.animationImages = images
        //Setting the lengths for both gifs to last 2 seconds
        snoopOne.animationDuration = 2.0
        snoopTwo.animationDuration = 2.0
        //Start animating the two gifs
        snoopOne.startAnimating()
        snoopTwo.startAnimating()
        
        //Playing the menu song
        let soundURL: NSURL = NSBundle.mainBundle().URLForResource("menusong", withExtension: "mp3")!
        menuSong = try! AVAudioPlayer(contentsOfURL: soundURL)
        menuSong.numberOfLoops = -1 //This line of code allows for the song to loop forever until it's stopped by a 'menuSong.stop()' command
        menuSong.play()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

