//
//  ShopViewController.m
//  Functions3
//
//  Created by Erdi Kanık on 16.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "ShopViewController.h"
#import "FStyle.h"

@interface ShopViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.layer.cornerRadius = 3;
    self.tableView.layer.borderWidth = 2;
    self.tableView.layer.borderColor = [FStyle fNumberTextColor].CGColor;
    self.tableView.backgroundColor = [FStyle fBoardColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
