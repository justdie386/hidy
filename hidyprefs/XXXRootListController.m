#import <Foundation/Foundation.h>
#import "XXXRootListController.h"
#import <spawn.h>

@implementation XXXRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }

    return _specifiers;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.killButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(respring)];
        self.navigationItem.rightBarButtonItem = self.killButton;
    }
    return self;
}
-(void)respring {
    pid_t pid;
    const char* args[] = {"killall", "SpringBoard", NULL};
    posix_spawn(&pid, ROOT_PATH("/usr/bin/killall"), NULL, NULL, (char* const*)args, NULL);
}
-(void)_returnKeyPressed:(id)arg1 {
    [self.view endEditing:YES];
}
@end
