//
//  ViewController.m
//  FlyPaySpinner
//
//  Created by Капитан on 28.05.15.
//  Copyright (c) 2015 com.capitan. All rights reserved.
//

#import "ViewController.h"

static int componentHeight = 50;
static int rowsInComponents = INT16_MAX;
static int numberOfComponents = 3;

@interface ViewController () {
    NSArray *spinData;
    NSMutableArray *resultOfSpin;
    int randomRow;
    BOOL isSpinning;
    BOOL isSpinningComponentLeft;
    BOOL isSpinningComponentCenter;
    BOOL isSpinningComponentRihgt;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *skeleton = [UIImage imageNamed:@"fruittype-skeleton.png"];
    UIImage *avocado = [UIImage imageNamed:@"fruittype-avocado.png"];
    UIImage *burrito = [UIImage imageNamed:@"fruittype-burrito.png"];
    spinData = [NSArray arrayWithObjects:skeleton, avocado, burrito, nil];

    resultOfSpin = [[NSMutableArray alloc] initWithCapacity: 3];
    
    for (int i = 0 ; i < numberOfComponents; i++) {
        [resultOfSpin insertObject:[NSNumber numberWithInteger:0] atIndex:i];
    }
    
    [self.spin selectRow:(rowsInComponents/2) inComponent:0 animated:NO];
    [self.spin selectRow:(rowsInComponents/2) inComponent:1 animated:NO];
    [self.spin selectRow:(rowsInComponents/2) inComponent:2 animated:NO];
    
    randomRow = 0;
    isSpinning = false;
    isSpinningComponentLeft = false;
    isSpinningComponentCenter = false;
    isSpinningComponentRihgt = false;
    
    [[self.spin layer] setCornerRadius:20];
    [self.spin setClipsToBounds:YES];
     CGColorRef borderColor = [UIColor colorWithRed:39.0/255.0 green:213.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
    self.dahsboardView.layer.borderColor = borderColor;
    self.dahsboardView.layer.borderWidth = 6;
    self.spin.layer.borderColor = borderColor;
    self.spin.layer.borderWidth = 6;
    self.resultLabel.text = @"Press the button";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    //MARK: - PickerView delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return rowsInComponents;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return componentHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {

    int randomNumber = arc4random() % [spinData count];

    if (randomRow == row) {
        if ((component == 0) && isSpinningComponentLeft) {
            isSpinningComponentLeft = false;
            [resultOfSpin replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:randomNumber]];
        }
        
        if ((component == 1) && isSpinningComponentCenter){
            isSpinningComponentCenter = false;
            [resultOfSpin replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:randomNumber]];
        }

        if ((component == 2) && isSpinningComponentRihgt) {
            isSpinningComponentRihgt = false;
            [resultOfSpin replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:randomNumber]];
        }
        
        if (!isSpinningComponentLeft && !isSpinningComponentCenter && !isSpinningComponentRihgt && isSpinning) {
            NSNumber *result = resultOfSpin[0];
            BOOL isWin = true;
            for(id item in resultOfSpin) {
                if ([item isKindOfClass:[NSNumber class]]) {
                    if (item != result) {
                        isWin = false;
                    }
                }
            }
            
            if (isWin) {
                self.resultLabel.textColor = [UIColor redColor];
                self.resultLabel.text = @"Win";
                UIImage *winImage = [spinData objectAtIndex: randomNumber];
                self.resultImageView.image = winImage;
    
                CGColorRef redColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor;
                self.spin.layer.borderColor = redColor;
            } else {
                self.resultLabel.textColor = [UIColor blackColor];
                self.resultImageView.image = nil;
                self.resultLabel.text = @"Lose";
                
                CGColorRef borderColor = [UIColor colorWithRed:39.0/255.0 green:213.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
                self.spin.layer.borderColor = borderColor;
            }
            isSpinning = false;
        }
    }
    
    UIImage *randomImage = [spinData objectAtIndex: randomNumber];
    UIImageView *images = [[UIImageView alloc] initWithImage:randomImage];
    
    UIColor *color = [UIColor yellowColor];
    images.layer.shadowColor = [color CGColor];

    images.layer.shadowRadius = 3.0f;
    images.layer.shadowOpacity = 0.4;
    images.layer.shadowOffset = CGSizeZero;
    images.layer.masksToBounds = NO;
    

    [UIView animateWithDuration:0.4f animations:^{
        CGRect currentRect = images.frame;
        currentRect.origin.y -= 50;
        [images setFrame:currentRect];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            CGRect currentRect = images.frame;
            currentRect.origin.y += 40;
            [images setFrame:currentRect];
        }];
    }];

    [UIView animateWithDuration:0.1f animations:^{
        CGRect currentRect = images.frame;
        currentRect.origin.y += 50;
        [images setFrame:currentRect];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect currentRect = images.frame;
            currentRect.origin.y -= 40;
            [images setFrame:currentRect];
        }];
    }];

    return images;
}


    //MARK: - Spin button

- (IBAction)spin:(id)sender {
  
    randomRow = arc4random() % rowsInComponents;

    [self.spin selectRow:randomRow inComponent:0 animated:YES];
    [self.spin selectRow:randomRow inComponent:1 animated:YES];
    [self.spin selectRow:randomRow inComponent:2 animated:YES];
    
    isSpinning = true;
    isSpinningComponentLeft = true;
    isSpinningComponentCenter = true;
    isSpinningComponentRihgt = true;
    
    self.resultLabel.text = @"";
}




@end
