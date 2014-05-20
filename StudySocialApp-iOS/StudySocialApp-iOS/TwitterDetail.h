//
//  TwitterDetail.h
//  StudySocialApp-iOS
//
//  Created by Mark Cyril Anthony Heruela on 5/20/14.
//  Copyright (c) 2014 Huchcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterDetail : UIViewController

@property (strong, nonatomic) NSDictionary *tweetDetail;
@property (strong, nonatomic) IBOutlet UILabel *tweetUsername;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;
@property (strong, nonatomic) IBOutlet UIImageView *tweetProfilePic;

@end
