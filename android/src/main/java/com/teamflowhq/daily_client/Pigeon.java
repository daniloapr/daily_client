// Autogenerated from Pigeon (v4.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.teamflowhq.daily_client;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class Pigeon {

  public enum ErrorCode {
    INVALID_URL(0),
    JOIN(1),
    UPDATE_CAMERA(2),
    UPDATE_MICROPHONE(3);

    private int index;
    private ErrorCode(final int index) {
      this.index = index;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class VoidResult {
    private @Nullable PlatformError error;
    public @Nullable PlatformError getError() { return error; }
    public void setError(@Nullable PlatformError setterArg) {
      this.error = setterArg;
    }

    public static final class Builder {
      private @Nullable PlatformError error;
      public @NonNull Builder setError(@Nullable PlatformError setterArg) {
        this.error = setterArg;
        return this;
      }
      public @NonNull VoidResult build() {
        VoidResult pigeonReturn = new VoidResult();
        pigeonReturn.setError(error);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("error", (error == null) ? null : error.toMap());
      return toMapResult;
    }
    static @NonNull VoidResult fromMap(@NonNull Map<String, Object> map) {
      VoidResult pigeonResult = new VoidResult();
      Object error = map.get("error");
      pigeonResult.setError((error == null) ? null : PlatformError.fromMap((Map)error));
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PlatformError {
    private @NonNull String message;
    public @NonNull String getMessage() { return message; }
    public void setMessage(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"message\" is null.");
      }
      this.message = setterArg;
    }

    private @NonNull ErrorCode code;
    public @NonNull ErrorCode getCode() { return code; }
    public void setCode(@NonNull ErrorCode setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"code\" is null.");
      }
      this.code = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private PlatformError() {}
    public static final class Builder {
      private @Nullable String message;
      public @NonNull Builder setMessage(@NonNull String setterArg) {
        this.message = setterArg;
        return this;
      }
      private @Nullable ErrorCode code;
      public @NonNull Builder setCode(@NonNull ErrorCode setterArg) {
        this.code = setterArg;
        return this;
      }
      public @NonNull PlatformError build() {
        PlatformError pigeonReturn = new PlatformError();
        pigeonReturn.setMessage(message);
        pigeonReturn.setCode(code);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("message", message);
      toMapResult.put("code", code == null ? null : code.index);
      return toMapResult;
    }
    static @NonNull PlatformError fromMap(@NonNull Map<String, Object> map) {
      PlatformError pigeonResult = new PlatformError();
      Object message = map.get("message");
      pigeonResult.setMessage((String)message);
      Object code = map.get("code");
      pigeonResult.setCode(code == null ? null : ErrorCode.values()[(int)code]);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class JoinArgs {
    private @NonNull String url;
    public @NonNull String getUrl() { return url; }
    public void setUrl(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"url\" is null.");
      }
      this.url = setterArg;
    }

    private @NonNull String token;
    public @NonNull String getToken() { return token; }
    public void setToken(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"token\" is null.");
      }
      this.token = setterArg;
    }

    private @NonNull Boolean enableMicrophone;
    public @NonNull Boolean getEnableMicrophone() { return enableMicrophone; }
    public void setEnableMicrophone(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"enableMicrophone\" is null.");
      }
      this.enableMicrophone = setterArg;
    }

    private @NonNull Boolean enableCamera;
    public @NonNull Boolean getEnableCamera() { return enableCamera; }
    public void setEnableCamera(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"enableCamera\" is null.");
      }
      this.enableCamera = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private JoinArgs() {}
    public static final class Builder {
      private @Nullable String url;
      public @NonNull Builder setUrl(@NonNull String setterArg) {
        this.url = setterArg;
        return this;
      }
      private @Nullable String token;
      public @NonNull Builder setToken(@NonNull String setterArg) {
        this.token = setterArg;
        return this;
      }
      private @Nullable Boolean enableMicrophone;
      public @NonNull Builder setEnableMicrophone(@NonNull Boolean setterArg) {
        this.enableMicrophone = setterArg;
        return this;
      }
      private @Nullable Boolean enableCamera;
      public @NonNull Builder setEnableCamera(@NonNull Boolean setterArg) {
        this.enableCamera = setterArg;
        return this;
      }
      public @NonNull JoinArgs build() {
        JoinArgs pigeonReturn = new JoinArgs();
        pigeonReturn.setUrl(url);
        pigeonReturn.setToken(token);
        pigeonReturn.setEnableMicrophone(enableMicrophone);
        pigeonReturn.setEnableCamera(enableCamera);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("url", url);
      toMapResult.put("token", token);
      toMapResult.put("enableMicrophone", enableMicrophone);
      toMapResult.put("enableCamera", enableCamera);
      return toMapResult;
    }
    static @NonNull JoinArgs fromMap(@NonNull Map<String, Object> map) {
      JoinArgs pigeonResult = new JoinArgs();
      Object url = map.get("url");
      pigeonResult.setUrl((String)url);
      Object token = map.get("token");
      pigeonResult.setToken((String)token);
      Object enableMicrophone = map.get("enableMicrophone");
      pigeonResult.setEnableMicrophone((Boolean)enableMicrophone);
      Object enableCamera = map.get("enableCamera");
      pigeonResult.setEnableCamera((Boolean)enableCamera);
      return pigeonResult;
    }
  }

  /**
   * Returning class from join() function
   *
   * Generated class from Pigeon that represents data sent in messages.
   */
  public static class JoinMessage {
    private @Nullable LocalParticipantMessage localParticipant;
    public @Nullable LocalParticipantMessage getLocalParticipant() { return localParticipant; }
    public void setLocalParticipant(@Nullable LocalParticipantMessage setterArg) {
      this.localParticipant = setterArg;
    }

    private @Nullable List<RemoteParticipantMessage> remoteParticipants;
    public @Nullable List<RemoteParticipantMessage> getRemoteParticipants() { return remoteParticipants; }
    public void setRemoteParticipants(@Nullable List<RemoteParticipantMessage> setterArg) {
      this.remoteParticipants = setterArg;
    }

    private @Nullable PlatformError error;
    public @Nullable PlatformError getError() { return error; }
    public void setError(@Nullable PlatformError setterArg) {
      this.error = setterArg;
    }

    public static final class Builder {
      private @Nullable LocalParticipantMessage localParticipant;
      public @NonNull Builder setLocalParticipant(@Nullable LocalParticipantMessage setterArg) {
        this.localParticipant = setterArg;
        return this;
      }
      private @Nullable List<RemoteParticipantMessage> remoteParticipants;
      public @NonNull Builder setRemoteParticipants(@Nullable List<RemoteParticipantMessage> setterArg) {
        this.remoteParticipants = setterArg;
        return this;
      }
      private @Nullable PlatformError error;
      public @NonNull Builder setError(@Nullable PlatformError setterArg) {
        this.error = setterArg;
        return this;
      }
      public @NonNull JoinMessage build() {
        JoinMessage pigeonReturn = new JoinMessage();
        pigeonReturn.setLocalParticipant(localParticipant);
        pigeonReturn.setRemoteParticipants(remoteParticipants);
        pigeonReturn.setError(error);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("localParticipant", (localParticipant == null) ? null : localParticipant.toMap());
      toMapResult.put("remoteParticipants", remoteParticipants);
      toMapResult.put("error", (error == null) ? null : error.toMap());
      return toMapResult;
    }
    static @NonNull JoinMessage fromMap(@NonNull Map<String, Object> map) {
      JoinMessage pigeonResult = new JoinMessage();
      Object localParticipant = map.get("localParticipant");
      pigeonResult.setLocalParticipant((localParticipant == null) ? null : LocalParticipantMessage.fromMap((Map)localParticipant));
      Object remoteParticipants = map.get("remoteParticipants");
      pigeonResult.setRemoteParticipants((List<RemoteParticipantMessage>)remoteParticipants);
      Object error = map.get("error");
      pigeonResult.setError((error == null) ? null : PlatformError.fromMap((Map)error));
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class LocalParticipantMessage {
    private @NonNull String id;
    public @NonNull String getId() { return id; }
    public void setId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"id\" is null.");
      }
      this.id = setterArg;
    }

    private @NonNull Boolean isCameraEnabled;
    public @NonNull Boolean getIsCameraEnabled() { return isCameraEnabled; }
    public void setIsCameraEnabled(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isCameraEnabled\" is null.");
      }
      this.isCameraEnabled = setterArg;
    }

    private @NonNull Boolean isMicrophoneEnabled;
    public @NonNull Boolean getIsMicrophoneEnabled() { return isMicrophoneEnabled; }
    public void setIsMicrophoneEnabled(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isMicrophoneEnabled\" is null.");
      }
      this.isMicrophoneEnabled = setterArg;
    }

    private @NonNull String userId;
    public @NonNull String getUserId() { return userId; }
    public void setUserId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"userId\" is null.");
      }
      this.userId = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private LocalParticipantMessage() {}
    public static final class Builder {
      private @Nullable String id;
      public @NonNull Builder setId(@NonNull String setterArg) {
        this.id = setterArg;
        return this;
      }
      private @Nullable Boolean isCameraEnabled;
      public @NonNull Builder setIsCameraEnabled(@NonNull Boolean setterArg) {
        this.isCameraEnabled = setterArg;
        return this;
      }
      private @Nullable Boolean isMicrophoneEnabled;
      public @NonNull Builder setIsMicrophoneEnabled(@NonNull Boolean setterArg) {
        this.isMicrophoneEnabled = setterArg;
        return this;
      }
      private @Nullable String userId;
      public @NonNull Builder setUserId(@NonNull String setterArg) {
        this.userId = setterArg;
        return this;
      }
      public @NonNull LocalParticipantMessage build() {
        LocalParticipantMessage pigeonReturn = new LocalParticipantMessage();
        pigeonReturn.setId(id);
        pigeonReturn.setIsCameraEnabled(isCameraEnabled);
        pigeonReturn.setIsMicrophoneEnabled(isMicrophoneEnabled);
        pigeonReturn.setUserId(userId);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("id", id);
      toMapResult.put("isCameraEnabled", isCameraEnabled);
      toMapResult.put("isMicrophoneEnabled", isMicrophoneEnabled);
      toMapResult.put("userId", userId);
      return toMapResult;
    }
    static @NonNull LocalParticipantMessage fromMap(@NonNull Map<String, Object> map) {
      LocalParticipantMessage pigeonResult = new LocalParticipantMessage();
      Object id = map.get("id");
      pigeonResult.setId((String)id);
      Object isCameraEnabled = map.get("isCameraEnabled");
      pigeonResult.setIsCameraEnabled((Boolean)isCameraEnabled);
      Object isMicrophoneEnabled = map.get("isMicrophoneEnabled");
      pigeonResult.setIsMicrophoneEnabled((Boolean)isMicrophoneEnabled);
      Object userId = map.get("userId");
      pigeonResult.setUserId((String)userId);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class RemoteParticipantMessage {
    private @NonNull String id;
    public @NonNull String getId() { return id; }
    public void setId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"id\" is null.");
      }
      this.id = setterArg;
    }

    private @NonNull Boolean isCameraEnabled;
    public @NonNull Boolean getIsCameraEnabled() { return isCameraEnabled; }
    public void setIsCameraEnabled(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isCameraEnabled\" is null.");
      }
      this.isCameraEnabled = setterArg;
    }

    private @NonNull Boolean isMicrophoneEnabled;
    public @NonNull Boolean getIsMicrophoneEnabled() { return isMicrophoneEnabled; }
    public void setIsMicrophoneEnabled(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isMicrophoneEnabled\" is null.");
      }
      this.isMicrophoneEnabled = setterArg;
    }

    private @NonNull String userId;
    public @NonNull String getUserId() { return userId; }
    public void setUserId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"userId\" is null.");
      }
      this.userId = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private RemoteParticipantMessage() {}
    public static final class Builder {
      private @Nullable String id;
      public @NonNull Builder setId(@NonNull String setterArg) {
        this.id = setterArg;
        return this;
      }
      private @Nullable Boolean isCameraEnabled;
      public @NonNull Builder setIsCameraEnabled(@NonNull Boolean setterArg) {
        this.isCameraEnabled = setterArg;
        return this;
      }
      private @Nullable Boolean isMicrophoneEnabled;
      public @NonNull Builder setIsMicrophoneEnabled(@NonNull Boolean setterArg) {
        this.isMicrophoneEnabled = setterArg;
        return this;
      }
      private @Nullable String userId;
      public @NonNull Builder setUserId(@NonNull String setterArg) {
        this.userId = setterArg;
        return this;
      }
      public @NonNull RemoteParticipantMessage build() {
        RemoteParticipantMessage pigeonReturn = new RemoteParticipantMessage();
        pigeonReturn.setId(id);
        pigeonReturn.setIsCameraEnabled(isCameraEnabled);
        pigeonReturn.setIsMicrophoneEnabled(isMicrophoneEnabled);
        pigeonReturn.setUserId(userId);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("id", id);
      toMapResult.put("isCameraEnabled", isCameraEnabled);
      toMapResult.put("isMicrophoneEnabled", isMicrophoneEnabled);
      toMapResult.put("userId", userId);
      return toMapResult;
    }
    static @NonNull RemoteParticipantMessage fromMap(@NonNull Map<String, Object> map) {
      RemoteParticipantMessage pigeonResult = new RemoteParticipantMessage();
      Object id = map.get("id");
      pigeonResult.setId((String)id);
      Object isCameraEnabled = map.get("isCameraEnabled");
      pigeonResult.setIsCameraEnabled((Boolean)isCameraEnabled);
      Object isMicrophoneEnabled = map.get("isMicrophoneEnabled");
      pigeonResult.setIsMicrophoneEnabled((Boolean)isMicrophoneEnabled);
      Object userId = map.get("userId");
      pigeonResult.setUserId((String)userId);
      return pigeonResult;
    }
  }

  public interface Result<T> {
    void success(T result);
    void error(Throwable error);
  }
  private static class DailyMessengerCodec extends StandardMessageCodec {
    public static final DailyMessengerCodec INSTANCE = new DailyMessengerCodec();
    private DailyMessengerCodec() {}
    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return JoinArgs.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)129:         
          return JoinMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)130:         
          return LocalParticipantMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)131:         
          return PlatformError.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)132:         
          return RemoteParticipantMessage.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)133:         
          return VoidResult.fromMap((Map<String, Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value)     {
      if (value instanceof JoinArgs) {
        stream.write(128);
        writeValue(stream, ((JoinArgs) value).toMap());
      } else 
      if (value instanceof JoinMessage) {
        stream.write(129);
        writeValue(stream, ((JoinMessage) value).toMap());
      } else 
      if (value instanceof LocalParticipantMessage) {
        stream.write(130);
        writeValue(stream, ((LocalParticipantMessage) value).toMap());
      } else 
      if (value instanceof PlatformError) {
        stream.write(131);
        writeValue(stream, ((PlatformError) value).toMap());
      } else 
      if (value instanceof RemoteParticipantMessage) {
        stream.write(132);
        writeValue(stream, ((RemoteParticipantMessage) value).toMap());
      } else 
      if (value instanceof VoidResult) {
        stream.write(133);
        writeValue(stream, ((VoidResult) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /**
   * This is the base class of communication with native code.
   * It's used for generating the Pigeon files
   *
   * Generated interface from Pigeon that represents a handler of messages from Flutter.
   */
  public interface DailyMessenger {
    /** Join Daily call. */
    void join(@NonNull JoinArgs args, Result<JoinMessage> result);
    /** Leave Daily call. */
    @NonNull VoidResult leave();
    @NonNull VoidResult setMicrophoneEnabled(@NonNull Boolean enableMic);
    @NonNull VoidResult setCameraEnabled(@NonNull Boolean enableCam);

    /** The codec used by DailyMessenger. */
    static MessageCodec<Object> getCodec() {
      return       DailyMessengerCodec.INSTANCE;    }
    /**Sets up an instance of `DailyMessenger` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, DailyMessenger api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.DailyMessenger.join", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              JoinArgs argsArg = (JoinArgs)args.get(0);
              if (argsArg == null) {
                throw new NullPointerException("argsArg unexpectedly null.");
              }
              Result<JoinMessage> resultCallback = new Result<JoinMessage>() {
                public void success(JoinMessage result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.join(argsArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.DailyMessenger.leave", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              VoidResult output = api.leave();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.DailyMessenger.setMicrophoneEnabled", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              Boolean enableMicArg = (Boolean)args.get(0);
              if (enableMicArg == null) {
                throw new NullPointerException("enableMicArg unexpectedly null.");
              }
              VoidResult output = api.setMicrophoneEnabled(enableMicArg);
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.DailyMessenger.setCameraEnabled", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              assert args != null;
              Boolean enableCamArg = (Boolean)args.get(0);
              if (enableCamArg == null) {
                throw new NullPointerException("enableCamArg unexpectedly null.");
              }
              VoidResult output = api.setCameraEnabled(enableCamArg);
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  @NonNull private static Map<String, Object> wrapError(@NonNull Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}
