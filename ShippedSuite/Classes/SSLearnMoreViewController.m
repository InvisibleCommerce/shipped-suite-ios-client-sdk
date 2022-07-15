//
//  SSLearnMoreViewController.m
//  ShippedSuite
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSLearnMoreViewController.h"
#import "SSUtils.h"

@interface SSLearnMoreViewController ()

@end

@implementation SSLearnMoreViewController

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
    titleLabel.text = NSLocalizedString(@"Shipped Shield Premium Package Assurance", nil);
    titleLabel.textColor = [UIColor colorWithHex:0x000000];
    titleLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightBold];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    
    UILabel *subtitleLabel = [UILabel new];
    subtitleLabel.text = NSLocalizedString(@"Have peace of mind and instantly resolve unexpected issues hassle-free.", nil);
    subtitleLabel.textColor = [UIColor colorWithHex:0x000000];
    subtitleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:subtitleLabel];
    
    UIView *tipsView = [self tipsView];
    tipsView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:tipsView];
    
    UIView *actionView = [self actionView];
    actionView.backgroundColor = [UIColor colorWithHex:0x13747480];
    actionView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:actionView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(scrollView, contentView, headerView, titleLabel, subtitleLabel, tipsView, actionView);
    
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
    
    [tipsView.widthAnchor constraintEqualToAnchor:contentView.widthAnchor multiplier:311.0 / 375.0].active = YES;
    [tipsView.centerXAnchor constraintEqualToAnchor:contentView.centerXAnchor].active = YES;
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView(88)]-vSpace-[titleLabel]" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[titleLabel]-margin-|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-vSpace-[subtitleLabel]" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[actionView]|" options:0 metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subtitleLabel]-vSectionSpace-[tipsView]->=vSectionSpace-[actionView]|" options:0 metrics:metrics views:views]];
}

- (UIView *)headerView
{
    UIView *headerView = [UIView new];
    
    UIImageView *logoImageView = [UIImageView new];
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedSuite_ShippedSuite" ofType:@"bundle"]];
    logoImageView.image = [UIImage imageNamed:@"header" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:logoImageView];
    
    [headerView.centerXAnchor constraintEqualToAnchor:logoImageView.centerXAnchor].active = YES;
    [headerView.centerYAnchor constraintEqualToAnchor:logoImageView.centerYAnchor].active = YES;
    
    return headerView;
}

- (UIView *)protectedViewWithText:(NSString *)text
{
    UIView *contentView = [UIView new];
    
    UIImageView *protectedImageView = [UIImageView new];
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedSuite_ShippedSuite" ofType:@"bundle"]];
    protectedImageView.image = [UIImage imageNamed:@"protected" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    protectedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:protectedImageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = text;
    titleLabel.textColor = [UIColor colorWithHex:0x000000];
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(protectedImageView, titleLabel);
    
    CGFloat imageSize = 32.0;
    NSDictionary *metrics = @{@"imageSize": @(imageSize),
                              @"hSpace": @12};
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[protectedImageView(imageSize)]-hSpace-[titleLabel]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [protectedImageView.heightAnchor constraintEqualToConstant:imageSize].active = YES;
    [protectedImageView.centerYAnchor constraintEqualToAnchor:contentView.centerYAnchor].active = YES;
    
    return contentView;
}

- (UIView *)tipsView
{
    UIView *tipsView = [UIView new];
    
    UIView *protectedFirstTipView = [self protectedViewWithText:NSLocalizedString(@"Instant premium package assurance for damage, loss, or theft.", nil)];
    protectedFirstTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedFirstTipView];
    
    UIView *protectedSecondTipView = [self protectedViewWithText:NSLocalizedString(@"Save time and headache reporting unexpected shipment issues.", nil)];
    protectedSecondTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedSecondTipView];
    
    UIView *protectedThirdTipView = [self protectedViewWithText:NSLocalizedString(@"Easily resolve issues and get a replacement or refund, hassle-free.", nil)];
    protectedThirdTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedThirdTipView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(protectedFirstTipView, protectedSecondTipView, protectedThirdTipView);
    
    NSDictionary *metrics = @{@"vSpace": @24,
                              @"tipHeight": @40};
    
    [tipsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[protectedFirstTipView]|" options:0 metrics:metrics views:views]];
    [tipsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[protectedFirstTipView(tipHeight)]-vSpace-[protectedSecondTipView(tipHeight)]-vSpace-[protectedThirdTipView(tipHeight)]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
    
    return tipsView;
}

- (UIView *)actionView
{
    UIView *actionView = [UIView new];
    
    UIView *containerView = [UIView new];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [actionView addSubview:containerView];
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = NSLocalizedString(@"Shipped offers shipment protection with tracking services and hassle-free solutions for resolving shipment issues for online purchases that are damaged in transit, lost by the carrier, or stolen immediately after the carrier’s proof of delivery where Shipped monitors the shipment.", nil);
    descLabel.textColor = [UIColor colorWithHex:0x993c3c43];
    descLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:descLabel];
    
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
    
    NSDictionary *views = NSDictionaryOfVariableBindings(containerView, descLabel, closeButton);
    
    NSDictionary *metrics = @{@"hSpace": UIDevice.isIpad ? @120 : @24,
                              @"vSpace": @24,
                              @"leftPadding": UIDevice.isIpad ? @16 : @0,
                              @"bottomPadding": @(24 + (UIDevice.isIpad ? 0 : UIWindow.safeAreaInsets.bottom))
    };
    
    [containerView.widthAnchor constraintEqualToAnchor:actionView.widthAnchor multiplier:578.0 / 812.0].active = YES;
    [containerView.centerXAnchor constraintEqualToAnchor:actionView.centerXAnchor].active = YES;
    [actionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpace-[containerView]-bottomPadding-|" options:0 metrics:metrics views:views]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descLabel]|" options:0 metrics:metrics views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftPadding-[closeButton]-leftPadding-|" options:0 metrics:metrics views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[descLabel]-vSpace-[closeButton(50)]|" options:0 metrics:metrics views:views]];
    
    return actionView;
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
