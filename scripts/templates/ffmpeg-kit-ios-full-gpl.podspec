# Local override for ffmpeg-kit-ios-full-gpl 6.0.LTS.
#
# Why this file exists: the original podspec on CocoaPods trunk points to a
# GitHub release ZIP at github.com/arthenica/ffmpeg-kit/releases/.../ios-framework.zip
# which started returning 404 after Arthenica archived the project in June 2025.
#
# This podspec mirrors the same metadata but uses the pre-downloaded, pre-extracted
# .framework bundles in this directory (downloaded by the @cashify/video-optimizer-rn
# postinstall script from the library's own GitHub Release).
#
# Reference it from your Podfile via:
#   pod 'ffmpeg-kit-ios-full-gpl', :path => 'local-frameworks'

Pod::Spec.new do |s|
  s.name             = 'ffmpeg-kit-ios-full-gpl'
  s.version          = '6.0.LTS'
  s.summary          = 'FFmpeg Kit iOS Full GPL Shared Framework (local mirror)'
  s.description      = 'Pre-built FFmpeg-kit iOS frameworks with libx264, libxvid, and other GPL codecs.'
  s.homepage         = 'https://github.com/arthenica/ffmpeg-kit'
  s.authors          = { 'ARTHENICA' => 'open-source@arthenica.com' }
  s.license          = { :type => 'GPL-3.0', :text => 'See https://www.gnu.org/licenses/gpl-3.0.txt' }
  s.platforms        = { :ios => '12.1' }
  s.requires_arc     = true

  s.source           = { :path => '.' }

  s.libraries        = ['z', 'bz2', 'c++', 'iconv']

  s.ios.frameworks   = ['AudioToolbox', 'CoreMedia']
  s.ios.vendored_frameworks = [
    'ffmpegkit.framework',
    'libavcodec.framework',
    'libavdevice.framework',
    'libavfilter.framework',
    'libavformat.framework',
    'libavutil.framework',
    'libswresample.framework',
    'libswscale.framework',
  ]

  # The 6.0.LTS iOS framework was not built for arm64 simulator. Exclude that
  # architecture so the build doesn't fail on Apple Silicon Macs trying to
  # compile for the simulator (only matters if you simulator-test; running on
  # a real iPhone is fine).
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
  }
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
  }
end
