Pod::Spec.new do |s|
  s.name                  = "AESHelper"
  s.version               = "1.1.1"
  s.license               = "MIT"
  s.summary               = "AES Decryptor for iOS and OS X "
  s.homepage              = "https://github.com/quver/AESHelper"
  s.author                = { "Pawel Bednorz" => "pawel@quver.pl" }
  s.social_media_url      = "https://twitter.com/plquver"
  s.source                = { :git => "https://github.com/quver/AESHelper.git", :tag => s.version }
  s.public_header_files   = "AESHelper.h"
  s.source_files          = "AESHelper.h"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.requires_arc = true
end
