//
//  ViewController.m
//  DJKhaled
//
//  Created by Nikhil Gahlot on 12/20/15.
//  Copyright © 2015 Nikhil Gahlot. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor: [self colorWithHexString:@"82207F"]];

}

- (void)animateImage
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat wobbleAngle = 0.06f;
    
    NSValue* valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
    NSValue* valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
    animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
    
    animation.autoreverses = YES;
    animation.duration = 0.125;
    animation.repeatCount = 5;
    
    [[self.view layer] addAnimation:animation forKey:@"shakeAnimation"];

}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)soundbuttonclick:(id)sender {
    int randomSoundNumber = arc4random() % 4; //random number from 0 to 3
    
    NSLog(@"random sound number = %i", randomSoundNumber);
    
    NSString *effectTitle;
    
    switch (randomSoundNumber) {
        case 0:
            effectTitle = @"1";
            break;
        case 1:
            effectTitle = @"2";
            break;
        case 2:
            effectTitle = @"3";
            break;
        case 3:
            effectTitle = @"4";
            break;
        case 4:
            effectTitle = @"5";
            break;
        case 5:
            effectTitle = @"6";
            break;
        case 6:
            effectTitle = @"7";
            break;
        case 7:
            effectTitle = @"8";
            break;
        case 8:
            effectTitle = @"9";
            break;
        case 9:
            effectTitle = @"10";
            break;

            
        default:
            break;
    }
    
    [self animateImage];
    NSLog(effectTitle);
    SystemSoundID dj;
    NSString *path = [[NSBundle mainBundle]
                            pathForResource:effectTitle ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &dj);
    AudioServicesPlaySystemSound(dj);
    //[[self.view layer] removeAnimationForKey:@"shakeAnimation"];


    /*SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"caf"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);*/
}

@end
