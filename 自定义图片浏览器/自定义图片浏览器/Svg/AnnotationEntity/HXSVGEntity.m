//
//  HXSVGEntity.m
//  test
//
//  Created by 孙海平 on 16/11/28.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import "HXSVGEntity.h"

@implementation HXSVGEntity
//- (instancetype)initWithResultSet:(FMResultSet *)resultSet
//{
//    self = [super init];
//    if (self) {
//        //        fileid, svgid, userid, pid, nid, sid, tp, opr, nt, cl, lw, x, y, w, h, sx, sy, ex, ey, ps, img, aud, vid, txt, CreateDate, IsSync, ShowID, GroupID)
//        _fileid = [resultSet stringForColumn:@"fileid"];
//        _svgid = [resultSet stringForColumn:@"svgid"];
//        _userid = [resultSet stringForColumn:@"userid"];
//        _pid = [resultSet stringForColumn:@"pid"];
//        _nid = [resultSet stringForColumn:@"nid"];
//        _sid = [resultSet stringForColumn:@"sid"];
//        _tp = [resultSet stringForColumn:@"tp"];
//        _opr = [resultSet stringForColumn:@"opr"];
//        _nt = [resultSet stringForColumn:@"nt"];
//        _cl = [resultSet stringForColumn:@"cl"];
//        _lw = [resultSet stringForColumn:@"lw"];
//        _x = [resultSet stringForColumn:@"x"];
//        _y = [resultSet stringForColumn:@"y"];
//        _w = [resultSet stringForColumn:@"w"];
//        _h = [resultSet stringForColumn:@"h"];
//        _sx = [resultSet stringForColumn:@"sx"];
//        _sy = [resultSet stringForColumn:@"sy"];
//        _ex = [resultSet stringForColumn:@"ex"];
//        _ey = [resultSet stringForColumn:@"ey"];
//        _ps = [resultSet stringForColumn:@"ps"];
//        _img = [resultSet stringForColumn:@"img"];
//        _aud = [resultSet stringForColumn:@"aud"];
//        _vid = [resultSet stringForColumn:@"vid"];
//        _txt = [resultSet stringForColumn:@"txt"];
//        _createDate = [resultSet stringForColumn:@"createDate"];
//        _isSync = [resultSet stringForColumn:@"isSync"];
//        _showID = [resultSet stringForColumn:@"showID"];
//        _groupID = [resultSet stringForColumn:@"groupID"];
//        
//    }
//    return self;
//}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        //        fileid, svgid, userid, pid, nid, sid, tp, opr, nt, cl, lw, x, y, w, h, sx, sy, ex, ey, ps, img, aud, vid, txt, CreateDate, IsSync, ShowID, GroupID)
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (NSDictionary *)getMobileSvgParameterWithOpr:(NSString *)opr
{
    NSDictionary * dic = @{@"nid":NotNilAndNull(self.nid)? self.nid:@"",
                           @"pid":NotNilAndNull(self.pid)? self.pid:@"",
                           @"sid":NotNilAndNull(self.sid)? self.sid:@"",
                           @"opr":opr,
                           @"nt":NotNilAndNull(self.nt)? self.nt:@"",
                           @"x":NotNilAndNull(self.x)? self.x:@"",
                           @"y":NotNilAndNull(self.y)? self.y:@"",
                           @"w":NotNilAndNull(self.w)? self.w:@"",
                           @"h":NotNilAndNull(self.h)? self.h:@"",
                           @"sx":NotNilAndNull(self.sx)? self.sx:@"",
                           @"sy":NotNilAndNull(self.sy)? self.sy:@"",
                           @"ex":NotNilAndNull(self.ex)? self.ex:@"",
                           @"ey":NotNilAndNull(self.ey)? self.ey:@"",
                           @"ps":NotNilAndNull(self.ps)? self.ps:@"",
                           @"cl":NotNilAndNull(self.cl)? self.cl:@"",
                           @"lw":NotNilAndNull(self.lw)? self.lw:@"",
                           @"tp":NotNilAndNull(self.tp)? self.tp:@"",
                           @"img":NotNilAndNull(self.img)? self.img:@"",
                           @"aud":NotNilAndNull(self.aud)? self.aud:@"",
                           @"vid":NotNilAndNull(self.vid)? self.vid:@"",
                           @"txt":NotNilAndNull(self.txt)? self.txt:@""};
    return dic;
}
@end
