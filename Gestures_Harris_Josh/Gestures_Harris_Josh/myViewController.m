//
//  myViewController.m
//  Gestures_Harris_Josh
//
//  Created by Josh Harris on 9/17/14.
//  Copyright (c) 2014 Josh Harris. All rights reserved.
//

#import "myViewController.h"

@interface myViewController ()
@property (assign) int totalTime;
@property (assign) int currentScore;
@property (assign) int bestScore;
@property (assign) int randomNumber;
@property (assign) int last;
//To Hide the labels for when the game ends
@property (weak, nonatomic) IBOutlet UILabel *gameOver;
@property (weak, nonatomic) IBOutlet UILabel *gesturesInRound;
@property (weak, nonatomic) IBOutlet UILabel *currentGesturesLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestNumberLabel;
//the array holding the iamges
@property (strong, nonatomic) NSMutableArray *imageArray;
//For the timer
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
//Outles for the iamges and gestures
@property (weak, nonatomic) IBOutlet UIImageView *myImages;
@property (weak, nonatomic) IBOutlet UIView *myGestures;

@end

@implementation myViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //I did not want a back button at the top
    //Only allow back for when the game is over
    //and the UIView is tapped
    self.navigationItem.hidesBackButton = YES;
    self.gameOver.hidden = YES;
    self.gesturesInRound.hidden = YES;
    self.currentGesturesLabel.hidden =YES;
    self.bestLabel.hidden = YES;
    self.bestNumberLabel.hidden = YES;
    self.totalTime = 60;
    self.currentScore = 0;
    //Load the last high score
    self.bestScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] integerValue];
    //random number for the images
    self.randomNumber = arc4random_uniform(4);
    //using last to make sure the number is not a repeat
    self.last = self.randomNumber;
    //allocate and initialize the image array
    self.imageArray = [[NSMutableArray alloc] init];
    //start the timer
    [self timerStart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//What happens when the timer starts, where it calls to
- (void) timerStart
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}
//method called for the timer
- (void) onTimer
{
    //updates the time
    self.totalTime--;
    NSString *stringSeconds = [NSString stringWithFormat:@"%d", self.totalTime];
    
    self.labelTime.text = [NSString stringWithFormat:@"%@", stringSeconds];
    //add the images to the array
    [self.imageArray addObject:@"PinchButton.png"];
    [self.imageArray addObject:@"SwipeLeft.png"];
    [self.imageArray addObject:@"SwipeRight.png"];
    [self.imageArray addObject:@"TapButton"];
    //display the first random image
    self.myImages.image = [UIImage imageNamed:[self.imageArray objectAtIndex:self.randomNumber]];
    //when the countdown timer runs out
    if (self.totalTime <= 0)
    {
        //get rid of the timer, hide/display labels
        [self.timer invalidate];
        self.timer = nil;
        self.labelTime.hidden = YES;
        self.myImages.hidden = YES;
        self.gameOver.hidden = NO;
        self.gesturesInRound.hidden = NO;
        self.currentGesturesLabel.hidden = NO;
        self.bestLabel.hidden = NO;
        self.bestNumberLabel.hidden = NO;
        //displaying the current score
        NSString *stringScore = [NSString stringWithFormat:@"%d", self.currentScore];
        
        self.currentGesturesLabel.text = [NSString stringWithFormat:@"%@", stringScore];
        //displaying,updating, and saving the high score
        if(self.currentScore > self.bestScore)
        {
            self.bestScore = self.currentScore;
            
            NSString *stringBestScoreNew = [NSString stringWithFormat:@"%d", self.bestScore];
            
            self.bestNumberLabel.text = [NSString stringWithFormat:@"%@", stringBestScoreNew];
            //Save the high score into memory
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:self.bestScore]  forKey:@"highScore"];
        }
        else
        {
            NSString *stringBestScore = [NSString stringWithFormat:@"%d", self.bestScore];
            
            self.bestNumberLabel.text = [NSString stringWithFormat:@"%@", stringBestScore];
        }

    }

}
//The 4 different gestures linked to the UIView box
- (IBAction)swipeRight:(UISwipeGestureRecognizer*)sender
{
    if(self.randomNumber == 2)
    {
        //update score if correct
        self.currentScore++;
        //new random number for a new image
        self.randomNumber = arc4random_uniform(4);
        //check to see if the new number is the same as last
        if(self.randomNumber == self.last)
        {
            //if so then random number again
            self.randomNumber = arc4random_uniform(4);
        }
        else
        {
            //else update last to current image number
            self.last = self.randomNumber;
            //update new image
            self.myImages.image = [UIImage imageNamed:[self.imageArray objectAtIndex:self.randomNumber]];
        }
    }
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer*)sender
{
    if(self.randomNumber == 1)
    {
        self.currentScore++;
        self.randomNumber = arc4random_uniform(4);
        
        if(self.randomNumber == self.last)
        {
            self.randomNumber = arc4random_uniform(4);
        }
        else
        {
            self.last = self.randomNumber;
            self.myImages.image = [UIImage imageNamed:[self.imageArray objectAtIndex:self.randomNumber]];
        }
    }
}

- (IBAction)pinch:(UIPinchGestureRecognizer*)sender
{
    if(self.randomNumber == 0)
    {
        self.currentScore++;
        self.randomNumber = arc4random_uniform(4);
        
        if(self.randomNumber == self.last)
        {
            self.randomNumber = arc4random_uniform(4);
        }
        else
        {
            self.last = self.randomNumber;
            self.myImages.image = [UIImage imageNamed:[self.imageArray objectAtIndex:self.randomNumber]];
        }
    }
}

- (IBAction)tapButton:(UITapGestureRecognizer*)sender
{
    if(self.randomNumber == 3)
    {
        self.currentScore++;
        self.randomNumber = arc4random_uniform(4);
        
        if(self.randomNumber == self.last)
        {
            self.randomNumber = arc4random_uniform(4);
        }
        else
        {
            self.last = self.randomNumber;
            self.myImages.image = [UIImage imageNamed:[self.imageArray objectAtIndex:self.randomNumber]];
        }
    }
    //if the time is zero and the user taps the UIView
    if (self.totalTime <= 0)
    {
        // then segue to the start screen
    [self performSegueWithIdentifier:@"gameReset" sender:self];
    }
}
@end