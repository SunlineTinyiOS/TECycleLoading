//
//  TECycleLoading.m
//  Tiny
//
//  Created by air on 2017/12/11.
//  Copyright © 2017年 xiangfp. All rights reserved.
//

#import "TECycleLoading.h"
#import "UIColorAdditions.h"
@interface TECycleLoading()
@property(nonatomic,strong) NSString *cycleColorStr;
@property(nonatomic,strong) NSNumber *oneCycleSpedTime;
@property(nonatomic,strong)NSMutableArray *pointArr;
@property(nonatomic,strong)NSNumber *cycleState;//1转 2停止
@property(nonatomic,assign)CGFloat cycleWidth;
@end
@implementation TECycleLoading
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.hidden=YES;
    }
    return self;
}

-(void)setParam:(NSString *)name :(id)value{
         if ([name isEqualToString:@"param"]) {
             NSDictionary *   paramDictionary=(NSDictionary *)value;
             if (paramDictionary[@"circleColor"]) {
                 self.cycleColorStr = paramDictionary[@"circleColor"];
             }
             if (paramDictionary[@"circleSpeed"]) {
                 NSNumber *sped=@([paramDictionary[@"circleSpeed"] floatValue]);
                 self.oneCycleSpedTime=@((2*M_PI)/(sped.floatValue/180));
             }
             if (paramDictionary[@"state"]) {
                 self.cycleState=@([paramDictionary[@"state"] floatValue]);
             }
    
         }
    if ([self.cycleState isEqualToNumber:@1]) {
        [self cycleLoading];
    }else if ([self.cycleState isEqualToNumber:@2]){
        [self disMissCycleLoading];
    }
//    [self setNeedsDisplay];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cycleWidth=self.frame.size.width;
}


- (void)drawRect:(CGRect)rect{
    
    
}


//不停转圈
-(void)cycleLoading{
 self.transform = CGAffineTransformMakeScale(1, 1);
    self.hidden=NO;
    self.backgroundColor=[UIColor clearColor];
    for (UIView *vv in self.pointArr) {
        [vv removeFromSuperview];
    }
    [self.superview bringSubviewToFront:self];
    [self.pointArr removeAllObjects];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2.0;
    
    CGFloat cycleWidth=(self.frame.size.width/3.0)/2.0;
    CGFloat halfWidth=self.frame.size.width/2.0;
    CGFloat R=halfWidth-cycleWidth;
    CGFloat Pwidth=R/sqrt(2.0);

    for (NSInteger i=1; i<=8; i++) {
        CGFloat r=(cycleWidth)*powf(0.93, (8-i));
        UIView * cycleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, r, r)];
        cycleView.layer.masksToBounds=YES;
        cycleView.layer.cornerRadius=r/2.0;
        cycleView.backgroundColor=[UIColor redColor];
        CGPoint center;
        switch (i-1) {
            case 0:
                center=CGPointMake(halfWidth, cycleWidth);
                break;
            case 1:
                center=CGPointMake(halfWidth+Pwidth, halfWidth-Pwidth);
                break;
            case 2:
                center=CGPointMake(halfWidth+R, halfWidth);
                break;
            case 3:
                center=CGPointMake(halfWidth+Pwidth,halfWidth+Pwidth);
                break;
            case 4:
                center=CGPointMake(halfWidth, halfWidth+R);
                break;
            case 5:
                center=CGPointMake(halfWidth-Pwidth, halfWidth+Pwidth);
                break;
            case 6:
                center=CGPointMake(halfWidth-R, halfWidth);
                break;
            case 7:
                center=CGPointMake(halfWidth-Pwidth, halfWidth-Pwidth);
                break;
            default:
                center=CGPointMake(halfWidth, cycleWidth);
                break;
        }
        
        cycleView.center=center ;
        [self addSubview:cycleView];
        [self.pointArr addObject:cycleView];
     
    }
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = self.oneCycleSpedTime.floatValue;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


-(void)disMissCycleLoading{
//    self.placeLayer ;
      [self.layer removeAllAnimations];

    [UIView animateWithDuration:0.8 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self becomeFull];
    }];
    
}

-(void)becomeFull{
    [self.layer removeAllAnimations];
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    [self.pointArr removeAllObjects];
    self.alpha = 1;
    
    CGFloat sca= [UIScreen mainScreen].applicationFrame.size.height/self.cycleWidth*2*1.5;
     self.backgroundColor=[UIColor whiteColor];
            [UIView animateWithDuration:0.7 animations:^{
                self.transform = CGAffineTransformMakeScale(sca, sca);
                self.alpha = 1;
            } completion:^(BOOL finished) {
               [self performSelector:@selector(disAppear) withObject:nil afterDelay:1.5];
            }];
    
}

-(void)disAppear{
     self.hidden=YES;
     [self executiveEvent:@"end" array:@[]];
}

-(void)executiveEvent:(NSString *)event array:(NSArray *)array
{
    UIView *supView = self.superview;
    if([supView respondsToSelector:@selector(executiveEvent: array:)]) {
        [supView performSelector:@selector(executiveEvent: array:) withObject:event withObject:array];
    }
}


#pragma mark set-get
-(NSMutableArray *)pointArr{
    if (!_pointArr) {
        _pointArr=[[NSMutableArray    alloc]init];
    }
    return _pointArr  ;
}

@end
