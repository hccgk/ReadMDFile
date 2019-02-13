//
//  MainViewController.m
//  ReadMD
//  1.header 搜索
//  2.可以按名称排序
//  3.cell是每一个文件
//  Created by 何川 on 2019/2/12.
//  Copyright © 2019 何川. All rights reserved.
//

#import "MainViewController.h"
#import "BMChineseSort.h"
#import "FileModel.h"
#import "NSArray+JKSafeAccess.h"
#import "ReadMDViewController.h"

static NSString  *MDFileTableViewCellInder = @"MDFileTableViewCellInder";

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *searchHeaderView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray <FileModel*> *dataArray;

@property(nonatomic,strong) NSMutableArray *firstLetterArray;//排序后的出现过的拼音首字母数组
@property(nonatomic,strong) NSMutableArray *sortedModelArr;//排序好的结果数组
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self loadData];//串行的所以直接在这里,正常应该是在网络请求之后
    [self calculaterPinYin];
//    [self.tableView reloadData];
}

-(void)loadData{
    self.dataArray = [NSMutableArray array];
    //1.读取文件
    // 工程目录
    NSString *BASE_PATH = [NSString stringWithFormat:@"%@/files",[[NSBundle mainBundle] bundlePath]];
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [myFileManager enumeratorAtPath:BASE_PATH];
//    NSArray *arr = [myFileManager componentsToDisplayForPath:BASE_PATH];
    BOOL isDir = NO;
    BOOL isExist = NO;
    
    //列举目录内容，可以遍历子目录
    for (NSString *path in myDirectoryEnumerator.allObjects) {
        
//        NSLog(@"%@", path);  // 所有路径
        
        isExist = [myFileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", BASE_PATH, path] isDirectory:&isDir];
        if (isDir) {
            NSLog(@"%@", path);    // 目录路径
        } else {
//            NSLog(@"%@", path);    // 文件路径
            FileModel *model = [FileModel new];
            model.name = path;
            [self.dataArray addObject:model];
        }
    }
//    NSLog(@"%@",arr);
}
-(void)calculaterPinYin{
    kWeakSelf(self)
    [BMChineseSort sortAndGroup:self.dataArray key:@"name" finish:^(bool isSuccess, NSMutableArray *unGroupArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [weakself.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.firstLetterArray jk_objectWithIndex:section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.firstLetterArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.sortedModelArr jk_objectWithIndex:section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.firstLetterArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MDFileTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:MDFileTableViewCellInder];
//    FileModel *model = self.sortedModelArr[indexPath.section][indexPath.row];
    FileModel *model = [[self.sortedModelArr jk_objectWithIndex:indexPath.section] jk_objectWithIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FileModel *p = [[self.sortedModelArr jk_objectWithIndex:indexPath.section] jk_objectWithIndex:indexPath.row];
    NSString *BASE_PATH = [NSString stringWithFormat:@"%@/files/%@",[[NSBundle mainBundle] bundlePath],p.name];

    ReadMDViewController *vc = [[ReadMDViewController alloc] init];
    vc.filePath = BASE_PATH;
    vc.title = p.name;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)searchAndReloadData:(NSString*)text{
    //便利数组得到新的值
    //对dataarray 进行筛选,然后得到一个新的array
    NSMutableArray *mutarray = [NSMutableArray arrayWithCapacity:_dataArray.count];
    for (FileModel *model  in _dataArray) {
        if ([model.name containsString:text]) {
            [mutarray addObject:model];
        }
    }
    
    kWeakSelf(self)
    [BMChineseSort sortAndGroup:mutarray key:@"name" finish:^(bool isSuccess, NSMutableArray *unGroupArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [weakself.tableView reloadData];
        }
    }];
    
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchAndReloadData:searchBar.text];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length ==0) {
        [self calculaterPinYin ];
        [searchBar endEditing:YES];
    }
}

#pragma mark - lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenW , kScreenH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MDFileTableViewCell class] forCellReuseIdentifier:MDFileTableViewCellInder];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 32);
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.tableHeaderView = self.searchHeaderView;
    }
    return _tableView;
}

-(UIView *)searchHeaderView{
    if (!_searchHeaderView) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 8, kScreenW - 30 , 32)];
        _searchBar.placeholder = @"搜索你想找的文件";
        _searchBar.delegate = self;
        kRViewBorderRadius(_searchBar, 16)
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
//        UITextField *searchField = [_serarbar valueForKey:@"_searchField"];
//        searchField.textColor = khometextcolor;
//        searchField.font = [UIFont systemFontOfSize:14];
//        [searchField setValue:kgraycolor forKeyPath:@"_placeholderLabel.textColor"];
//
//        UIImage *searchBarBg = [UIImage imageWithColor:[UIColor colorWithRGBA:0xfafaffff] size:CGSizeMake(kScreenW - 30, 32)];
//        UIImage *radiusBg = [searchBarBg imageByRoundCornerRadius:16];
//        [_serarbar setSearchFieldBackgroundImage:radiusBg forState:UIControlStateNormal];
        _searchHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 49)];
        [_searchHeaderView addSubview:_searchBar];
        _searchHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _searchHeaderView;
}

@end
