//
//  GesturesViewController.m
//  Gestures_Harris_Josh
//
//  Created by Josh Harris on 9/17/14.
//  Copyright (c) 2014 Josh Harris. All rights reserved.
//

#import "GesturesViewController.h"

@interface GesturesViewController ()

@end

@implementation GesturesViewController
- (IBAction)startButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"menuToGame" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
