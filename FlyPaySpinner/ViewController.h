//
//  ViewController.h
//  FlyPaySpinner
//
//  Created by Капитан on 28.05.15.
//  Copyright (c) 2015 com.capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *spin;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UIView *dahsboardView;

@end

