//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<image_picker/FLTImagePickerPlugin.h>)
#import <image_picker/FLTImagePickerPlugin.h>
#else
@import image_picker;
#endif

#if __has_include(<searchable_dropdown/SearchableDropdownPlugin.h>)
#import <searchable_dropdown/SearchableDropdownPlugin.h>
#else
@import searchable_dropdown;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [SearchableDropdownPlugin registerWithRegistrar:[registry registrarForPlugin:@"SearchableDropdownPlugin"]];
}

@end
