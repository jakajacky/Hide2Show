//
//  ViewController.m
//  Hide2Show
//
//  Created by XiaoQiang on 2017/7/11.
//  Copyright © 2017年 XiaoQiang. All rights reserved.
//

#import "ViewController.h"
#import <stdlib.h>

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

- (IBAction)showBtnDidClicked:(id)sender {
  NSDictionary *error = [NSDictionary new];
  NSString *str =  @"defaults write com.apple.finder AppleShowAllFiles -bool true;killall Finder";
  NSString *script =  [NSString stringWithFormat:@"do shell script \"%@\"", str];
  NSAppleScript *appleScript = [[NSAppleScript new] initWithSource:script];
  NSAppleEventDescriptor *des = [appleScript executeAndReturnError:&error];
  NSLog(@"%@",des.stringValue);
}

- (IBAction)hideBtnDidClicked:(id)sender {
  NSDictionary *error = [NSDictionary new];
  NSString *str =  @"defaults write com.apple.finder AppleShowAllFiles -bool false;killall Finder";
  NSString *script =  [NSString stringWithFormat:@"do shell script \"%@\"", str];
  NSAppleScript *appleScript = [[NSAppleScript new] initWithSource:script];
  NSAppleEventDescriptor *des = [appleScript executeAndReturnError:&error];
  NSLog(@"%@",des.stringValue);
  
}

- (void)setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];

  // Update the view, if already loaded.
}



@end
