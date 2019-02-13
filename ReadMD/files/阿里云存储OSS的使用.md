# 阿里云存储OSS的使用

1. 首先组件化加载sdk

   `pod 'AliyunOSSiOS’`

2. 初始化

   ```objective-c
    NSString *endPoint = @"http://oss-cn-beijing.aliyuncs.com";
   //过期的初始化方法，通用的权限表示
       id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:@"LTAIRsEhrAxrVU6J" secretKey:@"Ts0Wc01UY3ulzPgTSCEXBbBquFJ3yU"];
   //定制化关系
   //    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:@"" secretKeyId:@"" securityToken:@""];
   ```

3. 发送数据

   ```objective-c
   client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
       //普通上传
       OSSPutObjectRequest * put = [OSSPutObjectRequest new];
       put.bucketName = @"test-toios";
       put.objectKey = @"classroom.png";
       NSData *data = [self getData];
       put.uploadingData = data; // 直接上传NSData
       put.contentType = @"image/png";
       put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
           NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
       };
       OSSTask * putTask = [client putObject:put];
       [putTask continueWithBlock:^id(OSSTask *task) {
           if (!task.error) {
               NSLog(@"upload object success!");
           } else {
               NSLog(@"upload object failed, error: %@" , task.error);
           }
           return nil;
       }];
   ```



   解释，client是一个对象，这个对象能够发起请求，请求的类型是OSSPutObjectRequest

   put中间状态对象，这个对象描述了对应的bucket名字还有object的名字也就是你要上传文件的名字，然后上传的内容是nsdata的一个类型 然后就在continueWithBlock 就能够看到是否成功；
