  #import <UIKit/UIKit.h>

  static BOOL hideDockEnabled;
  static BOOL hideDockIcons;
  static BOOL hideTopBar;
  static BOOL hideLabel;
  static BOOL hidedots;
  static BOOL hideNotification;
  static BOOL hideBatteryIcon;
  static BOOL hideWifiIcon;
  static BOOL changeBatteryText;
  static BOOL hideHome;
  static BOOL hideTime;
  static BOOL changeCarrierText;
  static BOOL hideDockBackground;
  static NSString *carrierLabel;
  static NSString *batteryLabel;

  @interface SBDockView : UIView
  @end

  @interface  SBRootFolderDockIconListView : UIView
  @end

  @interface SBFLockScreenDateView : UIView
  @end

  @interface _UIStatusBarStringView : UIView 
  @end

  @interface _UIStatusBarWifiSignalView : UIView
  @end 

  @interface SBIconLegibilityLabelView : UIView
  @end

  @interface _UIPageIndicatorView : UIView
  @end

  @interface SBDarkeningImageView : UIView
  @end

  @interface _UIStaticBatteryView : UIView
  @end

  @interface BSUIScrollView : UIView
  @end
  @interface _UIStatusBarForegroundView  : UIView
  @end
  @interface SBBatteryView : UIView
  @end

  %hook SBDockView
  - (void)didMoveToWindow {
    %orig;
    if (hideDockEnabled) {  
      self.hidden = true;
    }
      if (hideDockBackground) {
    [self.subviews[0] removeFromSuperview];
    }
  }
  %end

  %hook SBRootFolderDockIconListView

  - (void)didMoveToWindow {
      %orig;
      if (hideDockIcons) {
        self.hidden = YES;
      }
  }
  %end

  %hook _UIStatusBarForegroundView
  -(void)didMoveToWindow{
      if (hideTopBar){
        self.hidden = YES;
      }
  }
  %end

  %hook SBIconLegibilityLabelView

  -(void)updateIconLabelWithSettings:(id)arg0 imageParameters:(id)arg1 {
    if (hideLabel) {
      return;
    } else {
      %orig;
    }
  }

  %end

  %hook _UIPageIndicatorView
  - (void)didMoveToWindow{
    if (hidedots){
      self.hidden = YES;
      }
    }
  %end

  %hook SBDarkeningImageView

  - (void)didMoveToWindow {
    %orig;
    if (hideNotification){
    self.hidden = true;
    }
  }
  %end


  %hook _UIStaticBatteryView
  - (void)didMoveToWindow{
      %orig;
      if (hideBatteryIcon){
    self.hidden = YES;
      }
  }
  %end

  %hook _UIStatusBarWifiSignalView
    - (void)didMoveToWindow{
      %orig;
      if (hideWifiIcon) {
    self.hidden = YES;
      }
    }
  %end

  %hook SBFLockScreenDateView
    - (void)didMoveToWindow{
      %orig;
      if (hideHome){
      self.hidden = YES;
      }
    }
  %end

  %hook _UIStatusBarStringView 

  - (void)setText:(NSString *)text {
      if ([text containsString:@"%"]) {
          if (![text containsString:@":"]) {
              if (changeBatteryText) {
                  %orig(batteryLabel);
              }
          } 
      }
          if (![text containsString:@"%"]) {
              if (![text containsString:@":"]) {
                  if (changeCarrierText) {
                      %orig(carrierLabel);
                  }
              }
          }
          if (![text containsString:@"%"]) {
              if ([text containsString:@":"]) {
                %orig(text);
         }
      }
      if (![text containsString:@"%"]) {
        if (![text containsString:@":"]) {
          if (!changeCarrierText) {
                      %orig(text);
          }
   }
 }
}

%end

  void preferencesChanged() {

      NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.justdie.hidyprefs"];

      hideDockEnabled = (prefs && [prefs objectForKey:@"hideDockEnabled"] ? [[prefs valueForKey:@"hideDockEnabled"] boolValue] : YES );
      hideDockIcons = (prefs && [prefs objectForKey:@"hideDockIcons"] ? [[prefs valueForKey:@"hideDockIcons"] boolValue] : YES );
      hideTopBar = (prefs && [prefs objectForKey:@"hideTopBar"] ? [[prefs valueForKey:@"hideTopBar"] boolValue] : YES );
      hideLabel = (prefs && [prefs objectForKey:@"hideLabels"] ? [[prefs valueForKey:@"hideLabels"] boolValue] : YES );
      hidedots = (prefs && [prefs objectForKey:@"Hide3Dots"] ? [[prefs valueForKey:@"Hide3Dots"] boolValue] : YES );
      hideNotification = (prefs && [prefs objectForKey:@"hideBubble"] ? [[prefs valueForKey:@"hideBubble"] boolValue] : YES );
      hideBatteryIcon= (prefs && [prefs objectForKey:@"hideBatteryIcon"] ? [[prefs valueForKey:@"hideBatteryIcon"] boolValue] : YES );
      hideWifiIcon= (prefs && [prefs objectForKey:@"hideWifiIcon"] ? [[prefs valueForKey:@"hideWifiIcon"] boolValue] : YES );
      changeCarrierText= (prefs && [prefs objectForKey:@"changeCarrierText"] ? [[prefs valueForKey:@"changeCarrierText"] boolValue] : YES );
      changeBatteryText= (prefs && [prefs objectForKey:@"changeBatteryText"] ? [[prefs valueForKey:@"changeBatteryText"] boolValue] : YES );
      hideHome= (prefs && [prefs objectForKey:@"HideHome"] ? [[prefs valueForKey:@"HideHome"] boolValue] : YES );
      hideTime= (prefs && [prefs objectForKey:@"HideTime"] ? [[prefs valueForKey:@"HideTime"] boolValue] : YES );
      hideDockBackground= (prefs && [prefs objectForKey:@"hideDockBackground"] ? [[prefs valueForKey:@"hideDockBackground"] boolValue] : YES );
      carrierLabel= prefs[@"carrierLabel"] ? prefs[@"carrierLabel"] : nil;
      batteryLabel= prefs[@"batteryLabel"] ? prefs[@"batteryLabel"] : nil;
  }

  // and then finally, your constructor, which gets called when the tweak is loaded into memory
  %ctor {

      preferencesChanged();

      CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)preferencesChanged, CFSTR("com.justdie.hidyprefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  }
