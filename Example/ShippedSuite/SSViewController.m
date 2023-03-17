//
//  SSViewController.m
//  ShippedSuite
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "SSViewController.h"
#import <ShippedSuite/ShippedSuite.h>

@interface SSViewController () <SSWidgetViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet SSWidgetView *widgetView;
@property (strong, nonatomic) ShippedSuiteConfiguration *configuration;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ShippedSuiteConfiguration *configuration = [ShippedSuiteConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = NO;
    configuration.isMandatory = NO;
    configuration.isRespectServer = YES;
    configuration.currency = @"EUR";
    self.configuration = configuration;
    
    _widgetView.delegate = self;
    _widgetView.configuration = configuration;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_widgetView updateOrderValue:[[NSDecimalNumber alloc] initWithString:_textField.text]];
}

- (IBAction)viewDidTap:(id)sender
{
    [_textField resignFirstResponder];
}

#pragma mark - SSWidgetViewDelegate

- (void)widgetView:(SSWidgetView *)widgetView onChange:(NSDictionary *)values
{
    BOOL isSelected = [values[SSWidgetViewIsSelectedKey] boolValue];
    NSLog(@"Widget state: %@", isSelected ? @"YES" : @"NO");
    
    NSDecimalNumber *totalFee = values[SSWidgetViewTotalFeeKey];
    if (totalFee) {
        NSLog(@"Total fee: %@", totalFee.stringValue);
    }
    
    NSError *error = values[SSWidgetViewErrorKey];
    if (error) {
        NSLog(@"Widget error: %@", error.localizedDescription);
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:textField.text];
    if (decimalNumber) {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                  scale:2
                                                                                       raiseOnExactness:NO
                                                                                        raiseOnOverflow:NO
                                                                                       raiseOnUnderflow:NO
                                                                                    raiseOnDivideByZero:NO];
        
        NSDecimalNumber *roundedNumber = [decimalNumber decimalNumberByRoundingAccordingToBehavior:behavior];
        NSLog(@"Request offers fee for order value %@", roundedNumber.stringValue);
        textField.text = [NSString stringWithFormat:@"%.2f", roundedNumber.doubleValue];
        [_widgetView updateOrderValue:roundedNumber];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid amount" message:@"Please input a valid amount for order value." preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Customization

- (IBAction)displayLearnMoreModal:(id)sender
{
    self.configuration.type = ShippedSuiteTypeGreen;
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithConfiguration:self.configuration];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        nav.preferredContentSize = CGSizeMake(650, 600);
    }
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)sendOffersFeeRequest:(id)sender
{
    NSLog(@"Request offers fee");
    [ShippedSuite getOffersFee:[[NSDecimalNumber alloc] initWithString:_textField.text] completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to get offers fee: %@", error.localizedDescription);
            return;
        }
        
        NSLog(@"Get shield fee: %@", offers.shieldFee.stringValue);
        NSLog(@"Get green fee: %@", offers.greenFee.stringValue);
    }];
}

@end
