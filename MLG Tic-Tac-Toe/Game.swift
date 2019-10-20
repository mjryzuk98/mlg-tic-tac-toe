//
//  Game.swift
//  MLG Tic-Tac-Toe
//
//  Created by Mitchell Ryzuk on 5/24/16.
//  Copyright © 2016 Mitchell Ryzuk. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


class Game: UIViewController {
    
    var audioPlayer = AVAudioPlayer() //audio player
    var player = 1 //current player
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] //array of populated boxes
    var takenSpots = [0, 0, 0, 0, 0, 0, 0, 0, 0] //array of whether or not the spot is taken
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]] //the combinations needed to win
    var winner = 0 //the value of the winner. will either be 0 for no winner, 1 for player 1, and 2 for player 2
    var playerOrComputer:Int! //Variable determining whether or not it is a 1 or 2 player game (1 is for 1 player, 2 is for 2 player)
    
    
    //Delarations for the various sounds that will play in the game
    var hitmarker:AVAudioPlayer!
    var oh:AVAudioPlayer!
    var wow:AVAudioPlayer!
    var sadViolin:AVAudioPlayer!
    var getNoScoped:AVAudioPlayer!
    var airhorn:AVAudioPlayer!
    var loserMusic:AVAudioPlayer!
    
    
    @IBOutlet weak var topLabel: UILabel! //Label on the top of the screen
    
    //images that represent x's and o's
    @IBOutlet weak var boxOne: UIImageView!
    @IBOutlet weak var boxTwo: UIImageView!
    @IBOutlet weak var boxThree: UIImageView!
    @IBOutlet weak var boxFour: UIImageView!
    @IBOutlet weak var boxFive: UIImageView!
    @IBOutlet weak var boxSix: UIImageView!
    @IBOutlet weak var boxSeven: UIImageView!
    @IBOutlet weak var boxEight: UIImageView!
    @IBOutlet weak var boxNine: UIImageView!
    
    //buttons that are in front of each image
    @IBOutlet weak var but1: UIButton!
    @IBOutlet weak var but2: UIButton!
    @IBOutlet weak var but3: UIButton!
    @IBOutlet weak var but4: UIButton!
    @IBOutlet weak var but5: UIButton!
    @IBOutlet weak var but6: UIButton!
    @IBOutlet weak var but7: UIButton!
    @IBOutlet weak var but8: UIButton!
    @IBOutlet weak var but9: UIButton!
    
    //when the back button is pressed
    @IBAction func backButton(sender: AnyObject) {
        
        //Making an alert to warn the user that they are quitting
        
        //Creating the popup that will appear when the button is pressed
        let backAlert = UIAlertController(title: "Quit", message: "Are you sure you want to quit?", preferredStyle: UIAlertControllerStyle.Alert)
        //Creating the yes and no buttons that will be in the alert
        let yesButton = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            //If Yes is pressed, perform the segue back to the main menu view controller
            
            self.topLabel.text = "Quitting..." //Telling the user that the game is quitting
            
            //Creating a 2 second delay for the code to execute (This is to ensure all of the sounds have started if it's the end of the game)
            let back = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
            dispatch_after(back, dispatch_get_main_queue()) {
            
                //If there is a winner, stop playing all these sounds
                if self.winner > 0 {
                    
                    //Only stop this sound if player 2 won and they're playing against the computer
                    if self.playerOrComputer == 1 && self.winner == 2 {
                        self.sadViolin.stop()
                    
                    }
                    
                    //Stop these sounds if the previous case wasn't met
                    else {
                        self.oh.stop()
                        self.wow.stop()
                        self.getNoScoped.stop()
                        self.airhorn.stop()
                    }
                }
                
                if  self.gameState[0] > 0 &&
                    self.gameState[1] > 0 &&
                    self.gameState[2] > 0 &&
                    self.gameState[3] > 0 &&
                    self.gameState[4] > 0 &&
                    self.gameState[5] > 0 &&
                    self.gameState[6] > 0 &&
                    self.gameState[7] > 0 &&
                    self.gameState[8] > 0 {
                    if self.winner == 0 {
                        self.loserMusic.stop()
                    }
                }
                
                //Perform the segue back to the main menu
                self.performSegueWithIdentifier("Game", sender: nil)
            }
        }
        
        //It will go back to the game if no is pressed
        let noButton = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) {
            UIAlertAction in
        }
        //Adding the buttons to the alert
        backAlert.addAction(yesButton)
        backAlert.addAction(noButton)
        //Making the alert appear on screen
        presentViewController(backAlert, animated: true, completion: nil)
        
    }
    
    //reset button outlet
    @IBOutlet weak var reset: UIButton!

    
    
    //function for when the reset button is pressed
    @IBAction func resetButton(sender: AnyObject) {
       
            
            
            self.reset.hidden = true //Hide the reset button
        
            topLabel.text = "Resetting..." //Telling the user that the game is resetting
        
            //Creating a 2 second delay (This is to ensure all of the sounds have started playing before executing)
            let reset = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
            dispatch_after(reset, dispatch_get_main_queue()) {
        
            //Only stop this sound if the user is playing against the computer and the computer won
            if self.playerOrComputer == 1 && self.winner == 2 {
                self.sadViolin.stop()
            }
                //Only stop this sound if there was no winner
            else if self.winner == 0 {
                self.loserMusic.stop()
            }
                //Stop all these sounds if the previous case wasn't met
            else {
                self.oh.stop()
                self.wow.stop()
                self.getNoScoped.stop()
                self.airhorn.stop()
            }
            
            
            //Remove all of the images
            self.boxOne.image = nil
            self.boxTwo.image = nil
            self.boxThree.image = nil
            self.boxFour.image = nil
            self.boxFive.image = nil
            self.boxSix.image = nil
            self.boxSeven.image = nil
            self.boxEight.image = nil
            self.boxNine.image = nil
            
            //Making all of the buttons functional again
            self.but1.hidden = false
            self.but2.hidden = false
            self.but3.hidden = false
            self.but4.hidden = false
            self.but5.hidden = false
            self.but6.hidden = false
            self.but7.hidden = false
            self.but8.hidden = false
            self.but9.hidden = false
    
            self.gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] //Set all the boxes back to 0
            self.takenSpots = [0, 0, 0, 0, 0, 0, 0, 0, 0] //Set all the boxes back to 0
            self.winner = 0 //Changing the winner back to 0
            self.player = 1 //Make player 1 the first player to go
            self.topLabel.text = "Player 1 go ahead m8" //Changing the label so player 1 can go
        
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //This will execute if the user is playing against the AI (1 player mode)
        if playerOrComputer == 1 {
            //Creating the alert that will pop up on screen
            let alert = UIAlertController(title: "Reminder", message: "The AI is made to be very dumb so you'll probably win.", preferredStyle:     UIAlertControllerStyle.Alert)
            //Creating the button to close out the menu and to start playing the game
            let closeButton = UIAlertAction(title: "Close", style: UIAlertActionStyle.Default) {
                UIAlertAction in
            }
                //Putting the button into the alert menu
                alert.addAction(closeButton)
                //Making the alert appear on screen
                presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function for when the button is pressed
    @IBAction func buttonPressed(sender: UIButton) {
        
        //If the spot is taken, the label will tell the user to pick a new spot
        if takenSpots[sender.tag] != 0 {
            topLabel.text = "m8 you can't take that spot"
        }
        
        //Tell the user to wait while the AI is choosing their spot
        if playerOrComputer == 1 && player == 2 {
            topLabel.text = "WAIT YOUR TURN M420"
        }
        
        //Executes when the previous if statement wasn't met
        else {
            
        //If the spot isn't populated and there's no winner, go on
        if takenSpots[sender.tag] == 0 && winner == 0 {
            
            //Playing the hitmarker sound everytime the button is pressed
            let soundURL: NSURL = NSBundle.mainBundle().URLForResource("hitmarker", withExtension: "mp3")!
            hitmarker = try! AVAudioPlayer(contentsOfURL: soundURL)
            hitmarker.play()

            var image = UIImage() //Creating a variable for an image that will either be x or o
            //Will execute if it's player 1
            if player == 1 {
                image = UIImage(named: "x")! //Making the image equal to the x image I have
                gameState[sender.tag] = 1 //Make the gameState equal 1
                
                //If statements for the different sender tag possibilities so the image corresponding to that spot will display the right image
                if sender.tag == 0 {
                    boxOne.image = image
                }
                if sender.tag == 1 {
                    boxTwo.image = image
                }
                if sender.tag == 2 {
                    boxThree.image = image
                }
                if sender.tag == 3 {
                    boxFour.image = image
                }
                if sender.tag == 4 {
                    boxFive.image = image
                }
                if sender.tag == 5 {
                    boxSix.image = image
                }
                if sender.tag == 6 {
                    boxSeven.image = image
                }
                if sender.tag == 7 {
                    boxEight.image = image
                }
                if sender.tag == 8 {
                    boxNine.image = image
                }
                player = 2 //Making the player equal to 2
                takenSpots[sender.tag] = 1 //Making one of the spots taken
                
                //Different if statements based on whether or not it's a 1 or 2 player game
                
                if playerOrComputer == 1 {
                    topLabel.text = "AI is blazing up a choice..."
                    //Creating a 2 second delay to make the user believe that the computer is actually thinking about their choice
                    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        //Only execute if there is no winner
                        if self.winner == 0 && self.reset.hidden == true {
                            //Execute the function that allows the AI to choose their spot
                            self.aiDecide()
                        }
                    }
                }
                if playerOrComputer == 2 {
                    topLabel.text = "Player 2 go ahead m8" //Changing the label
                }
                
            }
        
            //For when the player is 2
            else {
                image = UIImage(named: "o")! //Making the image equal to the o image I have
                gameState[sender.tag] = 2 //Making the gameState equal to 2
                
                //If statements for the different sender tag possibilities so the image corresponding to that spot will display the right image
                if sender.tag == 0 {
                    boxOne.image = image
                }
                if sender.tag == 1 {
                    boxTwo.image = image
                }
                if sender.tag == 2 {
                    boxThree.image = image
                }
                if sender.tag == 3 {
                    boxFour.image = image
                }
                if sender.tag == 4 {
                    boxFive.image = image
                }
                if sender.tag == 5 {
                    boxSix.image = image
                }
                if sender.tag == 6 {
                    boxSeven.image = image
                }
                if sender.tag == 7 {
                    boxEight.image = image
                }
                if sender.tag == 8 {
                    boxNine.image = image
                }
                player = 1 //Making the player equal to 1
                takenSpots[sender.tag] = 1 //Making one of the spots taken
                topLabel.text = "Player 1 go ahead m8" //Changing the label

            }
        }
        
        
            
            //For loop for testing the winner
            for index in 1...2 {
                //A huge if statement to test if there is a winner
                if  (gameState[0] == index && gameState[1] == index && gameState[2] == index) ||
                    (gameState[3] == index && gameState[4] == index && gameState[5] == index) ||
                    (gameState[6] == index && gameState[7] == index && gameState[8] == index) ||
                    (gameState[0] == index && gameState[3] == index && gameState[6] == index) ||
                    (gameState[1] == index && gameState[4] == index && gameState[7] == index) ||
                    (gameState[2] == index && gameState[5] == index && gameState[8] == index) ||
                    (gameState[0] == index && gameState[4] == index && gameState[8] == index) ||
                    (gameState[2] == index && gameState[4] == index && gameState[6] == index) {
                    winner = index //If one of these conditions apply, make the winner equal to the index of the loop
                }
            }
            
            //Testing if there is no winner
            if winner == 0 {
                //Testing if all of the boxes are populated to determine if there is no winner
                if  gameState[0] > 0 &&
                    gameState[1] > 0 &&
                    gameState[2] > 0 &&
                    gameState[3] > 0 &&
                    gameState[4] > 0 &&
                    gameState[5] > 0 &&
                    gameState[6] > 0 &&
                    gameState[7] > 0 &&
                    gameState[8] > 0 {
                    
                    //Playing music for when there is no winner
                    let lose: NSURL = NSBundle.mainBundle().URLForResource("sadviolin", withExtension: "mp3")!
                    loserMusic = try! AVAudioPlayer(contentsOfURL: lose)
                    loserMusic.play()
                    
                    topLabel.text = "No winner. You guys are bad" //Tell the user that no one won
                    reset.hidden = false //Make the reset button visible
                    
                    //Hiding all the buttons so you can't click them again
                    but1.hidden = true
                    but2.hidden = true
                    but3.hidden = true
                    but4.hidden = true
                    but5.hidden = true
                    but6.hidden = true
                    but7.hidden = true
                    but8.hidden = true
                    but9.hidden = true
                    
                }
            }
        }
            
            //Will execute if there is a winner
            if winner != 0 {
                
                //If player 1 won
                if winner == 1 {
                    topLabel.text = "PLAYER 1 WINS GET REKT" //Tell the user that player 1 won
                    reset.hidden = false //Make the reset button visible
                    
                }
                //If player 2 won
                if winner == 2 {
                    topLabel.text = "PLAYER 2 WINS GET REKT" //Tell the user that player 2 won
                    reset.hidden = false //Make the reset button visible
                    
                    
                }
                
                //Hiding all the buttons so you can't click on them again
                but1.hidden = true
                but2.hidden = true
                but3.hidden = true
                but4.hidden = true
                but5.hidden = true
                but6.hidden = true
                but7.hidden = true
                but8.hidden = true
                but9.hidden = true
                
                //Will execute these sounds if there is a winner
                if winner > 0 {
                
                    //Will only play this sound if player 2 won and the user is playing the computer
                    if playerOrComputer == 1 && winner == 2 {
                        let sad: NSURL = NSBundle.mainBundle().URLForResource("sadairhorn", withExtension: "mp3")!
                        sadViolin = try! AVAudioPlayer(contentsOfURL: sad)
                        sadViolin.play()
                    }
                    
                    //Will play all the other sounds if the previous condition wasn't met
                    else {
                        let soundURL: NSURL = NSBundle.mainBundle().URLForResource("airhorn", withExtension: "mp3")!
                        airhorn = try! AVAudioPlayer(contentsOfURL: soundURL)
                        airhorn.play()
                        
                        let soundURL2: NSURL = NSBundle.mainBundle().URLForResource("wombocombo", withExtension: "mp3")!
                        oh = try! AVAudioPlayer(contentsOfURL: soundURL2)
                        oh.play()
                        
                        let soundURL3: NSURL = NSBundle.mainBundle().URLForResource("wow", withExtension: "mp3")!
                        wow = try! AVAudioPlayer(contentsOfURL: soundURL3)
                        wow.volume = 15 //Setting the volume for this sound
                        
                        //Making this sound play after a few seconds so not all sounds start at the same time
                        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            if self.reset.hidden == false {
                                self.wow.play()
                            }
                        }
                        
                        
                        let soundURL4: NSURL = NSBundle.mainBundle().URLForResource("getnoscoped", withExtension: "mp3")!
                        getNoScoped = try! AVAudioPlayer(contentsOfURL: soundURL4)
                        
                        //Delay the playing of this sound to ensure that not all sounds start at the same time
                        dispatch_after(time, dispatch_get_main_queue()) {
                            if self.reset.hidden == false {
                                self.getNoScoped.play()
                            }
                        }
                    }
                }
            }
        }
    
    //Function where the AI takes it's turn. THE AI DOES NOT HAVE ANY ACTUAL TIC TAC TOE STRATEGY. IT ONLY PICKS RANDOM SPOTS.
    func aiDecide() {
        var randomNum = Int(arc4random_uniform(9)) //A variable assigned to a random number between 0 and 8
        var image = UIImage() //Variable for the image
        
        image = UIImage(named: "o")! //Making the image equal to the o image I have
        
        //Testing if the spot chosen by the AI is taken. If it is, then pick a new number.
        while takenSpots[randomNum] == 1 {
            randomNum = Int(arc4random_uniform(9))
        }
        
        gameState[randomNum] = 2 //Making the gameState equal to 2
        
        //Playing the hitmarker sound that will play when the AI chooses its spot
        let soundURL: NSURL = NSBundle.mainBundle().URLForResource("hitmarker", withExtension: "mp3")!
        hitmarker = try! AVAudioPlayer(contentsOfURL: soundURL)
        hitmarker.play()
        
        //If statements for the different sender tag possibilities so the image corresponding to that spot will display the right image
        if randomNum == 0 {
            boxOne.image = image
        }
        if randomNum == 1 {
            boxTwo.image = image
        }
        if randomNum == 2 {
            boxThree.image = image
        }
        if randomNum == 3 {
            boxFour.image = image
        }
        if randomNum == 4 {
            boxFive.image = image
        }
        if randomNum == 5 {
            boxSix.image = image
        }
        if randomNum == 6 {
            boxSeven.image = image
        }
        if randomNum == 7 {
            boxEight.image = image
        }
        if randomNum == 8 {
            boxNine.image = image
        }
        player = 1 //Making the player equal to 1
        takenSpots[randomNum] = 1 //Making one of the spots taken
        topLabel.text = "Player 1 go ahead m8" //Changing the label
        
        //For loop for testing the winner
        for index in 1...2 {
            //A huge if statement to test if there is a winner
            if  (gameState[0] == index && gameState[1] == index && gameState[2] == index) ||
                (gameState[3] == index && gameState[4] == index && gameState[5] == index) ||
                (gameState[6] == index && gameState[7] == index && gameState[8] == index) ||
                (gameState[0] == index && gameState[3] == index && gameState[6] == index) ||
                (gameState[1] == index && gameState[4] == index && gameState[7] == index) ||
                (gameState[2] == index && gameState[5] == index && gameState[8] == index) ||
                (gameState[0] == index && gameState[4] == index && gameState[8] == index) ||
                (gameState[2] == index && gameState[4] == index && gameState[6] == index) {
                winner = index //If one of these conditions apply, make the winner equal to the index of the loop
            }
        }
        
        //Will execute if there is a winner
        if winner != 0 {
            
            //If player 1 won
            if winner == 1 {
                topLabel.text = "PLAYER 1 WINS GET REKT" //Tell the user that player 1 won
                reset.hidden = false //Make the reset button visible
                
                //Hiding all the buttons so you can't click them again
                but1.hidden = true
                but2.hidden = true
                but3.hidden = true
                but4.hidden = true
                but5.hidden = true
                but6.hidden = true
                but7.hidden = true
                but8.hidden = true
                but9.hidden = true
                
                //Play all of these sounds if player 1 won
                
                let soundURL: NSURL = NSBundle.mainBundle().URLForResource("airhorn", withExtension: "mp3")!
                airhorn = try! AVAudioPlayer(contentsOfURL: soundURL)
                airhorn.play()
                
                let soundURL2: NSURL = NSBundle.mainBundle().URLForResource("wombocombo", withExtension: "mp3")!
                oh = try! AVAudioPlayer(contentsOfURL: soundURL2)
                oh.play()
                
                let soundURL3: NSURL = NSBundle.mainBundle().URLForResource("wow", withExtension: "mp3")!
                wow = try! AVAudioPlayer(contentsOfURL: soundURL3)
                wow.volume = 15
                
                //2 second delay so the sounds don't all start at the same time
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    if self.reset.hidden == false {
                        self.wow.play()
                    }
                }
                
                
                let soundURL4: NSURL = NSBundle.mainBundle().URLForResource("getnoscoped", withExtension: "mp3")!
                getNoScoped = try! AVAudioPlayer(contentsOfURL: soundURL4)
                dispatch_after(time, dispatch_get_main_queue()) { //Delaying the sound by 2 seconds
                    if self.reset.hidden == false {
                        self.getNoScoped.play()
                    }
                }

            }
            //If player 2 won
            if winner == 2 {
                topLabel.text = "PLAYER 2 WINS GET REKT" //Tell the user that player 2 won
                reset.hidden = false //Make the reset button visible
                
                //Play this sad music if the computer won (It's meant to be very disappointing because you shouldn't lose against a computer with no strategy)
                let sad: NSURL = NSBundle.mainBundle().URLForResource("sadairhorn", withExtension: "mp3")!
                sadViolin = try! AVAudioPlayer(contentsOfURL: sad)
                sadViolin.play()
                
                //Hiding all the buttons so you can't click them again
                but1.hidden = true
                but2.hidden = true
                but3.hidden = true
                but4.hidden = true
                but5.hidden = true
                but6.hidden = true
                but7.hidden = true
                but8.hidden = true
                but9.hidden = true
            }
        
            
            
            
        }
        
        //Testing if there is no winner
        if winner == 0 {
            //Testing if all of the boxes are populated and there is no winner
            if  gameState[0] > 0 &&
                gameState[1] > 0 &&
                gameState[2] > 0 &&
                gameState[3] > 0 &&
                gameState[4] > 0 &&
                gameState[5] > 0 &&
                gameState[6] > 0 &&
                gameState[7] > 0 &&
                gameState[8] > 0 {
                
                //Play this music if there is no winner
                let lose: NSURL = NSBundle.mainBundle().URLForResource("sadviolin", withExtension: "mp3")!
                loserMusic = try! AVAudioPlayer(contentsOfURL: lose)
                loserMusic.play()
                
                topLabel.text = "No winner. You guys are bad" //Tell the user that no one won
                reset.hidden = false //Make the reset button visible
                
                //Hiding all the buttons so you can't click them again
                but1.hidden = true
                but2.hidden = true
                but3.hidden = true
                but4.hidden = true
                but5.hidden = true
                but6.hidden = true
                but7.hidden = true
                but8.hidden = true
                but9.hidden = true
                
            }
        }
    }
}
