//
//  ViewController.m
//  PickerViewTutorial
//
//  Created by Khoa on 11/21/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "ViewController.h"

@interface UIPickerView (makeHalf)
-(void) makeHalf: (NSMutableArray *) arr;
@end

@implementation UIPickerView (makeHalf)

-(void) makeHalf: (NSMutableArray *) arr {
    for (int i = 0; i < [arr count]; i++) {
        [self selectRow:[arr[i] count] * 100 /2 inComponent:i animated:YES];
    }
}

@end

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic) NSMutableArray *array;
@property (nonatomic) NSMutableArray *arrTimer;
@property (nonatomic) NSTimer *timer;
@end

@implementation ViewController
    int i = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    NSArray *array1;
    array1 = [[NSArray alloc] initWithObjects:@"🍎", @"🍏", @"🍍", @"🌸", @"🍊", nil];
    self.array = [NSMutableArray arrayWithObjects:array1, array1, array1, nil];
    [self.pickerView makeHalf:self.array];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.array count];
}

- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *labelAnimal = [[UILabel alloc] init];
    labelAnimal.font = [UIFont fontWithName:@"Apple Color Emoji" size:80.0];
    labelAnimal.text = self.array[component][row % [self.array[component] count]];
    return labelAnimal;
}

-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100.0;
}
-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger n = [self.array[component] count] * 100;
    return n;
}
- (IBAction)spinBtnPressed:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(counter) userInfo:nil repeats:YES];
}

-(void) counter {
    UInt32 randomNumber = arc4random() % (UInt32)([self.array count] * 100 + 0);
    [self.pickerView selectRow:randomNumber inComponent:i animated:YES];
    long indexArr = [self.arrTimer[i] intValue];
    indexArr = randomNumber % [self.array[i] count];
    i++;
    if (i == [self.array count]) {
        i = 0;
        [self.timer invalidate];
        if (self.arrTimer[0] == self.arrTimer[1] && self.arrTimer[1] == self.arrTimer[2]) {
            NSLog(@"a");
        } else if (self.arrTimer[0] == self.arrTimer[1] || self.arrTimer[0] == self.arrTimer[2] || self.arrTimer[1] == self.arrTimer[2]) {
            NSLog(@"b");
        } else {
            NSLog(@"c");
        }
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.array[component][row % 5];
}

@end
