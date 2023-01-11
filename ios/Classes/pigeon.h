// Autogenerated from Pigeon (v4.2.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Code) {
  CodeInvalidUrl = 0,
  CodeJoin = 1,
  CodeUpdateCamera = 2,
  CodeUpdateMicrophone = 3,
  CodeUpdateSubscriptions = 4,
  CodeUpdateSubscriptionProfiles = 5,
};

typedef NS_ENUM(NSUInteger, TrackSubscriptionStateMessage) {
  TrackSubscriptionStateMessageSubscribed = 0,
  TrackSubscriptionStateMessageStaged = 1,
  TrackSubscriptionStateMessageUnsubscribed = 2,
  TrackSubscriptionStateMessageUnknown = 3,
};

typedef NS_ENUM(NSUInteger, MediaStateMessage) {
  MediaStateMessageBlocked = 0,
  MediaStateMessageOff = 1,
  MediaStateMessageReceivable = 2,
  MediaStateMessageLoading = 3,
  MediaStateMessagePlayable = 4,
  MediaStateMessageInterrupted = 5,
  MediaStateMessageUnknown = 6,
};

@class UpdateSubscriptionArgs;
@class VoidResult;
@class PlatformError;
@class JoinArgs;
@class UpdateSubscriptionProfileArgs;
@class JoinMessage;
@class LocalParticipantMessage;
@class RemoteParticipantMessage;
@class ParticipantsMessage;
@class MediaMessage;
@class MediaInfoMessage;
@class TrackMessage;

@interface UpdateSubscriptionArgs : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithParticipantId:(NSString *)participantId
    profileName:(NSString *)profileName;
@property(nonatomic, copy) NSString * participantId;
@property(nonatomic, copy) NSString * profileName;
@end

@interface VoidResult : NSObject
+ (instancetype)makeWithError:(nullable PlatformError *)error;
@property(nonatomic, strong, nullable) PlatformError * error;
@end

@interface PlatformError : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithMessage:(NSString *)message
    code:(Code)code;
@property(nonatomic, copy) NSString * message;
@property(nonatomic, assign) Code code;
@end

@interface JoinArgs : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithUrl:(NSString *)url
    token:(NSString *)token
    enableMicrophone:(NSNumber *)enableMicrophone
    enableCamera:(NSNumber *)enableCamera;
@property(nonatomic, copy) NSString * url;
@property(nonatomic, copy) NSString * token;
@property(nonatomic, strong) NSNumber * enableMicrophone;
@property(nonatomic, strong) NSNumber * enableCamera;
@end

@interface UpdateSubscriptionProfileArgs : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithName:(NSString *)name
    subscribeCamera:(NSNumber *)subscribeCamera
    subscribeMicrophone:(NSNumber *)subscribeMicrophone;
@property(nonatomic, copy) NSString * name;
@property(nonatomic, strong) NSNumber * subscribeCamera;
@property(nonatomic, strong) NSNumber * subscribeMicrophone;
@end

/// Returning class from join() function
@interface JoinMessage : NSObject
+ (instancetype)makeWithLocalParticipant:(nullable LocalParticipantMessage *)localParticipant
    remoteParticipants:(nullable NSArray<RemoteParticipantMessage *> *)remoteParticipants
    error:(nullable PlatformError *)error;
@property(nonatomic, strong, nullable) LocalParticipantMessage * localParticipant;
@property(nonatomic, strong, nullable) NSArray<RemoteParticipantMessage *> * remoteParticipants;
@property(nonatomic, strong, nullable) PlatformError * error;
@end

@interface LocalParticipantMessage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithId:(NSString *)id
    userId:(NSString *)userId
    media:(nullable MediaMessage *)media;
@property(nonatomic, copy) NSString * id;
@property(nonatomic, copy) NSString * userId;
@property(nonatomic, strong, nullable) MediaMessage * media;
@end

@interface RemoteParticipantMessage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithId:(NSString *)id
    userId:(NSString *)userId
    userName:(NSString *)userName
    media:(nullable MediaMessage *)media
    joinedAtIsoString:(NSString *)joinedAtIsoString;
@property(nonatomic, copy) NSString * id;
@property(nonatomic, copy) NSString * userId;
@property(nonatomic, copy) NSString * userName;
@property(nonatomic, strong, nullable) MediaMessage * media;
@property(nonatomic, copy) NSString * joinedAtIsoString;
@end

@interface ParticipantsMessage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithLocal:(LocalParticipantMessage *)local
    remote:(NSArray<RemoteParticipantMessage *> *)remote;
@property(nonatomic, strong) LocalParticipantMessage * local;
@property(nonatomic, strong) NSArray<RemoteParticipantMessage *> * remote;
@end

@interface MediaMessage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithCamera:(MediaInfoMessage *)camera
    microphone:(MediaInfoMessage *)microphone
    screenVideo:(MediaInfoMessage *)screenVideo
    screenAudio:(MediaInfoMessage *)screenAudio;
@property(nonatomic, strong) MediaInfoMessage * camera;
@property(nonatomic, strong) MediaInfoMessage * microphone;
@property(nonatomic, strong) MediaInfoMessage * screenVideo;
@property(nonatomic, strong) MediaInfoMessage * screenAudio;
@end

@interface MediaInfoMessage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithState:(MediaStateMessage)state
    subscribed:(TrackSubscriptionStateMessage)subscribed
    track:(nullable TrackMessage *)track;
@property(nonatomic, assign) MediaStateMessage state;
@property(nonatomic, assign) TrackSubscriptionStateMessage subscribed;
@property(nonatomic, strong, nullable) TrackMessage * track;
@end

@interface TrackMessage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithId:(NSString *)id
    isEnabled:(NSNumber *)isEnabled;
@property(nonatomic, copy) NSString * id;
@property(nonatomic, strong) NSNumber * isEnabled;
@end

/// The codec used by DailyMessenger.
NSObject<FlutterMessageCodec> *DailyMessengerGetCodec(void);

/// This is the base class of communication with native code.
/// It's used for generating the Pigeon files
@protocol DailyMessenger
/// Join Daily call.
- (void)joinArgs:(JoinArgs *)args completion:(void(^)(JoinMessage *_Nullable, FlutterError *_Nullable))completion;
/// Leave Daily call.
///
/// @return `nil` only when `error != nil`.
- (nullable VoidResult *)leaveWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable VoidResult *)setMicrophoneEnabledEnableMic:(NSNumber *)enableMic error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable VoidResult *)setCameraEnabledEnableCam:(NSNumber *)enableCam error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable VoidResult *)updateSubscriptionProfilesArgs:(NSArray<UpdateSubscriptionProfileArgs *> *)args error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable VoidResult *)updateSubscriptionsArgs:(NSArray<UpdateSubscriptionArgs *> *)args error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable ParticipantsMessage *)getParticipantsWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void DailyMessengerSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<DailyMessenger> *_Nullable api);

/// The codec used by DailyCallback.
NSObject<FlutterMessageCodec> *DailyCallbackGetCodec(void);

@interface DailyCallback : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onParticipantUpdatedRemoteParticipantMessage:(RemoteParticipantMessage *)remoteParticipantMessage completion:(void(^)(NSError *_Nullable))completion;
- (void)onLocalParticipantUpdatedLocalParticipantMessage:(LocalParticipantMessage *)localParticipantMessage completion:(void(^)(NSError *_Nullable))completion;
- (void)onParticipantJoinedRemoteParticipantMessage:(RemoteParticipantMessage *)remoteParticipantMessage completion:(void(^)(NSError *_Nullable))completion;
- (void)onParticipantLeftRemoteParticipantMessage:(RemoteParticipantMessage *)remoteParticipantMessage completion:(void(^)(NSError *_Nullable))completion;
- (void)activeSpeakerChangedRemoteParticipantMessage:(nullable RemoteParticipantMessage *)remoteParticipantMessage completion:(void(^)(NSError *_Nullable))completion;
- (void)onCallStateUpdatedStateCode:(NSNumber *)stateCode completion:(void(^)(NSError *_Nullable))completion;
@end
NS_ASSUME_NONNULL_END
