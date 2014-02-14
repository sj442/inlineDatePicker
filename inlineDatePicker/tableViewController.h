//
//  tableViewController.h
//  inlineDatePicker
//
//  Created by Sunayna Jain on 2/14/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    NSInteger section;
    
    NSInteger startTimeIndex;
    
    NSInteger endTimeIndex;
    
    NSInteger rows;
}

@property (weak, nonatomic) IBOutlet UITableView *calendarTableView;



@end
