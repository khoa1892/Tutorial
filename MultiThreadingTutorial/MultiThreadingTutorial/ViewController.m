//
//  ViewController.m
//  MultiThreadingTutorial
//
//  Created by Khoa on 10/24/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "ViewController.h"
#import "Bird.h"
#import "TableViewCell.h"
@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *myArray;
@property (nonatomic, strong) Bird *bird;
@property (nonatomic, strong) NSMutableArray *arrCache;
-(void) loadImage:(NSString *)urlString andIndex:(NSUInteger)index;
-(void) getData:(NSString *)urlString;
@end
@implementation ViewController
-(void) loadImage:(NSString *)urlString andIndex:(NSUInteger)index {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *dataImage = [NSData dataWithContentsOfURL:url];
    self.arrCache[index] = [UIImage imageWithData:dataImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myArray = [[NSMutableArray alloc] init];
    self.arrCache = [[NSMutableArray alloc] init];
    
    [self getData:@"http://labkhoapham.com/GETSP.php?index=0&numberPages=20"];
    
    self.tableView.dataSource = self;
}

-(void) getData:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        for (int i = 0; i < [json count]; i++) {
            self.bird = [[Bird alloc] initWithDic:[json objectAtIndex:i]];
            [self.myArray addObject:self.bird];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSUInteger j = 0; j < [self.myArray count]; j++) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                                   0);
                [self.arrCache addObject:[UIImage imageNamed:@"1"]];
                dispatch_async(queue, ^{
                    Bird *item = self.myArray[j];
                    [self loadImage:item.birdImage andIndex:j];
                });
            }
            [self.tableView reloadData];
        });
    }] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                          forIndexPath:indexPath];
    Bird *item = self.myArray[indexPath.row];
    [cell configureCell:(UIImage *)self.arrCache[indexPath.row] andTitle:item.birdName];
    return cell;
}

-(BOOL) prefersStatusBarHidden {
    return true;
}

@end
