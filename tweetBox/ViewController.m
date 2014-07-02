//
//  ViewController.m
//  tweetBox
//
//  Created by Adam Fallon on 30/06/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import <Twitter/Twitter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"photography.png"]];
    [self setNeedsStatusBarAppearanceUpdate];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(IBAction)sendTweet:(id)sender {
    [self showTweetSheet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTweetSheet
{
    //  Create an instance of the Tweet Sheet
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeTwitter];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any required UI
    // updates occur on the main queue
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Tweet Sent!" message:@"You Did it!" delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil, nil];
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
                [alert show];
                break;
        }
    };
    
    //  Set the initial body of the Tweet
    [tweetSheet setInitialText:@" "];
    
    //  Adds an image to the Tweet.  For demo purposes, assume we have an
    //  image named 'larry.png' that we wish to attach
    if (![tweetSheet addImage:[UIImage imageNamed:@"Twitter_logo_blue.png"]]) {
        NSLog(@"Unable to add the image!");
    }
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![tweetSheet addURL:[NSURL URLWithString:@"http://twitter.com/"]]){
        NSLog(@"Unable to add the URL!");
    }
    
    //  Presents the Tweet Sheet to the user
    [self presentViewController:tweetSheet animated:NO completion:^{
        NSLog(@"Tweet sheet has been presented.");
    }];
}
@end
