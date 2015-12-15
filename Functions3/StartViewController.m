//
//  StartViewController.m
//  Functions3
//
//  Created by erdikanik on 15.12.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()
@property (weak, nonatomic) IBOutlet UILabel *maxPointLabel;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
    NSNumber *totalPoint = [prefs objectForKey:@"totalPoint"];
    
    if (!totalPoint)
    {
        totalPoint = @(0);
    }
    
    self.maxPointLabel.text = [NSString stringWithFormat:@"MAX POINT : %@",totalPoint];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
