//
//  TwitterTimeline.h
//  StudySocialApp-iOS
//
//  Created by Mark Cyril Anthony Heruela on 5/15/14.
//  Copyright (c) 2014 Huchcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TwitterTimeline : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *twitterTimeline;
@property (strong, nonatomic) NSArray *dataSource;

@end
