//
//  ViewController.m
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "VideoCell.h"
#import "Video.h"
#import "VideoVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *videoList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.videoList = [[NSArray alloc] init];
    [[HTTPService instance] getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable err) {
        if (dataArray) {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < [dataArray count]; i++) {
                Video *v = [[Video alloc] initWithDict:[dataArray objectAtIndex:i]];
                [arr addObject:v];
            }
            self.videoList = arr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"%@", err);
        }
    }];
}

- (void)dealloc
{
    self.tableView = nil;
    self.videoList = nil;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"VideoVC" sender:video];
    video = nil;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    VideoCell *vidCell = (VideoCell *) cell;
    [vidCell cellConfigure:video];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    VideoVC *vc = segue.destinationViewController;
    Video *video = (Video *)sender;
    vc.video = video;
}

@end
