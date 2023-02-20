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

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SSWidgetViewConfiguration *configuration = [SSWidgetViewConfiguration new];
    configuration.type = ShippedSuiteTypeShield;
    configuration.isInformational = YES;
    configuration.isMandatory = NO;
    configuration.isRespectServer = NO;
    _widgetView.configuration = configuration;
    _widgetView.delegate = self;
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
    
    NSDecimalNumber *shieldFee = values[SSWidgetViewShieldFeeKey];
    if (shieldFee) {
        NSLog(@"Shield fee: %@", shieldFee.stringValue);
    }
    
    NSDecimalNumber *greenFee = values[SSWidgetViewGreenFeeKey];
    if (greenFee) {
        NSLog(@"Green fee: %@", greenFee.stringValue);
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
    SSConfiguration *configuration = [SSConfiguration new];
    configuration.type = ShippedSuiteTypeGreen;
    configuration.isInformational = NO;
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithConfiguration:configuration];    
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
