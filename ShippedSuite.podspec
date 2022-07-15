#
# Be sure to run `pod lib lint ShippedSuite.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'ShippedSuite'
    s.version          = '0.1.0'
    s.summary          = 'Integrate ShippedSuite into your iOS app.'
    s.homepage         = 'https://github.com/InvisibleCommerce/shipped-suite-ios-client-sdk'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = 'Invisible Commerce'
    s.source           = { :git => 'https://github.com/InvisibleCommerce/shipped-suite-ios-client-sdk.git', :tag => s.version.to_s }
    s.platform         = :ios
    s.ios.deployment_target = '11.0'
    s.source_files     = 'ShippedSuite/Classes/**/*'
    s.resource_bundles = {
        'ShippedSuite_ShippedSuite' => ['ShippedSuite/Assets/*.xcassets']
    }
    s.public_header_files = 'ShippedSuite/Classes/**/*.h'
    s.frameworks       = 'Foundation', 'UIKit'
end
