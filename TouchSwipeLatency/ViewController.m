//
//  ViewController.m
//  TouchSwipeLatency
//
//  Created by Elena Last on 6/6/15.
//  Copyright (c) 2015 Elena Last. All rights reserved.
//

#import "ViewController.h"
#import "DrawSubView.h"
#import "DrawView.h"

@interface ViewController ()

@end

@implementation ViewController
Boolean isLeftOn = false;
float centerX;
Boolean needToSleep;
int count;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    DrawView *dw = [[DrawView alloc] initWithFrame: rect];
    dw.backgroundColor=[UIColor blackColor];
    [self.view addSubview:dw];
    centerX = self.view.frame.size.width/2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[DrawSubView class]])
        {
            [subView removeFromSuperview];
        }
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint currentLocation = [ touch locationInView:self.view];
    if (currentLocation.x < centerX) {
        isLeftOn = true;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[DrawSubView class]])
        {
            [subView removeFromSuperview];
        }
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint currentLocation = [ touch locationInView:self.view];
    //NSLog(@"Touch MOVED at (%f,%f)", currentLocation.x, currentLocation.y);
    ///////////////
    DrawSubView* drawableView2 = [[DrawSubView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //float centerY = self.view.frame.size.height/2;
    //drawableView2.backgroundColor=[UIColor whiteColor];
    
    drawableView2.drawBlock = ^(UIView* v,CGContextRef context)
    {
        //struct timespec tim, tim2;
        
        //tim.tv_sec = 0;
        //tim.tv_nsec = 1000000000L;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
        CGContextSetStrokeColor(ctx, white);
        CGRect rectLeft = CGRectMake(0, 0, self.view.frame.size.width/2, 0.45 * self.view.frame.size.height);
        CGRect rectRight = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width, 0.45 * self.view.frame.size.height);
        
        //if (needToSleep) {
        //    [NSThread sleepForTimeInterval:1];
        //}
        
        CGContextSetFillColor(ctx, white);
        CGPoint center = CGPointMake(centerX, 0.8 * self.view.frame.size.height); // get the circle centre
        CGFloat radius = 0.25 * center.x; // little scaling needed
        CGFloat startAngle = -((float)M_PI / 2); // 90 degrees
        CGFloat endAngle = ((2 * (float)M_PI) + startAngle);
        CGContextAddArc(ctx, center.x, center.y, radius, startAngle, endAngle, 0); // create an arc the +4 just adds some pixels because of the polygon line thickness
        // if (currentLocation.x > centerX && !tmp) {
        //     isLeftOn = true;
        //     tmp = true;
        // }
        
        
        if ((currentLocation.x > centerX && !isLeftOn) ||
            (currentLocation.x < centerX && isLeftOn)) {
            CGContextFillPath(ctx); // draw
            needToSleep = true;
            count = 0;
            //nanosleep(&tim, &tim2);
            isLeftOn = !isLeftOn;
            
            //CGContextStrokePath (ctx);
            
            //needToSleep = 1;
        }
        if (currentLocation.x > centerX) {
            if (count < 6 && needToSleep) {
                CGContextFillPath(ctx);
                CGContextFillRect ( ctx, rectRight);
                NSLog(@"count and need to sleep 1 (%d, %d)", count, needToSleep);
                //count++;
            } else {
                CGContextStrokePath (ctx);
                count = 0;
                needToSleep = false;
                CGContextFillRect ( ctx, rectLeft);
                //NSLog(@"count and need to sleep 2 (%d, %d)", count, needToSleep);
            }
            //CGContextFillRect ( ctx, rectLeft);
            //needToSleep = false;
            //isLeftOn = true;
        } else if (currentLocation.x < centerX) {
            if (count < 6 && needToSleep) {
                NSLog(@"count and need to sleep 3 (%d, %d)", count, needToSleep);
                CGContextFillPath(ctx);
                CGContextFillRect ( ctx, rectLeft);
                //count++;
                //needToSleep = false;
            } else {
                CGContextStrokePath (ctx);
                count = 0;
                needToSleep = false;
                CGContextFillRect ( ctx, rectRight);
                //NSLog(@"count and need to sleep 4 (%d, %d)", count, needToSleep);
            }
            //CGContextFillRect ( ctx, rectRight);
            //needToSleep = false;
            //isLeftOn = false;
        }
        
        //if (needToSleep == 1) {
        //    nanosleep(&tim, &tim2);
        //    needToSleep = 0;
        //    CGContextStrokePath (ctx);
        //}
        
        //NSLog(@"Frame size (%f,%f)", self.view.frame.size.width, self.view.frame.size.height);
        
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, currentLocation.x, 390);//currentLocation.x, currentLocation.y);
        CGContextAddLineToPoint(ctx, currentLocation.x, 400);
        CGContextStrokePath(ctx);
        
        
    };
    [self.view addSubview:drawableView2];
    count++;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[DrawSubView class]])
        {
            [subView removeFromSuperview];
        }
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[DrawSubView class]])
        {
            [subView removeFromSuperview];
        }
    }
}

@end
