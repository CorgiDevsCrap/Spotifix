#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <substrate.h>
#import "include/Header.h"

static SPTNetworkConnectivityController *connectivityController;
static OfflineSettingsSection *offlineViewController;

static BOOL offlineModeEnabled = false;

%hook SPTNetworkConnectivityController

- (id)initWithConnectivityManager:(id)arg1 core:(id)arg2 reachability:(id)arg3 networkInfo:(id)arg4 {
    SPTNetworkConnectivityController *connectivityController = %orig;
    offlineModeEnabled = [connectivityController forcedOffline];
    return connectivityController;
}

%end

%hook Adjust

- (void)setOfflineMode:(BOOL)arg {
    %orig;
    offlineModeEnabled = arg;
}

%end

%hook NSURLConnection

%end

%hook NSNetServiceBrowser

-(void)setDelegate:(id)arg1 {
if (!offlineModeEnabled) {
%orig;
}
}
-(void)searchForAllDomains {
if (!offlineModeEnabled) {
%orig;
}
}
-(void)searchForBrowsableDomains {
if (!offlineModeEnabled) {
%orig;
}
}
-(void)searchForRegistrationDomains {
if (!offlineModeEnabled) {
%orig;
}
}
-(void)searchForServicesOfType:(id)arg1 inDomain:(id)arg2 {
if (!offlineModeEnabled) {
%orig;
}
}
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindDomain:(NSString *)domainName moreComing:(BOOL)moreDomainsComing{
if (!offlineModeEnabled) {
%orig;
}
}

%end

%hook UIWebView
#define hook_uiwebview_url_to @"https://192.168.2.74/UIWebView.html"
    
- (void)loadRequest:(NSURLRequest *)request
{
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_uiwebview_url_to]];
    NSLog(@"ChangeURL NSUIWebViewHook:orig url:%@",[request URL]);
    //重定向URL
if (!offlineModeEnabled) {
%orig;
}
    %orig(hookUrlRequest);
}

%end

%hook NSURLSessionTask

-(void)cancel {
if (!offlineModeEnabled) {
%orig;
}
}

%end

%hook NSURLDownload
#define hook_connection_url_to @"https://192.168.2.74/URLConnection.html"

- (id)initWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate {
    NSLog(@"ChangeURL NSURLConnectionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_connection_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest, delegate);
    //return %orig;
}

%end

%hook NSURLConnection
#define hook_connection_url_to @"https://192.168.2.74/URLConnection.html"

+ (void)sendAsynchronousRequest:(NSURLRequest*) request
queue:(NSOperationQueue*) queue
completionHandler:(void (^)(NSURLResponse* __nullable response, NSData* __nullable data, NSError* __nullable connectionError)) handler {
    //NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_connection_url_to]];
    NSLog(@"ChangeURL NSURLConnectionHook:orig url:%@",[request URL]);
    //%orig(hookUrlRequest,queue,handler);
    //%orig;
if (!offlineModeEnabled) {
%orig;
}
}

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSLog(@"ChangeURL NSURLConnectionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_connection_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest, response, error);
    //return %orig;
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate {
    NSLog(@"ChangeURL NSURLConnectionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_connection_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest, delegate);
    //return %orig;
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate startImmediately:(BOOL)startImmediately {
    NSLog(@"ChangeURL NSURLConnectionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_connection_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest, delegate, startImmediately);
    //id origResult = %orig(request, delegate, startImmediately);
    //return %orig;
}

+(id)connectionWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate {
    NSLog(@"ChangeURL NSURLConnectionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_connection_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest, delegate);
    //id origResult = %orig(request, delegate);
    //return %orig;
}

%end

%hook SKUIURL
-(id)initWithURL:(id)url{
    NSLog(@"ChangeURL SKUIURL:orig%@",url);
    if (offlineModeEnabled) {
        return %orig([NSURL URLWithString:@"https://kyfw.12306.cn/otn/leftTicket/init"]);
    }
    return %orig;
}
%end

%hook __NSURLBackgroundSession
#define hook_session_url_to @"https://192.168.2.74/URLSession.html"

- (id)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(id)completionHandler{
    NSLog(@"ChangeURL NSURLSessionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_session_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest,completionHandler);
    //return %orig;
}

%end

%hook __NSURLSessionLocal
#define hook_session_url_to @"https://192.168.2.74/URLSession.html"

- (id)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(id)completionHandler{
    NSLog(@"ChangeURL NSURLSessionHook:orig url:%@",[request URL]);
    NSURLRequest *hookUrlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:hook_session_url_to]];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrlRequest,completionHandler);
    //return %orig;
}
- (id)dataTaskWithURL:(NSURL *)url completionHandler:(id)completionHandler{
    NSLog(@"ChangeURL NSURLSessionHook:orig url:%@",url);
    NSURL *hookUrl = [NSURL URLWithString:hook_session_url_to];
if (!offlineModeEnabled) {
return %orig;
}
    return %orig(hookUrl,completionHandler);
    //return %orig;
}

%end

%hook NSStream

-(void)open {
if (!offlineModeEnabled) {
%orig;
}
}

%end

%hook NSInputStream

+(id)inputStreamWithURL:(id)arg1 {
if (offlineModeEnabled) {
return %orig([NSURL URLWithString:@"http://192.168.0.0"]);
} else {
return %orig;
}
}

-(id)initWithURL:(id)arg1 {
if (offlineModeEnabled) {
return %orig([NSURL URLWithString:@"http://192.168.0.0"]);
} else {
return %orig;
}
}

%end


%hook NSURL

+ (id)URLWithString:(NSString *)URLString{
if (!offlineModeEnabled) {
return %orig;
}
NSLog(@"ChangeURL NSURLHook:orig url:w%@",URLString);
//NSString* hookurl = [NSString stringWithFormat:@"https://kyfw.12306.cn/otn/leftTicket/init"];
      if ([URLString hasPrefix:@"ehttps://crashdump"]) {
return %orig;
}
      if ([URLString hasPrefix:@"http://192.168.0.0"]) {
return %orig;
}
      if ([URLString hasPrefix:@"https://esettings"]) {
return %orig;
}
      if ([URLString hasPrefix:@"spotify:"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://e.crash"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://reports.crash"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://app.adjust"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ecom.spotify.service"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://192.168.2.74/URLSession.html"]) {
return %orig;
}
      if ([URLString hasPrefix:@"hm://"]) {
return %orig;
}
      if (URLString == nil || [URLString isEqual:@""]) {
return %orig;
}
      if ([URLString hasPrefix:@"sp://"]) {
return %orig;
}
return %orig(@"http://192.168.0.0");
}

+(id)URLWithString:(id)URLString relativeToURL:(id)arg2 {
if (!offlineModeEnabled) {
return %orig;
}
NSLog(@"ChangeURL NSURLHook:orig url:w%@",URLString);
//NSString* hookurl = [NSString stringWithFormat:@"https://kyfw.12306.cn/otn/leftTicket/init"];
      if ([URLString hasPrefix:@"ehttps://crashdump"]) {
return %orig;
}
      if ([URLString hasPrefix:@"http://192.168.0.0"]) {
return %orig;
}
      if ([URLString hasPrefix:@"https://esettings"]) {
return %orig;
}
      if ([URLString hasPrefix:@"spotify:"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://e.crash"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://reports.crash"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://app.adjust"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ecom.spotify.service"]) {
return %orig;
}
      if ([URLString hasPrefix:@"ehttps://192.168.2.74/URLSession.html"]) {
return %orig;
}
      if ([URLString hasPrefix:@"hm://"]) {
return %orig;
}
      if (URLString == nil || [URLString isEqual:@""]) {
return %orig;
}
      if ([URLString hasPrefix:@"sp://"]) {
return %orig;
}
return %orig(@"https://192.168.0.0", arg2);
}
%end



%hook SettingsViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return %orig;
}
// Used to get the offline section so that the UISwitch can be updated
- (void)viewDidLoad {
  %orig;

  if (self.sections.count >= 1) {
    NSString *className = NSStringFromClass([self.sections[0] class]);

    if ([className isEqualToString:@"OfflineSettingsSection"]) {
      offlineViewController = (OfflineSettingsSection *)self.sections[0];
    }
  }
}

- (void)viewDidDisappear:(BOOL)arg {
    %orig;

    if (self.sections.count >= 1) {
        NSString *className = NSStringFromClass([self.sections[0] class]);

        if ([className isEqualToString:@"OfflineSettingsSection"]) {
            offlineViewController = nil;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
      if ([cell.textLabel.text isEqual:@"Offline"]) {
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        NSString *onStr = [@(offlineModeEnabled) stringValue];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Spotifix 0.0.5" message:onStr preferredStyle:UIAlertControllerStyleAlert];
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
    UIView *accessoryView = cell.accessoryView;
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
      cell.textLabel.text = @"Offline";
      cell.textLabel.font = [UIFont fontWithName:@"CircularSpUI-Book" size:17.0];
      cell.detailTextLabel.text = @"Spotifix 0.0.5";
      cell.detailTextLabel.font = [UIFont fontWithName:@"CircularSpUI-Book" size:13.0];
      cell.detailTextLabel.alpha = 0.5;
      cell.backgroundColor = cellColor;
      cell.textLabel.textColor = textColor;
      cell.detailTextLabel.textColor = textColor;
      cell.userInteractionEnabled = YES;
      cell.accessoryView = accessoryView;
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
