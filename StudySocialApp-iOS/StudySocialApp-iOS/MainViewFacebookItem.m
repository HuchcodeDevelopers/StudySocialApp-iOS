//
//  MainViewFacebookItem.m
//  StudySocialApp-iOS
//
//  Created by Bryan Pecjo on 5/22/14.
//  Copyright (c) 2014 Huchcode. All rights reserved.
//

#import "MainViewFacebookItem.h"
#import "FacebookTimeline.h"
#import "MainViewController.h"

@implementation MainViewFacebookItem

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        UIImageView *imageName=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imageName setImage:[UIImage imageNamed:@"feed.png"]];
        [self addSubview:imageName];
        
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    FacebookTimeline *facebookController=[[FacebookTimeline alloc] init];
    [[self superViewController].navigationController pushViewController:facebookController animated:YES];
    
    
}

- (MainViewController *)superViewController {
    for (UIView *next=[self superview]; next; next=next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[MainViewController class]]) {
            return (MainViewController *)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
