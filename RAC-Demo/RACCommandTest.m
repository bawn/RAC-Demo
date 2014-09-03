//
//  Test1ViewController.m
//  RACWeatherExample
//
//  Created by beik on 6/27/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "RACCommandTest.h"
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking.h>



@interface RACCommandTest ()<CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet UILabel *cityLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) CLLocation *currentLocation;
@end

@implementation RACCommandTest

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    @weakify(self);
    [[[self rac_signalForSelector:@selector(locationManager:didUpdateLocations:) fromProtocol:@protocol(CLLocationManagerDelegate)] skip:1] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        CLLocation *location = [tuple.second lastObject];
        if (location.horizontalAccuracy > 0) {
            [self.locationManager stopUpdatingLocation];
            self.currentLocation = location;
            self.refreshButton.enabled = YES;
        }
    }];
    


    
    self.refreshButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self weather:self.currentLocation];
    }];
    
//    [self.refreshButton.rac_command.enabled subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
    [self mapSubscribeCommandStateToLabel];
    
    self.refreshButton.enabled = NO;
}

- (RACSignal *)weather:(CLLocation *)location{
    
    if (location) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer  serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSString *postString = [NSString stringWithFormat:@"http://api.zdoz.net/geo2loc_2.aspx?&lat=%f&lng=%f", location.coordinate.latitude, location.coordinate.longitude];
            AFHTTPRequestOperation *opation = [manager POST:postString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@", responseObject);
                [subscriber sendNext:responseObject[@"city"]];
                [subscriber sendCompleted];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                [opation cancel];
            }];
            
        }];

    }
    else{
        return [RACSignal error:[NSError errorWithDomain:@"domain" code:0 userInfo:nil]];
    }
    
}

- (void)mapSubscribeCommandStateToLabel{
    [[self.refreshButton.rac_command.executing skip:1] subscribeNext:^(NSNumber *number) {
        number.boolValue ? [self.activityIndicatorView startAnimating] : [self.activityIndicatorView stopAnimating];
    }];
    
    RACSignal *completedSignal = [self.refreshButton.rac_command.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
		return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
			return event.eventType == RACEventTypeNext;
		}] map:^id(RACEvent *event) {
			return event.value;
		}];
	}];

    
    
    RACSignal *errorSignal = [self.refreshButton.rac_command.errors map:^id(id value) {
        return @"错误";
    }];
    
    
    RAC(self.cityLabel, text) = [RACSignal merge:@[errorSignal, completedSignal]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
