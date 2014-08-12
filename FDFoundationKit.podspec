Pod::Spec.new do |s|

  s.name = "FDFoundationKit"
  s.version = "0.1.0"
  s.summary = "1414 Degrees' extension on Foundation Kit."
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.homepage = "https://github.com/reidmain/FDFoundationKit"
  s.author = "Reid Main"
  s.social_media_url = "http://twitter.com/reidmain"

  s.platform = :ios, "7.0"
  s.source = { :git => "https://github.com/reidmain/FDFoundationKit.git", :tag => s.version }
  s.source_files = "FDFoundationKit/**/*.{h,m}", "Static Library Project/FDFoundationKit Static Library/FDFoundationKit.h"
  s.framework  = "Foundation"
  s.requires_arc = true
end
