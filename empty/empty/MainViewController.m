//
//  MainViewController.m
//  empty
//
//  Created by echo on 13. 5. 7..
//  Copyright (c) 2013년 echo. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize DB;
#define TOOLBAR_HEIGHT 44

-(id)initWithDB:(DataBase *)_DB
{
    self = [super init];
    if(self)
    {
        DB = _DB;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    Person *Namse = [[Person alloc]init];
    Namse.s_ID = @"skatpgus";
    Namse.s_Name = @"남세현";
    Namse.i_Picture = [UIImage imageNamed:@"Namse.jpg"];
    DataBase *_DB = [DataBase alloc];
    _DB.owner = Namse;
    _DB = [_DB init];
    DB = _DB;
    
    nowComps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
    
    
    [self initNaviItems];
    [self initfirToolbar];
    [self initsecToolbar];
    [self initMVC];
    [self initWVC];
    [self initDVC];
    [self showMVC];
}
-(void)showMVC
{
    [MVC.view setHidden:NO];
    [WVC.view setHidden:YES];
    [DVC.view setHidden:YES];
}

-(void)showWVC
{
    [MVC.view setHidden:YES];
    [WVC.view setHidden:NO];
    [DVC.view setHidden:YES];
}

-(void)showDVC
{
    [MVC.view setHidden:YES];
    [WVC.view setHidden:YES];
    [DVC.view setHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)initDVC
{
    if(DVC != nil)
    {
        NSLog(@"Already has DVC");
        return;
    }
    
    NSLog(@"Setting DVC");
    DVC = [[DayViewController alloc]initWithDB:DB Frame:CGRectMake(0,TOOLBAR_HEIGHT*2, self.view.frame.size.width, self.view.frame.size.height-TOOLBAR_HEIGHT*2)];
    [self addChildViewController:DVC];
    [self.view addSubview:DVC.view];
    [DVC didMoveToParentViewController:self];
    [DVC setDateWithMonth:[nowComps month] Day:[nowComps day]];
    [DVC.view setHidden:YES];
    DVC.TVC.delegate = self;
}
-(void)initWVC
{
    if(WVC != nil)
    {
        NSLog(@"Already has WVC");
        return;
    }
    
    NSLog(@"Setting WVC");
    WVC = [[WeekViewController alloc]initWithDB:DB Frame:CGRectMake(0,TOOLBAR_HEIGHT*2, self.view.frame.size.width, self.view.frame.size.height-TOOLBAR_HEIGHT*2)];
    [self addChildViewController:WVC];
    [self.view addSubview:WVC.view];
    [WVC didMoveToParentViewController:self];
    [WVC setDateWithMonth:[nowComps month] Day:[nowComps day]];
    [WVC.view setHidden:YES];
    WVC.TVC.delegate = self;
}
-(void)initMVC
{
    if(MVC != nil)
    {
        NSLog(@"Already has MVC");
        return;
    }
    
    NSLog(@"Setting MVC");
    MVC = [[MonthViewController alloc]initWithDB:DB Frame:CGRectMake(0,TOOLBAR_HEIGHT*2, self.view.frame.size.width, self.view.frame.size.height-TOOLBAR_HEIGHT*2)];
    [self addChildViewController:MVC];
    [self.view addSubview:MVC.view];
    [MVC didMoveToParentViewController:self];
    [MVC setDateWithMonth:[nowComps month]];
    [MVC.view setHidden:YES];
    MVC.TVC.delegate = self;
}
-(void)ChangeViewControllwerWithDetailVC:(DetailViewController *)_DetailVC
{
    _DetailVC.title = self.title;
    [self.navigationController pushViewController:_DetailVC animated:YES];
}
-(void)setDateViewerWithString:(NSString *)string
{
    UIBarButtonItem *UIBBI = [[secToolbar items] objectAtIndex:0];
    UIButton *dateButton = (UIButton*)UIBBI.customView;
    [dateButton setTitle:string forState:UIControlStateNormal];
    
}
-(void)initsecToolbar
{
    if([self.view.subviews indexOfObject:secToolbar] != NSNotFound)
    {
        NSLog(@"Already has Second Toolbar");
        return;
    }
    NSLog(@"Setting Second Toolbar");
    secToolbar = [[UIToolbar alloc]init];
    secToolbar.frame = CGRectMake(0,TOOLBAR_HEIGHT,self.navigationController.navigationBar.frame.size.width,TOOLBAR_HEIGHT);
    secToolbar.tintColor = [UIColor whiteColor];
    
    UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateButton setFrame:CGRectMake(0, 0, 100, 30)];
    [dateButton setTitle:@"2013.01" forState:UIControlStateNormal];
    [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *dateBarButton = [[UIBarButtonItem alloc] initWithCustomView:dateButton];
    
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *chatImage = [UIImage imageNamed:@"ic_chat.png"];
    [chatButton setFrame:CGRectMake(0, 0, 30, 30)];
    [chatButton setImage:chatImage forState:UIControlStateNormal];
    UIBarButtonItem *chatBarButton = [[UIBarButtonItem alloc] initWithCustomView:chatButton];

    UIButton *arrowleftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *arrowleftImage = [UIImage imageNamed:@"ic_arrowleft.png"];
    [arrowleftButton setFrame:CGRectMake(0, 0, 30, 30)];
    [arrowleftButton setImage:arrowleftImage forState:UIControlStateNormal];
    UIBarButtonItem *arrowleftBarButton = [[UIBarButtonItem alloc] initWithCustomView:arrowleftButton];

    UIButton *todayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *todayImage = [UIImage imageNamed:@"ic_today.png"];
    [todayButton setFrame:CGRectMake(0, 0, 30, 30)];
    [todayButton setImage:todayImage forState:UIControlStateNormal];
    UIBarButtonItem *todayBarButton = [[UIBarButtonItem alloc] initWithCustomView:todayButton];
    
    UIButton * arrowrightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *arrowrightImage = [UIImage imageNamed:@"ic_arrowright.png"];
    [arrowrightButton setFrame:CGRectMake(0, 0, 30, 30)];
    [arrowrightButton setImage:arrowrightImage forState:UIControlStateNormal];
    UIBarButtonItem *arrowrightBarButton = [[UIBarButtonItem alloc] initWithCustomView:arrowrightButton];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil];
    
    [self.view addSubview:secToolbar];
    [secToolbar setItems:[[NSArray alloc] initWithObjects:dateBarButton,flexibleSpace,chatBarButton,flexibleSpace,arrowleftBarButton,flexibleSpace,todayBarButton,flexibleSpace,arrowrightBarButton, nil] animated:YES];
}
-(void)initfirToolbar
{
    if([self.view.subviews indexOfObject:firToolbar] != NSNotFound)
    {
        NSLog(@"Already has First Toolbar");
        return;
    }
    
    NSLog(@"Setting First Toolbar");
    firToolbar = [[UIToolbar alloc]init];
    firToolbar.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, TOOLBAR_HEIGHT);
    firToolbar.tintColor = [UIColor grayColor];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addImage = [UIImage imageNamed:@"ic_addtodo.png"];
    [addButton setFrame:CGRectMake(0, 0, 30, 30)];
    [addButton setImage:addImage forState:UIControlStateNormal];
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *dayImage = [UIImage imageNamed:@"ic_day.png"];
    [dayButton setFrame:CGRectMake(0, 0, 30, 30)];
    [dayButton setImage:dayImage forState:UIControlStateNormal];
    [dayButton addTarget:self action:@selector(showDVC) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *dayBarButton = [[UIBarButtonItem alloc] initWithCustomView:dayButton];
    
    UIButton *weekButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *weekImage = [UIImage imageNamed:@"ic_week.png"];
    [weekButton setFrame:CGRectMake(0, 0, 30, 30)];
    [weekButton setImage:weekImage forState:UIControlStateNormal];
    [weekButton addTarget:self action:@selector(showWVC) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *weekBarButton = [[UIBarButtonItem alloc] initWithCustomView:weekButton];
    
    UIButton *monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *monthImage = [UIImage imageNamed:@"ic_month.png"];
    [monthButton setFrame:CGRectMake(0, 0, 30, 30)];
    [monthButton setImage:monthImage forState:UIControlStateNormal];
    [monthButton addTarget:self action:@selector(showMVC) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *monthBarButton = [[UIBarButtonItem alloc] initWithCustomView:monthButton];
    
    UIButton *handleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *handleImage = [UIImage imageNamed:@"ic_handle.png"];
    [handleButton setFrame:CGRectMake(0, 0, 30, 30)];
    [handleButton setImage:handleImage forState:UIControlStateNormal];
    UIBarButtonItem *handleBarButton = [[UIBarButtonItem alloc] initWithCustomView:handleButton];

    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil];
    
    [self.view addSubview:firToolbar];

    [firToolbar setItems:[[NSArray alloc] initWithObjects:addBarButton,flexibleSpace,dayBarButton,flexibleSpace,weekBarButton,flexibleSpace,monthBarButton,flexibleSpace,handleBarButton, nil] animated:YES];
}
-(void)slideSideView
{
    NSLog(@"Slide Side View");
    
    
    if(sideView == nil)
    {
        CGRect newFrame = self.view.frame;
        newFrame.size.width *= 0.75;
        newFrame.origin.x -= 50;//newFrame.size.width;
        //newFrame.origin.y -= self.navigationController.navigationBar.frame.size.height;
        sideView = [[SideView alloc] initWithFrame:newFrame ToolbarHeight:self.navigationController.navigationBar.frame.size.height Onwer:DB.owner];
        NSLog(@"side view is : %@",sideView);
//        [self.view.superview addSubview:sideView];
        UIViewController *VC = [[UIViewController alloc]init];
        VC.view = sideView;
        //[self.navigationController addChildViewController:VC];
        //[self.view.superview insertSubview:sideView belowSubview:self.view];
        [self.view addSubview:sideView];
        NSLog(@"%@",self.view.superview);
    }
    //[sideView slide];
    
    [self SlideMainView];
}
-(void)SlideMainView
{
    
    CGRect destination = self.navigationController.view.frame;
    
    if (destination.origin.x > 0) {
        destination.origin.x = 0;
    } else {
        destination.origin.x = sideView.frame.size.width;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.navigationController.view.frame = destination;
        
    } completion:^(BOOL finished) {
        
//        self.userInteractionEnabled = !(destination.origin.x > 0);
        
    }];
}
-(void)initNaviItems
{
    NSLog(@"Setting navi items");
    
    
    [self setTitle:DB.title];
    
    // left
    UIButton *profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *profileImage = [UIImage imageNamed:@"ic_profile.png"];
    CGRect frame = CGRectMake(0, 0, 30,30);//self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
    [profileButton setFrame:frame];
    [profileButton setImage:profileImage forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(slideSideView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *profileBarButton = [[UIBarButtonItem alloc] initWithCustomView:profileButton];
    [self.navigationItem setLeftBarButtonItems:[[NSArray alloc] initWithObjects:profileBarButton, nil] animated:YES];
    
    //right
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setFrame:CGRectMake(0, 0, 30,30)];//self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    [menuButton setImage:[UIImage imageNamed:@"ic_menu.png"] forState:UIControlStateNormal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIButton *briefButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [briefButton setFrame:CGRectMake(0, 0, 30,30)];//self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    [briefButton setImage:[UIImage imageNamed:@"ic_brief.png"] forState:UIControlStateNormal];
    UIBarButtonItem *briefBarButton = [[UIBarButtonItem alloc] initWithCustomView:briefButton];
    
    /*UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
     target:nil
     action:nil];
     */
    [self.navigationItem setRightBarButtonItems:[[NSArray alloc] initWithObjects:menuBarButton,briefBarButton, nil] animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end