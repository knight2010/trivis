//
//  PlayerViewController.m
//  RendererLister
//
//  Created by Proteas on 13-11-5.
//  Copyright (c) 2013年 Proteas. All rights reserved.
//

#import "PlayerViewController.h"
#import "UPnPAV.h"

static NSString * const kVideoURLStr =
@"http://go-swift.net/123.wav";

@interface PlayerViewController () <CGUpnpDeviceDelegate>

@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(startPlay) withObject:nil afterDelay:0.1f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startPlay
{
    if (!self.avRenderer)
        return;
    
    BOOL result = NO;
    self.avRenderer.delegate = self;
    result = [self.avRenderer stop];
    NSLog(@"----------------->stop: %d", result);
    result = [self.avRenderer setAVTransportURI:kVideoURLStr];
    NSLog(@"----------------->setAVTransportURI: %d", result);
    
    result = [self.avRenderer play];
    NSLog(@"----------------->play: %d", result);
    
    result = [self.avRenderer seek:4.262611];
    NSLog(@"----------------->seek: %d", result);
    
    result = [self.avRenderer isPlaying];
    NSLog(@"----------------->isPlaying: %d", result);
}

- (BOOL)device:(CGUpnpDevice *)device service:(CGUpnpService *)service actionReceived:(CGUpnpAction *)action
{
    NSLog(@"action %@", [action description]);
    return YES;
}

@end
