//
//  tableViewController.m
//  inlineDatePicker
//
//  Created by Sunayna Jain on 2/14/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "tableViewController.h"

@interface tableViewController ()
{
    
    NSInteger startDatePickerIndex;
    
    NSInteger endDatePickerIndex;
    
}

@property (strong, nonatomic) UIDatePicker *startdatePicker;

@property (strong, nonatomic) UIDatePicker *endDatePicker;

@property (strong, nonatomic) NSDate *startDate;

@property (strong, nonatomic) NSDate *endDate;

@end


@implementation tableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarTableView.dataSource = self;
    self.calendarTableView.delegate = self;
    section=0;
    startTimeIndex = 0;
    endTimeIndex = 1;
    startDatePickerIndex = 100;
    endDatePickerIndex = 100;
    rows=2;
    self.startDate = [NSDate date];
    self.endDate = [NSDate date];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return rows;
    
    NSLog(@"number of rows %d", rows);
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:view];
    
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:view];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==startDatePickerIndex || indexPath.row==endDatePickerIndex){
        
        return 200;
        
    } else {
        
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cell for row at indexpath called");
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //resetting the tag of the cell being reused
    
    cell.tag =indexPath.row;
    
    //0, 1, 2, 3..
    
    if (!cell){
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //setting the cell tag for a new cell
        
        cell.tag = indexPath.row;
    }
    
    NSLog(@"call tag = %d", cell.tag);
    
    if (cell.tag==startTimeIndex){
        cell.textLabel.text = @"Start Time";
        
        NSLog(@"Start time cell called");
        
    } else if (cell.tag ==endTimeIndex){
        cell.textLabel.text = @"End Time";
        
        NSLog(@"end time cell called");
        
    } else if (cell.tag == startDatePickerIndex) {
        [self createStartDatePickerForCell:cell];
        
        NSLog(@"start time datepicker cell called");
        
        
    } else if (cell.tag == endDatePickerIndex){
        [self createEndDatePickerForCell:cell];
        
        NSLog(@"end time datepicker cell called");
    }
    return cell;
}


-(void)createStartDatePickerForCell:(UITableViewCell*)cell{
    
    NSArray *subviews = [cell.contentView subviews];
    
    for (UIView *subview in subviews){
        
        [subview removeFromSuperview];
    }
    
    if (cell.tag ==startDatePickerIndex){
        
        self.startdatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        
        [self.startdatePicker addTarget:self action:@selector(startDatePicked:) forControlEvents:UIControlEventValueChanged];
        
        [self.startdatePicker setDate:_startDate];
        
        [cell.contentView addSubview:self.startdatePicker];
    }
}

-(void)createEndDatePickerForCell:(UITableViewCell*)cell{
    
    NSArray *subviews = [cell.contentView subviews];
    
    for (UIView *subview in subviews){
        
        [subview removeFromSuperview];
    }
    
    if (cell.tag ==endDatePickerIndex){
        
        self.endDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        
        [self.endDatePicker addTarget:self action:@selector(endDatePicked:) forControlEvents:UIControlEventValueChanged];
        
        [self.endDatePicker setDate:_endDate];
        
        [cell.contentView addSubview:self.endDatePicker];
    }
}

-(void)startDatePicked:(id)sender{
    
    self.startDate = self.startdatePicker.date;
}

-(void)endDatePicked:(id)sender{
    
    self.endDate = self.endDatePicker.date;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"selected index %d", indexPath.row);
    
    NSLog(@"starttimeIndex %d", startTimeIndex);
    
    NSLog(@"endTimeIndex %d", endTimeIndex);
    
    NSLog(@"startDatePicker index %d", startDatePickerIndex);
    
    NSLog(@"endDatePicker index %d", endDatePickerIndex);
    
    [self.calendarTableView beginUpdates];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedCell.tag = indexPath.row;
    
    NSLog(@"selected cell tag %d", selectedCell.tag);
    
    if (selectedCell.tag==endTimeIndex && startDatePickerIndex!=100){
        
        NSLog(@"opening end time date picker when start time date picker is open");
        
        [self hideStartDatePicker];
        
        [self showEndDatePicker];
        
    } else if (selectedCell.tag==startTimeIndex && endDatePickerIndex !=100){
        
        NSLog(@"opening start time date picker when end time date picker is open");
        
        [self hideEndDatePicker];
        
        [self showStartDatePicker];
        
    } else if (selectedCell.tag ==startTimeIndex){
        
        if (startDatePickerIndex !=100){
            
            [self hideStartDatePicker];
            
        } else {
            
            [self showStartDatePicker];
        }
        
    } else if (selectedCell.tag == endTimeIndex){
        
        if (endDatePickerIndex !=100){
            
            [self hideEndDatePicker];
            
        } else {
            
            [self showEndDatePicker];
        }
        
    }
    
    else if (selectedCell.tag==startTimeIndex || selectedCell.tag ==endDatePickerIndex){
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [self.calendarTableView endUpdates];
    
}

-(void)showStartDatePicker{
    
    startDatePickerIndex = startTimeIndex+1;
    
    NSLog(@"startDatePicker index is now %d", startDatePickerIndex);
    
    endTimeIndex = endTimeIndex+1;
    
    NSLog(@"end time index is now %d", endTimeIndex);
    
    NSIndexPath *startDatePickerIP = [NSIndexPath indexPathForRow:startDatePickerIndex inSection:section];
    
    [self.calendarTableView insertRowsAtIndexPaths:@[startDatePickerIP] withRowAnimation:UITableViewRowAnimationFade];
    
    rows++;
}

-(void)hideStartDatePicker{
    
    NSIndexPath *deleteStartDatePickerIP = [NSIndexPath indexPathForRow:startDatePickerIndex inSection:section];
    
    [self.calendarTableView deleteRowsAtIndexPaths:@[deleteStartDatePickerIP] withRowAnimation:UITableViewRowAnimationFade];
    
    endTimeIndex--;
    
    rows--;
    
    NSLog(@"end time index is now %d", startDatePickerIndex);
    
    startDatePickerIndex=100;
    
    NSLog(@"startDatePicker index is now %d", startDatePickerIndex);
}

-(void)showEndDatePicker{
    
    rows++;
    
    endDatePickerIndex = endTimeIndex+1;
    
    NSLog(@"endDatePicker index is now %d", endDatePickerIndex);
    
    NSIndexPath *endDatePickerIP = [NSIndexPath indexPathForRow:endDatePickerIndex inSection:section];
    
    [self.calendarTableView insertRowsAtIndexPaths:@[endDatePickerIP] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)hideEndDatePicker{
    
    NSIndexPath *deleteEndDatePickerIP = [NSIndexPath indexPathForRow:endDatePickerIndex inSection:section];
    
    [self.calendarTableView deleteRowsAtIndexPaths:@[deleteEndDatePickerIP] withRowAnimation:UITableViewRowAnimationFade];
    
    rows--;
    
    endDatePickerIndex = 100;
    
    NSLog(@"endDatePicker index is now %d", endDatePickerIndex);
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
