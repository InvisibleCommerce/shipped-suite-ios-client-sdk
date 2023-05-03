//
//  SSWidgetView.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSWidgetView.h"
#import "ShippedSuite+Configuration.h"
#import "SSUtils.h"
#import "ShippedSuite+API.h"
#import "SSLearnMoreViewController.h"

// Callback Keys
NSString * const SSWidgetViewIsSelectedKey = @"isSelected";
NSString * const SSWidgetViewTotalFeeKey = @"totalFee";
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
@property (nonatomic, strong, nullable) SSOffers *offers;
@property (nonatomic, strong) NSLayoutConstraint *containerLeftConstraint, *learnMoreRightToLeftOfFeeConstraint, *learnMoreRightToEdgeOfContentConstraint;
@property (nonatomic, strong) NSArray *learnMoreAlignLeftConstraints, *learnMoreAlignRightConstraints;

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
    _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_titleLabel];
    
    NSAttributedString *learnMore = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Learn More", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    
    _learnMoreButton = [UIButton new];
    [_learnMoreButton setAttributedTitle:learnMore forState:UIControlStateNormal];
    _learnMoreButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    [_learnMoreButton addTarget:self action:@selector(displayLearnMoreModal) forControlEvents:UIControlEventTouchUpInside];
    _learnMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_learnMoreButton];
    
    _feeLabel = [UILabel new];
    _feeLabel.text = NA;
    _feeLabel.textAlignment = NSTextAlignmentNatural;
    _feeLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _feeLabel.adjustsFontSizeToFitWidth = YES;
    _feeLabel.minimumScaleFactor = 0.6;
    _feeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_feeLabel];
    
    _descLabel = [UILabel new];
    _descLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_descLabel];
    
    [self updateTexts];
    [self updateAppearance];
}

- (void)updateAppearance
{
    self.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor titleColorFor:self.configuration.appearance];
    [_learnMoreButton setTitleColor:[UIColor learnMoreColorFor:self.configuration.appearance] forState:UIControlStateNormal];
    _feeLabel.textColor = [UIColor feeColorFor:self.configuration.appearance];
    _descLabel.textColor = [UIColor descColorFor:self.configuration.appearance];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[switchButton]-4-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView(31)]" options:0 metrics:metrics views:views]];
    [_imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_imageView.heightAnchor constraintEqualToConstant:31].active = YES;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:metrics views:views]];
    
    self.learnMoreAlignLeftConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-hSpace-[learnMoreButton]->=hSpace-[feeLabel]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views];
    [self.containerView addConstraints:self.learnMoreAlignLeftConstraints];
    self.learnMoreAlignRightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]->=hSpace-[learnMoreButton]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views];
    [self.containerView addConstraints:self.learnMoreAlignRightConstraints];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descLabel]|" options:0 metrics:metrics views:views]];
    [_titleLabel.topAnchor constraintEqualToAnchor:_containerView.topAnchor constant:3].active = YES;
    [_descLabel.bottomAnchor constraintEqualToAnchor:_containerView.bottomAnchor constant:-3].active = YES;
    
    [self hideFeeIfInformational:NO];
    [self hideToggleIfMandatory:NO isInformational:NO];
}

- (void)setConfiguration:(ShippedSuiteConfiguration *)configuration
{
    _configuration = configuration;
    [self updateTexts];
    [self updateAppearance];
    [self hideToggleIfMandatory:configuration.isMandatory isInformational:configuration.isInformational];
    [self hideFeeIfInformational:configuration.isInformational];
}

- (void)updateTexts
{
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedSuite_ShippedSuite" ofType:@"bundle"]];
    switch (self.configuration.type) {
        case ShippedSuiteTypeGreen:
            _titleLabel.text = NSLocalizedString(@"Shipped Green", nil);
            _descLabel.text = NSLocalizedString(@"Carbon Neutral Shipment for the Earth", nil);
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

- (void)hideToggleIfMandatory:(BOOL)isMandatory isInformational:(BOOL)isInformational
{
    if (isMandatory || isInformational) {
        self.switchButton.hidden = YES;
        self.imageView.hidden = NO;
        self.containerLeftConstraint.constant = 43;
    } else {
        self.switchButton.hidden = NO;
        self.imageView.hidden = YES;
        self.containerLeftConstraint.constant = 63;
    }
    if (isMandatory) {
        self.switchButton.on = YES;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)hideFeeIfInformational:(BOOL)isInformational
{
    if (isInformational) {
        self.feeLabel.hidden = YES;
        [NSLayoutConstraint deactivateConstraints:self.learnMoreAlignLeftConstraints];
        [NSLayoutConstraint activateConstraints:self.learnMoreAlignRightConstraints];
    } else {
        self.feeLabel.hidden = NO;
        [NSLayoutConstraint deactivateConstraints:self.learnMoreAlignRightConstraints];
        [NSLayoutConstraint activateConstraints:self.learnMoreAlignLeftConstraints];
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)setOffers:(SSOffers *)offers
{
    _offers = offers;
    self.configuration.isMandatory = offers.isMandatory || self.configuration.isMandatory;
    [self updateWidgetIfConfigsMismatch:offers];
    [self hideToggleIfMandatory:self.configuration.isMandatory isInformational:self.configuration.isInformational];
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
    [ShippedSuite getOffersFee:orderValue currency:self.configuration.currency completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            [strongSelf updateWidgetIfError:error];
            return;
        }
        
        strongSelf.offers = offers;
    }];
}

- (void)updateWidgetIfConfigsMismatch:(SSOffers *)offers
{
    BOOL shouldUpdate = NO;
    BOOL isShield = self.configuration.type == ShippedSuiteTypeShield || self.configuration.type == ShippedSuiteTypeGreenAndShield;
    BOOL isGreen = self.configuration.type == ShippedSuiteTypeGreen || self.configuration.type == ShippedSuiteTypeGreenAndShield;
    
    if (isShield && !offers.isShieldAvailable) {
        isShield = NO;
        shouldUpdate = YES;
    } else if (!isShield && offers.isShieldAvailable && self.configuration.isRespectServer) {
        isShield = YES;
        shouldUpdate = YES;
    }
    
    if (isGreen && !offers.isGreenAvailable) {
        isGreen = NO;
        shouldUpdate = YES;
    } else if (!isGreen && offers.isGreenAvailable && self.configuration.isRespectServer) {
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
            self.configuration.type = ShippedSuiteTypeShield;
        } else if (!isShield && isGreen) {
            self.configuration.type = ShippedSuiteTypeGreen;
        } else if (isShield && isGreen) {
            self.configuration.type = ShippedSuiteTypeGreenAndShield;
        } else {
            self.configuration.type = ShippedSuiteTypeShield;
        }
        [self updateTexts];
    }
    
    self.feeLabel.text = NA;
    
    switch (self.configuration.type) {
        case ShippedSuiteTypeGreen:
            if (offers.greenFee) {
                self.feeLabel.text = offers.greenFeeWithCurrency.formatted;
            }
            break;
        case ShippedSuiteTypeShield:
            if (offers.shieldFee) {
                self.feeLabel.text = offers.shieldFeeWithCurrency.formatted;
            }
            break;
        case ShippedSuiteTypeGreenAndShield:
            if (offers.greenFee && offers.shieldFee) {
                SSCurrency *currency = offers.shieldFeeWithCurrency.currency;
                NSString *space = currency.symbol.length > 2 ? @" " : @"";
                NSInteger fractionDigits = round(log(currency.subunitToUnit.doubleValue) / log(10));
                NSDecimalNumber *totalFee = [offers.shieldFee decimalNumberByAdding:offers.greenFee];
                self.feeLabel.text = [totalFee currencyStringWithSymbol:currency.symbol
                                                                   code:currency.isoCode
                                                                  space:space
                                                       decimalSeparator:currency.decimalMark
                                                  usesGroupingSeparator:currency.thousandsSeparator != nil
                                                      groupingSeparator:currency.thousandsSeparator
                                                         fractionDigits:fractionDigits
                                                            symbolFirst:currency.symbolFirst];
            }
            break;
    }
    
    [self triggerWidgetChangeWithError:nil];
}

- (void)updateWidgetIfError:(NSError *)error
{
    self.feeLabel.text = NA;
    [self triggerWidgetChangeWithError:error];
}

- (void)triggerWidgetChangeWithError:(nullable NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(widgetView:onChange:)]) {
        NSMutableDictionary *values = [NSMutableDictionary dictionaryWithObject:@(_switchButton.isOn) forKey:SSWidgetViewIsSelectedKey];
        if (self.configuration.type == ShippedSuiteTypeShield && self.offers.shieldFee) {
            values[SSWidgetViewTotalFeeKey] = self.offers.shieldFee;
        }
        if (self.configuration.type == ShippedSuiteTypeGreen && self.offers.greenFee) {
            values[SSWidgetViewTotalFeeKey] = self.offers.greenFee;
        }
        if (self.configuration.type == ShippedSuiteTypeGreenAndShield && self.offers.shieldFee && self.offers.greenFee) {
            values[SSWidgetViewTotalFeeKey] = [self.offers.shieldFee decimalNumberByAdding:self.offers.greenFee];
        }
        if (error) {
            values[SSWidgetViewErrorKey] = error;
        }
        [self.delegate widgetView:self onChange:values];
    }
}

- (void)displayLearnMoreModal
{
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithConfiguration:self.configuration];
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

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateAppearance];
}

@end
