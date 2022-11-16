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

    private @NonNull Long code;
    public @NonNull Long getCode() { return code; }
    public void setCode(@NonNull Long setterArg) {
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
      private @Nullable Long code;
      public @NonNull Builder setCode(@NonNull Long setterArg) {
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
      toMapResult.put("code", code);
      return toMapResult;
    }
    static @NonNull PlatformError fromMap(@NonNull Map<String, Object> map) {
      PlatformError pigeonResult = new PlatformError();
      Object message = map.get("message");
      pigeonResult.setMessage((String)message);
      Object code = map.get("code");
      pigeonResult.setCode((code == null) ? null : ((code instanceof Integer) ? (Integer)code : (Long)code));
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

    private @NonNull Boolean isMicEnabled;
    public @NonNull Boolean getIsMicEnabled() { return isMicEnabled; }
    public void setIsMicEnabled(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isMicEnabled\" is null.");
      }
      this.isMicEnabled = setterArg;
    }

    private @NonNull Boolean isCameraEnabled;
    public @NonNull Boolean getIsCameraEnabled() { return isCameraEnabled; }
    public void setIsCameraEnabled(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isCameraEnabled\" is null.");
      }
      this.isCameraEnabled = setterArg;
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
      private @Nullable Boolean isMicEnabled;
      public @NonNull Builder setIsMicEnabled(@NonNull Boolean setterArg) {
        this.isMicEnabled = setterArg;
        return this;
      }
      private @Nullable Boolean isCameraEnabled;
      public @NonNull Builder setIsCameraEnabled(@NonNull Boolean setterArg) {
        this.isCameraEnabled = setterArg;
        return this;
      }
      public @NonNull JoinArgs build() {
        JoinArgs pigeonReturn = new JoinArgs();
        pigeonReturn.setUrl(url);
        pigeonReturn.setToken(token);
        pigeonReturn.setIsMicEnabled(isMicEnabled);
        pigeonReturn.setIsCameraEnabled(isCameraEnabled);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("url", url);
      toMapResult.put("token", token);
      toMapResult.put("isMicEnabled", isMicEnabled);
      toMapResult.put("isCameraEnabled", isCameraEnabled);
      return toMapResult;
    }
    static @NonNull JoinArgs fromMap(@NonNull Map<String, Object> map) {
      JoinArgs pigeonResult = new JoinArgs();
      Object url = map.get("url");
      pigeonResult.setUrl((String)url);
      Object token = map.get("token");
      pigeonResult.setToken((String)token);
      Object isMicEnabled = map.get("isMicEnabled");
      pigeonResult.setIsMicEnabled((Boolean)isMicEnabled);
      Object isCameraEnabled = map.get("isCameraEnabled");
      pigeonResult.setIsCameraEnabled((Boolean)isCameraEnabled);
      return pigeonResult;
    }
  }

  public interface Result<T> {
    void success(T result);
    void error(Throwable error);
  }
  private static class DailyClientMessengerCodec extends StandardMessageCodec {
    public static final DailyClientMessengerCodec INSTANCE = new DailyClientMessengerCodec();
    private DailyClientMessengerCodec() {}
    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return JoinArgs.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)129:         
          return PlatformError.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)130:         
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
      if (value instanceof PlatformError) {
        stream.write(129);
        writeValue(stream, ((PlatformError) value).toMap());
      } else 
      if (value instanceof VoidResult) {
        stream.write(130);
        writeValue(stream, ((VoidResult) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface DailyClientMessenger {
    void join(@NonNull JoinArgs args, Result<VoidResult> result);
    @NonNull VoidResult leave();

    /** The codec used by DailyClientMessenger. */
    static MessageCodec<Object> getCodec() {
      return       DailyClientMessengerCodec.INSTANCE;    }
    /**Sets up an instance of `DailyClientMessenger` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, DailyClientMessenger api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.DailyClientMessenger.join", getCodec());
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
              Result<VoidResult> resultCallback = new Result<VoidResult>() {
                public void success(VoidResult result) {
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
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.DailyClientMessenger.leave", getCodec());
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
