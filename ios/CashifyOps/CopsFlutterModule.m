// =============================================================================
// CopsFlutterModule.m
//
// Objective-C bridge that registers `CopsFlutter` with React Native's module
// system. Required because Swift modules need this glue to be discoverable.
// =============================================================================

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(CopsFlutter, NSObject)

RCT_EXTERN_METHOD(launchFlutter:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
