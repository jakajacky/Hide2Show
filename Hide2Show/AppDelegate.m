//
//  AppDelegate.m
//  Hide2Show
//
//  Created by XiaoQiang on 2017/7/11.
//  Copyright © 2017年 XiaoQiang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()<NSAnimationDelegate>
@property (strong,nonatomic) NSStatusItem *item;
@property (strong) NSPopover *popover;
@property(nonatomic)BOOL  isShow;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  // 获取系统单利NSStatusBar对象
  NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
  // 创建固定宽度的NSStatusItem
  NSStatusItem *item = [statusBar statusItemWithLength:NSSquareStatusItemLength];
  [item.button setTarget:self];
  [item.button setAction:@selector(itemAction:)];
  item.button.image = [NSImage imageNamed:@"Icon"];
  
  self.item = item;
  
  [self setUpPopover];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
  NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
  [statusBar removeStatusItem:self.item];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
  NSLog(@"become active");
  
}

// Hide2Show失去焦点（点击了别的应用）
- (void)applicationDidResignActive:(NSNotification *)notification {
  NSLog(@"resign active");
  [self.popover close];
  self.isShow = false;
}

// 通过状态栏icon实现显示窗口
- (IBAction)itemAction:(id)sender {
//  // 主窗口显示
//  [NSApp activateIgnoringOtherApps:NO];
//  for (NSWindow *window in [[NSApplication sharedApplication] windows]) {
//    [window makeKeyAndOrderFront:self];
//  }
//  //激活应用到前台(如果应用窗口处于非活动状态)
  [[NSRunningApplication currentApplication] activateWithOptions:(NSApplicationActivateAllWindows | NSApplicationActivateIgnoringOtherApps)];
  
    if (!self.isShow) {
      NSLog(@"open");
      [self setUpPopover]; // 解决存在扩展屏幕情况，在某一刻，某一块屏幕的状态栏上，点击无效的问题
      [self.popover showRelativeToRect:NSZeroRect ofView:[self item].button preferredEdge:NSRectEdgeMinY];
      //激活应用到前台(如果应用窗口处于非活动状态)
      [[NSRunningApplication currentApplication] activateWithOptions:(NSApplicationActivateAllWindows | NSApplicationActivateIgnoringOtherApps)];
    } else {
      NSLog(@"close");
      [self.popover close];
    }
    self.isShow = !self.isShow;
  
}

-(void) setUpPopover {
  self.popover = nil;
  self.popover = [[NSPopover alloc] init];
  
  NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
  ViewController *v = [storyboard instantiateControllerWithIdentifier:@"vc"];
  
  self.popover.contentViewController = v;
  self.popover.behavior = NSPopoverBehaviorApplicationDefined;
}

@end
