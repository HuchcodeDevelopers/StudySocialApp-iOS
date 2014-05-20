//
//  TwitterTimeline.m
//  StudySocialApp-iOS
//
//  Created by Mark Cyril Anthony Heruela on 5/15/14.
//  Copyright (c) 2014 Huchcode. All rights reserved.
//

#import "TwitterTimeline.h"
#import "TwitterTableCell.h"

@interface TwitterTimeline ()

@end

@implementation TwitterTimeline

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getTimeLine];

    self.tableView.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTimeLine
{
//    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    if([SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter])
//    {
        ACAccountStore *account = [[ACAccountStore alloc]init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

        [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
         {
             if (granted == YES)
             {
                 NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];

                 if ([arrayOfAccounts count] > 0)
                 {
                     ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                     
                     NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                     
                     //                 NSDictionary *parameters = @{@"screen_name":@"@cyrilheruela", @"include_rts":@"0", @"trim_user":@"1", @"count":@"20"};
                     //                 NSLog(@"%@", twitterAccount.username);
                     NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                     [parameters setObject:twitterAccount.username forKey:@"screen_name"];
                     [parameters setObject:@"20" forKey:@"count"];
                     [parameters setObject:@"1" forKey:@"include_entities"];
                     
                     SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
                     
                     postRequest.account = twitterAccount;
                     
                     [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                         self.dataSource = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                         
                         if (self.dataSource.count != 0)
                         {
                             dispatch_async(dispatch_get_main_queue(), ^{[self.twitterTimeline reloadData];});
                         }
                     }];
                 } else if ([arrayOfAccounts count] == 0) {
//                     SLComposeViewController *tweetSheet = [[SLComposeViewController alloc]init];
                     SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                     tweetSheet.view.hidden = YES;
                     [self presentViewController:tweetSheet animated:NO completion:^{[tweetSheet.view endEditing:YES];}];
                 }
             } else {
                 // Failure
                 NSLog(@"%@", [error localizedDescription]);
             }	
         }
         ];
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
//    UITableViewCell *cell = [self.twitterTimeline dequeueReusableCellWithIdentifier:CellIdentifier];
    TwitterTableCell *cell = (TwitterTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
    NSDictionary *tweet = _dataSource[[indexPath row]];

    cell.tweetUsername.font = [UIFont systemFontOfSize:8.0];
    cell.tweetText.numberOfLines = 6;
    cell.tweetText.lineBreakMode = NSLineBreakByWordWrapping;
    cell.tweetText.font = [UIFont systemFontOfSize:10.0];
    cell.tweetText.textColor = [UIColor whiteColor];
    NSString *profImageURL = tweet[@"user"][@"profile_image_url"];
    NSData *profImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profImageURL]];
    UIImageView *profilePicView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:profImageData]];
    profilePicView.layer.borderColor = [UIColor blackColor].CGColor;
    profilePicView.layer.borderWidth = 1;
    
    [cell.tweetProfilePic addSubview:profilePicView];
    cell.tweetUsername.text = tweet[@"user"][@"name"];
    cell.tweetText.text = tweet[@"text"];

//    cell.textLabel.numberOfLines = 6;
//    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    cell.textLabel.font = [UIFont systemFontOfSize:10];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.text = tweet[@"text"];
//
//    NSString *profImageURL = tweet[@"user"][@"profile_image_url"];
//    NSData *profImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profImageURL]];
//    cell.imageView.image = [UIImage imageWithData:profImageData];
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", tweet[@"id"], tweet[@"text"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwitterDetail *tweetDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TwitterDetail"];
    tweetDetailVC.tweetDetail = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:tweetDetailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
