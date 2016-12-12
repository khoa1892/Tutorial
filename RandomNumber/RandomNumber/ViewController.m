//
//  ViewController.m
//  RandomNumber
//
//  Created by Khoa on 11/7/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *spinBtn;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, weak) NSString *numberText;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic) BOOL check;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSMutableArray alloc] init];
}
- (IBAction)setNumber:(id)sender {
    
}

-(void) selectNumber:(NSNumber *) value {
    NSComparisonResult compareResult;
    compareResult = [value compare:[NSNumber numberWithInt:10]];
    
    if (compareResult == NSOrderedAscending) {
        self.numberText = [NSString stringWithFormat:@"%@0%@ ", self.numberText, [value stringValue]];
    } else {
        self.numberText = [NSString stringWithFormat:@"%@%@ ", self.numberText, [value stringValue]];
    }
    
    [self.label setText:self.numberText];
    
    if (value == self.array[self.array.count - 1]) {
        [self.spinBtn setEnabled:true];
        [self.spinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.spinBtn.layer.cornerRadius = 0.5 * self.spinBtn.bounds.size.width;
    self.spinBtn.tintColor = [UIColor whiteColor];
    [self.array removeAllObjects];
    self.numberText = @"";
    [self randomTimer];
    float delay = 0;
    [self.spinBtn setEnabled:false];
    [self.spinBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    for (int i = 0; i < [self.array count]; i++) {
        [self performSelector:@selector(selectNumber:) withObject:self.array[i] afterDelay:delay];
        delay += 1.0;
    }
}

-(int) randomNumber {
    int n = arc4random() % 45;
    return n;
}
-(void) randomTimer {
    do {
        NSNumber *x = [NSNumber numberWithInt:[self randomNumber]];
        self.check = [self checkNumber:x];
        if (self.check == true) {
            [self randomTimer];
        } else {
            [self.array addObject:x];
        }
    } while ([self.array count] < 6);
    [self arrSort:self.array];
}

-(void) arrSort:(NSMutableArray *) arrayUnSort {
    for (int i = 0; i < [arrayUnSort count] - 1; i++) {
        for (int j = i + 1; j < [self.array count]; j++) {
            NSComparisonResult compareResult;
            compareResult = [arrayUnSort[j] compare:arrayUnSort[i]];
            if (compareResult == NSOrderedAscending) {
                NSNumber *temp = arrayUnSort[i];
                arrayUnSort[i] = arrayUnSort[j];
                arrayUnSort[j] = temp;
            }
        }
    }
}

-(BOOL) checkNumber:(NSNumber *) x {
    if ([x isEqualToNumber:[NSNumber numberWithInt:0]]) {
        return true;
    } else {
        for (int i = 0; i < [self.array count]; i++) {
            if ([self.array[i] isEqualToNumber:x]) {
                return true;
            }
        }
    }
    return false;
}

@end
