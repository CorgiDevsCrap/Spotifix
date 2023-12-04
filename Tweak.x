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
- (NSInteger)tableView:(UITableView *)tableVIew numberOfRowsInSection:(NSInteger)section {
return %orig;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  cell = %orig;
  if ([cell.textLabel.text isEqual:@"Offline"]) {
    cell.userInteractionEnabled = NO;
  }
  if ([cell.textLabel.text isEqual:@"Version"]) {
    if ([cell.detailTextLabel.text rangeOfString:@"Spotifix"].location == NSNotFound) {
      cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingString:@" Spotifix by wilma24"];
    }
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView
    willDisplayHeaderView:(UITableViewHeaderFooterView *)headerView
               forSection:(NSInteger)section {
  %orig;
}
%end
