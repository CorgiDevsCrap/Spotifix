#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <substrate.h>

@interface SettingsViewController
    : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@end

%hook SettingsViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return %orig;
}
- (void)viewDidLoad {
%orig;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
      if ([cell.textLabel.text isEqual:@"Spotifix 0.0.4"]) {
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Spotifix 0.0.4" message:@"Hi, my name is wilma24. I made this tweak to fix an issue where spotify would crash on iOS 9 if you had \"offline\" mode toggled on in preferences. This tweak removes the \"offline\" mode toggle from preferences and gives the user the option to use the Firewall iP7 tweak instead." preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:actionOK];
        [self presentViewController:alertVC animated:true completion:nil];
      }
    }
    return %orig;
}
- (NSInteger)tableView:(UITableView *)tableVIew numberOfRowsInSection:(NSInteger)section {
  return %orig;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  cell = %orig;
  NSString *hexString = @"#121212";
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  UIColor *cellColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
  hexString = @"#ffffff";
  rgbValue = 0;
  scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  UIColor *textColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
  if ([cell.textLabel.text isEqual:@"Offline"]) {
    NSString *reuseIdentifier = @"Offline";
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
      cell.textLabel.text = @"Spotifix 0.0.4";
      cell.textLabel.font = [UIFont fontWithName:@"CircularSpUI-Book" size:17.0];
      cell.detailTextLabel.text = @"A cute little tweak to fix a crash bug on iOS 9";
      cell.detailTextLabel.font = [UIFont fontWithName:@"CircularSpUI-Book" size:13.0];
      cell.detailTextLabel.alpha = 0.5;
      cell.backgroundColor = cellColor;
      cell.textLabel.textColor = textColor;
      cell.detailTextLabel.textColor = textColor;
      cell.userInteractionEnabled = YES;
    }
    return cell;
  } else if ([cell.textLabel.text isEqual:@"Go Online Within"]) {
    NSString *reuseIdentifier = @"Go Online Within";
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
      cell.textLabel.text = @"Firewall iP7";
      cell.textLabel.font = [UIFont fontWithName:@"CircularSpUI-Book" size:17.0]; 
      cell.detailTextLabel.text = @"To enable or disable offline mode, use this tweak";
      cell.detailTextLabel.font = [UIFont fontWithName:@"CircularSpUI-Book" size:13.0];    
      cell.backgroundColor = cellColor;
      cell.textLabel.textColor = textColor;
      cell.detailTextLabel.textColor = textColor;
      cell.detailTextLabel.alpha = 0.5;
      cell.userInteractionEnabled = YES;
    }
    return cell;
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView
    willDisplayHeaderView:(UITableViewHeaderFooterView *)headerView
               forSection:(NSInteger)section {
  %orig;
}
%end
