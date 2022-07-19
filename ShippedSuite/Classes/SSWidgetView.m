//
//  SSWidgetView.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSWidgetView.h"
#import "SSUtils.h"
#import "ShippedSuite+API.h"
#import "SSLearnMoreViewController.h"

// Callback Keys
NSString * const SSWidgetViewIsEnabledKey = @"isEnabled";
NSString * const SSWidgetViewShieldFeeKey = @"shieldFee";
NSString * const SSWidgetViewGreenFeeKey = @"greenFee";
NSString * const SSWidgetViewErrorKey = @"error";

// UserDefaults Keys
NSString * const SSUserDefaultsIsWidgetEnabledKey = @"SSUserDefaultsIsWidgetEnabledKey";

@interface SSWidgetView ()

@property (nonatomic, strong) UISwitch *shieldSwitch;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *learnMoreButton;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong, nullable) NSDecimalNumber *shieldFee;
@property (nonatomic, strong, nullable) NSDecimalNumber *greenFee;

@end

@implementation SSWidgetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
        [self loadLayoutConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if ([super initWithCoder:coder]) {
        [self loadViews];
        [self loadLayoutConstraints];
    }
    return self;
}

- (void)loadViews
{
    _shieldSwitch = [UISwitch new];
    _shieldSwitch.accessibilityLabel = NSLocalizedString(@"Shield switch", nil);
    _shieldSwitch.on = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SSUserDefaultsIsWidgetEnabledKey]) {
        _shieldSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:SSUserDefaultsIsWidgetEnabledKey];
    }
    [_shieldSwitch addTarget:self action:@selector(shieldStateChanged:) forControlEvents:UIControlEventValueChanged];
    _shieldSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_shieldSwitch];
    
    _containerView = [UIView new];
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_containerView];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithHex:0x1A1A1A];
    _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_titleLabel];
    
    NSAttributedString *learnMore = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Learn More", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    
    _learnMoreButton = [UIButton new];
    [_learnMoreButton setAttributedTitle:learnMore forState:UIControlStateNormal];
    [_learnMoreButton setTitleColor:[UIColor colorWithHex:0x4D4D4D] forState:UIControlStateNormal];
    _learnMoreButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    [_learnMoreButton addTarget:self action:@selector(displayLearnMoreModal) forControlEvents:UIControlEventTouchUpInside];
    _learnMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_learnMoreButton];
    
    _feeLabel = [UILabel new];
    _feeLabel.text = NSLocalizedString(@"N/A", nil);
    _feeLabel.textColor = [UIColor colorWithHex:0x1A1A1A];
    _feeLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _feeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_feeLabel];
    
    _descLabel = [UILabel new];
    _descLabel.textColor = [UIColor colorWithHex:0x4D4D4D];
    _descLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_descLabel];
}

- (void)loadLayoutConstraints
{
    NSDictionary *views = @{@"shieldSwitch": _shieldSwitch,
                            @"containerView": _containerView,
                            @"titleLabel": _titleLabel,
                            @"learnMoreButton": _learnMoreButton,
                            @"feeLabel": _feeLabel,
                            @"descLabel": _descLabel};
    
    NSDictionary *metrics = @{@"margin": @12,
                              @"hSpace": @8,
                              @"vSpace": @2};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shieldSwitch(51)]-margin-[containerView]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[shieldSwitch]|" options:0 metrics:metrics views:views]];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-hSpace-[learnMoreButton]->=hSpace-[feeLabel]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descLabel]|" options:0 metrics:metrics views:views]];
    
    [_titleLabel.topAnchor constraintEqualToAnchor:_containerView.topAnchor constant:-2.5].active = YES;
    [_descLabel.bottomAnchor constraintEqualToAnchor:_containerView.bottomAnchor constant:3].active = YES;
}

- (void)setOffers:(SSWidgetViewOffers)offers
{
    _offers = offers;
    switch (offers) {
        case SSWidgetViewGreenOffers:
            _titleLabel.text = NSLocalizedString(@"Shipped Green", nil);
            _descLabel.text = NSLocalizedString(@"Carbon Neutral Shipment", nil);
            break;
        case SSWidgetViewShieldOffers:
            _titleLabel.text = NSLocalizedString(@"Shipped Shield", nil);
            _descLabel.text = NSLocalizedString(@"Package Assurance for unexpected issues", nil);
            break;
        case SSWidgetViewGreenAndShieldOffers:
            _titleLabel.text = NSLocalizedString(@"Shipped Green + Shield", nil);
            _descLabel.text = NSLocalizedString(@"Carbon Offset + Package Assurance", nil);
            break;
        default:
            break;
    }
}

- (void)shieldStateChanged:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:_shieldSwitch.isOn forKey:SSUserDefaultsIsWidgetEnabledKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self triggerShieldChangeWithError:nil];
}

- (void)updateOrderValue:(NSDecimalNumber *)orderValue
{
    __weak __typeof(self)weakSelf = self;
    [ShippedSuite getOffersFee:orderValue completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            strongSelf.feeLabel.text = NSLocalizedString(@"N/A", nil);
            strongSelf.shieldFee = nil;
            [strongSelf triggerShieldChangeWithError:error];
            return;
        }
        
        switch (self.offers) {
            case SSWidgetViewGreenOffers:
                strongSelf.feeLabel.text = [NSString stringWithFormat:@"$%@", offers.greenFee.stringValue];
                break;
            case SSWidgetViewShieldOffers:
                strongSelf.feeLabel.text = [NSString stringWithFormat:@"$%@", offers.shieldFee.stringValue];
                break;
            case SSWidgetViewGreenAndShieldOffers:
                strongSelf.feeLabel.text = [NSString stringWithFormat:@"$%@", [offers.shieldFee decimalNumberByAdding:offers.greenFee].stringValue];
                break;
            default:
                break;
        }
        
        strongSelf.shieldFee = offers.shieldFee;
        strongSelf.greenFee = offers.greenFee;
        [strongSelf triggerShieldChangeWithError:nil];
    }];
}

- (void)triggerShieldChangeWithError:(nullable NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(widgetView:onChange:)]) {
        NSMutableDictionary *values = [NSMutableDictionary dictionaryWithObject:@(_shieldSwitch.isOn) forKey:SSWidgetViewIsEnabledKey];
        if ((self.offers == SSWidgetViewShieldOffers || self.offers == SSWidgetViewGreenAndShieldOffers) && _shieldFee) {
            values[SSWidgetViewShieldFeeKey] = _shieldFee;
        }
        if ((self.offers == SSWidgetViewGreenOffers || self.offers == SSWidgetViewGreenAndShieldOffers) && _greenFee) {
            values[SSWidgetViewGreenFeeKey] = _greenFee;
        }
        if (error) {
            values[SSWidgetViewErrorKey] = error;
        }
        [self.delegate widgetView:self onChange:values];
    }
}

- (void)displayLearnMoreModal
{
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    if ([UIDevice isIpad]) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        nav.preferredContentSize = CGSizeMake(650, 600);
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window) {
        UIViewController *rootViewController = window.rootViewController;
        [rootViewController presentViewController:nav animated:YES completion:nil];
    } else {
        NSLog(@"Can't find the rootViewController.");
    }
}

@end
