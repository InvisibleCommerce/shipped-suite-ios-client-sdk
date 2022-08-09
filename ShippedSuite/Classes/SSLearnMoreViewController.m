//
//  SSLearnMoreViewController.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSLearnMoreViewController.h"
#import <SafariServices/SafariServices.h>
#import "SSUtils.h"

@interface SSLearnMoreViewController () <UITextViewDelegate>

@property (nonatomic) ShippedSuiteType type;

@end

@implementation SSLearnMoreViewController

- (instancetype)initWithType:(ShippedSuiteType)type
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    UIView *contentView = [UIView new];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:contentView];
    
    UIView *headerView = [self headerView];
    headerView.backgroundColor = [UIColor colorWithHex:0x000000];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:headerView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleText;
    titleLabel.textColor = [UIColor colorWithHex:0x000000];
    titleLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightBold];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    
    UILabel *subtitleLabel = [UILabel new];
    subtitleLabel.text = self.subtitleText;
    subtitleLabel.textColor = [UIColor colorWithHex:0x000000];
    subtitleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:subtitleLabel];
    
    UIView *tipsView = [self tipsView];
    tipsView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:tipsView];
    
    UIView *bannerView = [self bannerView];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:bannerView];
    
    UIView *actionView = [self actionView];
    actionView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:actionView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(scrollView, contentView, headerView, titleLabel, subtitleLabel, tipsView, bannerView, actionView);
    
    NSDictionary *metrics = @{@"topPadding": UIDevice.isIpad ? @56: @50,
                              @"margin": @16,
                              @"vSpace": @24,
                              @"vSectionSpace": @32};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:metrics views:views]];
    [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView(scrollView)]|" options:0 metrics:metrics views:views]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:metrics views:views]];
    
    NSLayoutConstraint *heightConstraint = [contentView.heightAnchor constraintEqualToAnchor:scrollView.heightAnchor];
    heightConstraint.priority = UILayoutPriorityDefaultLow;
    heightConstraint.active = YES;
    
    [tipsView.widthAnchor constraintEqualToAnchor:contentView.widthAnchor multiplier:327.0 / 375.0].active = YES;
    [tipsView.centerXAnchor constraintEqualToAnchor:contentView.centerXAnchor].active = YES;
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView(88)]-vSpace-[titleLabel]" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[titleLabel]-margin-|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-vSpace-[subtitleLabel]" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bannerView]|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[actionView]|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subtitleLabel]-vSectionSpace-[tipsView]-vSectionSpace-[bannerView]->=0-[actionView]|" options:0 metrics:metrics views:views]];
}

- (NSString *)logoName
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return @"green_logo";
        case ShippedSuiteTypeShield:
            return @"shield_logo";
        case ShippedSuiteTypeGreenAndShield:
            return @"green+shield_logo";
    }
}

- (NSString *)titleText
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return NSLocalizedString(@"Shipped Green Carbon Neutral Shipment", nil);
        case ShippedSuiteTypeShield:
            return NSLocalizedString(@"Shipped Shield Premium Package Assurance", nil);
        case ShippedSuiteTypeGreenAndShield:
            return NSLocalizedString(@"Sustainable Package Assurance", nil);
        default:
            break;
    }
}

- (NSString *)subtitleText
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return NSLocalizedString(@"Fight climate change while supporting sustainable shopping", nil);
        case ShippedSuiteTypeShield:
            return NSLocalizedString(@"Have peace of mind and instantly resolve unexpected issues hassle-free", nil);
        case ShippedSuiteTypeGreenAndShield:
            return NSLocalizedString(@"Protect your order with premium package assurance and carbon neutral shipment", nil);
        default:
            break;
    }
}

- (NSString *)tip0Text
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return NSLocalizedString(@"Neutralize the carbon emissions from delivering this order.", nil);
        default:
            return NSLocalizedString(@"Instant premium package assurance for damage, loss, or theft.", nil);
    }
}

- (NSString *)tip1Text
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return NSLocalizedString(@"Get certified carbon credits recorded at the project carbon registry.", nil);
        default:
            return NSLocalizedString(@"Save time and headache reporting unexpected shipment issues.", nil);
    }
}

- (NSString *)tip2Text
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return NSLocalizedString(@"Track your certificates and see your personal climate impact.", nil);
        default:
            return NSLocalizedString(@"Easily resolve issues and get a replacement or refund, hassle-free.", nil);
    }
}

- (nullable NSString *)bannerName
{
    switch (self.type) {
        case ShippedSuiteTypeGreen:
            return @"green_banner";
        case ShippedSuiteTypeGreenAndShield:
            return @"green+shield_banner";
        default:
            return nil;
    }
}

- (UIView *)headerView
{
    UIView *headerView = [UIView new];
    
    UIImageView *logoImageView = [UIImageView new];
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedSuite_ShippedSuite" ofType:@"bundle"]];
    logoImageView.image = [UIImage imageNamed:[self logoName] inBundle:resourceBundle compatibleWithTraitCollection:nil];
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:logoImageView];
    
    [headerView.centerXAnchor constraintEqualToAnchor:logoImageView.centerXAnchor].active = YES;
    [headerView.centerYAnchor constraintEqualToAnchor:logoImageView.centerYAnchor].active = YES;
    
    return headerView;
}

- (UIView *)protectedViewWithText:(NSString *)text
{
    UIView *contentView = [UIView new];
    
    UILabel *tickLabel = [UILabel new];
    tickLabel.text = @"✓";
    tickLabel.textColor = [UIColor colorWithHex:0x32BA7C];
    tickLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    tickLabel.numberOfLines = 0;
    tickLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:tickLabel];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = text;
    titleLabel.textColor = [UIColor colorWithHex:0x000000];
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(tickLabel, titleLabel);
    
    NSDictionary *metrics = @{@"hSpace": @8};
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tickLabel(15)]-hSpace-[titleLabel]|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
    
    return contentView;
}

- (UIView *)bannerView
{
    UIImageView *bannerView = [UIImageView new];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedSuite_ShippedSuite" ofType:@"bundle"]];
    bannerView.image = [UIImage imageNamed:[self bannerName] inBundle:resourceBundle compatibleWithTraitCollection:nil];
    
    if (self.type == ShippedSuiteTypeGreen) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewFullProjectStory:)];
        [bannerView addGestureRecognizer:tap];
        bannerView.userInteractionEnabled = YES;
    }
    
    return bannerView;
}

- (UIView *)tipsView
{
    UIView *tipsView = [UIView new];
    
    UIView *protectedFirstTipView = [self protectedViewWithText:self.tip0Text];
    protectedFirstTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedFirstTipView];
    
    UIView *protectedSecondTipView = [self protectedViewWithText:self.tip1Text];
    protectedSecondTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedSecondTipView];
    
    UIView *protectedThirdTipView = [self protectedViewWithText:self.tip2Text];
    protectedThirdTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedThirdTipView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(protectedFirstTipView, protectedSecondTipView, protectedThirdTipView);
    
    NSDictionary *metrics = @{@"vSpace": @24,
                              @"tipHeight": @40};
    
    [tipsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[protectedFirstTipView]|" options:0 metrics:metrics views:views]];
    [tipsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[protectedFirstTipView(tipHeight)]-vSpace-[protectedSecondTipView(tipHeight)]-vSpace-[protectedThirdTipView(tipHeight)]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
    
    return tipsView;
}

- (UIButton *)linkButtonWithText:(NSString *)text selector:(nullable SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
    [button setTitleColor:[UIColor colorWithHex:0x888888] forState:UIControlStateNormal];
    if (selector) {
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

- (UIView *)separator
{
    UIView *separator = [UIView new];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    [separator.widthAnchor constraintEqualToConstant:0.5].active = YES;
    [separator.heightAnchor constraintEqualToConstant:14].active = YES;
    separator.backgroundColor = [UIColor colorWithHex:0x888888];
    return separator;
}

- (UIStackView *)termsView
{
    UIStackView *hStackView = [UIStackView new];
    hStackView.distribution = UIStackViewDistributionEqualSpacing;
    hStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.type == ShippedSuiteTypeGreen) {
        UIButton *download = [self linkButtonWithText:NSLocalizedString(@"Download Shipped", nil) selector:@selector(downloadPressed:)];
        [hStackView addArrangedSubview:download];
    } else {
        UIButton *reportAnIssue = [self linkButtonWithText:NSLocalizedString(@"Report an Issue", nil) selector:@selector(reportAnIssuePressed:)];
        [hStackView addArrangedSubview:reportAnIssue];
    }
    
    UIView *separator0 = [self separator];
    [hStackView addArrangedSubview:separator0];
    
    UIButton *termsOfService = [self linkButtonWithText:NSLocalizedString(@"Terms of Service", nil) selector:@selector(termsOfServicePressed:)];
    [hStackView addArrangedSubview:termsOfService];
    
    UIView *separator1 = [self separator];
    [hStackView addArrangedSubview:separator1];
    
    UIButton *privacyPolicy = [self linkButtonWithText:NSLocalizedString(@"Privacy Policy", nil) selector:@selector(privacyPolicyPressed:)];
    [hStackView addArrangedSubview:privacyPolicy];
    
    UIStackView *vStackView = [UIStackView new];
    vStackView.axis = UILayoutConstraintAxisVertical;
    vStackView.distribution = UIStackViewDistributionFillEqually;
    vStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [vStackView addArrangedSubview:hStackView];
    
    UIButton *copyRight = [self linkButtonWithText:NSLocalizedString(@"Invisible Commerce Limited 2021", nil) selector:nil];
    [vStackView addArrangedSubview:copyRight];
    
    return vStackView;
}

- (UIView *)actionView
{
    UIView *actionView = [UIView new];
    if (self.type == ShippedSuiteTypeShield) {
        actionView.backgroundColor = [UIColor colorWithHex:0xF4F4F5];
    }
    
    UIView *containerView = [UIView new];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [actionView addSubview:containerView];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.minimumLineHeight = 16;
    paragraphStyle.maximumLineHeight = 16;
    
    NSMutableDictionary *attributes = [@{
        NSFontAttributeName: [UIFont systemFontOfSize:12 weight:UIFontWeightRegular],
        NSForegroundColorAttributeName: [UIColor colorWithHex:0x8A8A8D],
        NSParagraphStyleAttributeName: paragraphStyle
    } mutableCopy];
    NSMutableAttributedString *desc = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Shipped offers carbon offsets, shipment protection with tracking services and hassle-free solutions for resolving shipment issues for online purchases that are damaged in transit, lost by the carrier, or stolen immediately after the carrier’s proof of delivery where Shipped monitors the shipment.", nil) attributes:attributes];
    
    UITextView *descView = [UITextView new];
    descView.delegate = self;
    descView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithHex:0x8A8A8D]};
    descView.backgroundColor = [UIColor clearColor];
    descView.contentInset = UIEdgeInsetsZero;
    descView.textContainerInset = UIEdgeInsetsZero;
    descView.attributedText = desc;
    descView.editable = NO;
    descView.scrollEnabled = NO;
    descView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:descView];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHex:0xC1C1C1];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:line];
    
    UIView *termsView = [self termsView];
    [containerView addSubview:termsView];
    
    UIButton *closeButton = [UIButton new];
    closeButton.layer.cornerRadius = 10;
    closeButton.layer.masksToBounds = YES;
    closeButton.backgroundColor = [UIColor colorWithHex:0xFFC933];
    [closeButton setTitle:NSLocalizedString(@"Got it!", nil) forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:closeButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(containerView, descView, line, termsView, closeButton);
    
    NSDictionary *metrics = @{@"hSpace": UIDevice.isIpad ? @120 : @24,
                              @"vSpace": @24,
                              @"leftPadding": UIDevice.isIpad ? @16 : @0,
                              @"bottomPadding": @(24 + (UIDevice.isIpad ? 0 : UIWindow.safeAreaInsets.bottom))
    };
    
    [actionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpace-[containerView]-hSpace-|" options:0 metrics:metrics views:views]];
    [actionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpace-[containerView]-bottomPadding-|" options:0 metrics:metrics views:views]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descView]|" options:0 metrics:metrics views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[line]|" options:0 metrics:metrics views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[termsView]-45-|" options:0 metrics:metrics views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftPadding-[closeButton]-leftPadding-|" options:0 metrics:metrics views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[descView]-16-[line(0.5)]-16-[termsView(28)]-16-[closeButton(50)]|" options:0 metrics:metrics views:views]];
    
    return actionView;
}

- (void)presentSafariModal:(NSURL *)URL
{
    SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:URL];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)downloadPressed:(id)sender
{
    [self presentSafariModal:[NSURL URLWithString:@"https://www.shippedapp.co"]];
}

- (void)reportAnIssuePressed:(id)sender
{
    [self presentSafariModal:[NSURL URLWithString:@"http://app.shippedapp.co/claim"]];
}

- (void)termsOfServicePressed:(id)sender
{
    [self presentSafariModal:[NSURL URLWithString:@"https://www.invisiblecommerce.com/terms"]];
}

- (void)privacyPolicyPressed:(id)sender
{
    [self presentSafariModal:[NSURL URLWithString:@"https://www.invisiblecommerce.com/privacy"]];
}

- (void)viewFullProjectStory:(UITapGestureRecognizer *)gesture
{
    [self presentSafariModal:[NSURL URLWithString:@"https://www.shippedapp.co"]];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
}

@end
