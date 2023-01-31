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
NSString * const SSWidgetViewIsSelectedKey = @"isSelected";
NSString * const SSWidgetViewShieldFeeKey = @"shieldFee";
NSString * const SSWidgetViewGreenFeeKey = @"greenFee";
NSString * const SSWidgetViewErrorKey = @"error";

// UserDefaults Keys
NSString * const SSUserDefaultsIsWidgetEnabledKey = @"SSUserDefaultsIsWidgetEnabledKey";

// Constants
static NSString * const NA = @"N/A";

@interface SSWidgetView ()

@property (nonatomic, strong) UISwitch *switchButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *learnMoreButton;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong, nullable) NSDecimalNumber *shieldFee;
@property (nonatomic, strong, nullable) NSDecimalNumber *greenFee;
@property (nonatomic, strong) NSLayoutConstraint *containerLeftConstraint;

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
    _switchButton = [UISwitch new];
    _switchButton.accessibilityLabel = NSLocalizedString(@"Switch", nil);
    _switchButton.on = YES;
    _switchButton.hidden = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SSUserDefaultsIsWidgetEnabledKey]) {
        _switchButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:SSUserDefaultsIsWidgetEnabledKey];
    }
    [_switchButton addTarget:self action:@selector(widgetStateChanged:) forControlEvents:UIControlEventValueChanged];
    _switchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_switchButton];
    
    _imageView = [UIImageView new];
    _imageView.accessibilityLabel = NSLocalizedString(@"Logo", nil);
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
    
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
    _feeLabel.text = NA;
    _feeLabel.textColor = [UIColor colorWithHex:0x1A1A1A];
    _feeLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _feeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_feeLabel];
    
    _descLabel = [UILabel new];
    _descLabel.textColor = [UIColor colorWithHex:0x4D4D4D];
    _descLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_descLabel];
    
    self.type = ShippedSuiteTypeShield;
}

- (void)loadLayoutConstraints
{
    NSDictionary *views = @{@"switchButton": _switchButton,
                            @"imageView": _imageView,
                            @"containerView": _containerView,
                            @"titleLabel": _titleLabel,
                            @"learnMoreButton": _learnMoreButton,
                            @"feeLabel": _feeLabel,
                            @"descLabel": _descLabel};
    
    NSDictionary *metrics = @{@"margin": @12,
                              @"hSpace": @8,
                              @"vSpace": @2};
    
    self.containerLeftConstraint = [_containerView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:43];
    [_containerView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    self.containerLeftConstraint.active = YES;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[switchButton(51)]" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[switchButton]|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView(31)]" options:0 metrics:metrics views:views]];
    [_imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_imageView.heightAnchor constraintEqualToConstant:31].active = YES;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:metrics views:views]];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-hSpace-[learnMoreButton]->=hSpace-[feeLabel]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descLabel]|" options:0 metrics:metrics views:views]];
    
    [_titleLabel.topAnchor constraintEqualToAnchor:_containerView.topAnchor constant:-2.5].active = YES;
    [_descLabel.bottomAnchor constraintEqualToAnchor:_containerView.bottomAnchor constant:3].active = YES;
}

- (void)updateToggleLayoutConstraints:(SSOffers *)offers
{
    if (self.isMandatory) {
        [self hideToggleIfMandatory:YES];
        return;
    }
    
    if (offers) {
        [self hideToggleIfMandatory:offers.isMandatory];
    }
}

- (void)setType:(ShippedSuiteType)type
{
    _type = type;
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedSuite_ShippedSuite" ofType:@"bundle"]];
    switch (type) {
        case ShippedSuiteTypeGreen:
            _titleLabel.text = NSLocalizedString(@"Shipped Green", nil);
            _descLabel.text = NSLocalizedString(@"Carbon Neutral Shipment", nil);
            _imageView.image = [UIImage imageNamed:@"green_logo" inBundle:resourceBundle compatibleWithTraitCollection:nil];
            break;
        case ShippedSuiteTypeShield:
            _titleLabel.text = NSLocalizedString(@"Shipped Shield", nil);
            _descLabel.text = NSLocalizedString(@"Package Assurance for unexpected issues", nil);
            _imageView.image = [UIImage imageNamed:@"shield_logo" inBundle:resourceBundle compatibleWithTraitCollection:nil];
            break;
        case ShippedSuiteTypeGreenAndShield:
            _titleLabel.text = NSLocalizedString(@"Shipped Green + Shield", nil);
            _descLabel.text = NSLocalizedString(@"Carbon Offset + Package Assurance", nil);
            _imageView.image = [UIImage imageNamed:@"green+shield_logo" inBundle:resourceBundle compatibleWithTraitCollection:nil];
            break;
    }
}

- (void)setIsMandatory:(BOOL)isMandatory
{
    _isMandatory = isMandatory;
    if (isMandatory) {
        [self hideToggleIfMandatory:YES];
    }
}

- (void)hideToggleIfMandatory:(BOOL)isMandatory
{
    if (isMandatory) {
        self.switchButton.hidden = YES;
        self.switchButton.on = YES;
        self.imageView.hidden = NO;
        self.containerLeftConstraint.constant = 43;
    } else {
        self.switchButton.hidden = NO;
        self.imageView.hidden = YES;
        self.containerLeftConstraint.constant = 63;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)widgetStateChanged:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:_switchButton.isOn forKey:SSUserDefaultsIsWidgetEnabledKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self triggerWidgetChangeWithError:nil];
}

- (void)updateOrderValue:(NSDecimalNumber *)orderValue
{
    __weak __typeof(self)weakSelf = self;
    [ShippedSuite getOffersFee:orderValue completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            [strongSelf updateWidgetIfError:error];
            return;
        }
        
        [strongSelf updateWidgetIfConfigsMismatch:offers];
        [strongSelf updateToggleLayoutConstraints:offers];
    }];
}

- (void)updateWidgetIfConfigsMismatch:(SSOffers *)offers
{
    BOOL shouldUpdate = NO;
    BOOL isShield = self.type == ShippedSuiteTypeShield || self.type == ShippedSuiteTypeGreenAndShield;
    BOOL isGreen = self.type == ShippedSuiteTypeGreen || self.type == ShippedSuiteTypeGreenAndShield;
    
    if (isShield && !offers.isShieldAvailable) {
        isShield = NO;
        shouldUpdate = YES;
    } else if (!isShield && offers.isShieldAvailable && self.isRespectServer) {
        isShield = YES;
        shouldUpdate = YES;
    }
    
    if (isGreen && !offers.isGreenAvailable) {
        isGreen = NO;
        shouldUpdate = YES;
    } else if (!isGreen && offers.isGreenAvailable && self.isRespectServer) {
        isGreen = YES;
        shouldUpdate = YES;
    }
    
    if ((!offers.isShieldAvailable && offers.isGreenAvailable) || (offers.isShieldAvailable && !offers.isGreenAvailable)) {
        if (offers.isShieldAvailable && !isShield) {
            isShield = YES;
            isGreen = NO;
            shouldUpdate = YES;
        } else if (offers.isGreenAvailable && !isGreen) {
            isShield = NO;
            isGreen = YES;
            shouldUpdate = YES;
        }
    }
    
    if (shouldUpdate) {
        if (isShield && !isGreen) {
            self.type = ShippedSuiteTypeShield;
        } else if (!isShield && isGreen) {
            self.type = ShippedSuiteTypeGreen;
        } else if (isShield && isGreen) {
            self.type = ShippedSuiteTypeGreenAndShield;
        } else {
            self.type = ShippedSuiteTypeShield;
        }
    }
    
    self.feeLabel.text = NA;
    
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            if (offers.greenFee) {
                self.feeLabel.text = [NSString stringWithFormat:@"$%@", offers.greenFee.stringValue];
            }
            break;
        case ShippedSuiteTypeShield:
            if (offers.shieldFee) {
                self.feeLabel.text = [NSString stringWithFormat:@"$%@", offers.shieldFee.stringValue];
            }
            break;
        case ShippedSuiteTypeGreenAndShield:
            if (offers.greenFee && offers.shieldFee) {
                self.feeLabel.text = [NSString stringWithFormat:@"$%@", [offers.shieldFee decimalNumberByAdding:offers.greenFee].stringValue];
            }
            break;
    }
    
    self.shieldFee = offers.shieldFee;
    self.greenFee = offers.greenFee;
    [self triggerWidgetChangeWithError:nil];
}

- (void)updateWidgetIfError:(NSError *)error
{
    self.feeLabel.text = NA;
    self.shieldFee = nil;
    self.greenFee = nil;
    [self triggerWidgetChangeWithError:error];
}

- (void)triggerWidgetChangeWithError:(nullable NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(widgetView:onChange:)]) {
        NSMutableDictionary *values = [NSMutableDictionary dictionaryWithObject:@(_switchButton.isOn) forKey:SSWidgetViewIsSelectedKey];
        if ((self.type == ShippedSuiteTypeShield || self.type == ShippedSuiteTypeGreenAndShield) && _shieldFee) {
            values[SSWidgetViewShieldFeeKey] = _shieldFee;
        }
        if ((self.type == ShippedSuiteTypeGreen || self.type == ShippedSuiteTypeGreenAndShield) && _greenFee) {
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
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithType:self.type];
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
