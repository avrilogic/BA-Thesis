// Jean Jacques Avril
// Autogenerated from Pigeon (v17.1.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.CLASS;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression", "serial"})
public class Messages {

  /** Error class for passing custom error details to Flutter via a thrown PlatformException. */
  public static class FlutterError extends RuntimeException {

    /** The error code. */
    public final String code;

    /** The error details. Must be a datatype supported by the api codec. */
    public final Object details;

    public FlutterError(@NonNull String code, @Nullable String message, @Nullable Object details) 
    {
      super(message);
      this.code = code;
      this.details = details;
    }
  }

  @NonNull
  protected static ArrayList<Object> wrapError(@NonNull Throwable exception) {
    ArrayList<Object> errorList = new ArrayList<Object>(3);
    if (exception instanceof FlutterError) {
      FlutterError error = (FlutterError) exception;
      errorList.add(error.code);
      errorList.add(error.getMessage());
      errorList.add(error.details);
    } else {
      errorList.add(exception.toString());
      errorList.add(exception.getClass().getSimpleName());
      errorList.add(
        "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    }
    return errorList;
  }

  @Target(METHOD)
  @Retention(CLASS)
  @interface CanIgnoreReturnValue {}

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class ComplexStructure {
    private @NonNull Long a;

    public @NonNull Long getA() {
      return a;
    }

    public void setA(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"a\" is null.");
      }
      this.a = setterArg;
    }

    private @NonNull Long b;

    public @NonNull Long getB() {
      return b;
    }

    public void setB(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"b\" is null.");
      }
      this.b = setterArg;
    }

    private @NonNull String c;

    public @NonNull String getC() {
      return c;
    }

    public void setC(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"c\" is null.");
      }
      this.c = setterArg;
    }

    private @NonNull List<Long> myList;

    public @NonNull List<Long> getMyList() {
      return myList;
    }

    public void setMyList(@NonNull List<Long> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"myList\" is null.");
      }
      this.myList = setterArg;
    }

    private @NonNull Map<String, String> myKvMap;

    public @NonNull Map<String, String> getMyKvMap() {
      return myKvMap;
    }

    public void setMyKvMap(@NonNull Map<String, String> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"myKvMap\" is null.");
      }
      this.myKvMap = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    ComplexStructure() {}

    public static final class Builder {

      private @Nullable Long a;

      @CanIgnoreReturnValue
      public @NonNull Builder setA(@NonNull Long setterArg) {
        this.a = setterArg;
        return this;
      }

      private @Nullable Long b;

      @CanIgnoreReturnValue
      public @NonNull Builder setB(@NonNull Long setterArg) {
        this.b = setterArg;
        return this;
      }

      private @Nullable String c;

      @CanIgnoreReturnValue
      public @NonNull Builder setC(@NonNull String setterArg) {
        this.c = setterArg;
        return this;
      }

      private @Nullable List<Long> myList;

      @CanIgnoreReturnValue
      public @NonNull Builder setMyList(@NonNull List<Long> setterArg) {
        this.myList = setterArg;
        return this;
      }

      private @Nullable Map<String, String> myKvMap;

      @CanIgnoreReturnValue
      public @NonNull Builder setMyKvMap(@NonNull Map<String, String> setterArg) {
        this.myKvMap = setterArg;
        return this;
      }

      public @NonNull ComplexStructure build() {
        ComplexStructure pigeonReturn = new ComplexStructure();
        pigeonReturn.setA(a);
        pigeonReturn.setB(b);
        pigeonReturn.setC(c);
        pigeonReturn.setMyList(myList);
        pigeonReturn.setMyKvMap(myKvMap);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(5);
      toListResult.add(a);
      toListResult.add(b);
      toListResult.add(c);
      toListResult.add(myList);
      toListResult.add(myKvMap);
      return toListResult;
    }

    static @NonNull ComplexStructure fromList(@NonNull ArrayList<Object> list) {
      ComplexStructure pigeonResult = new ComplexStructure();
      Object a = list.get(0);
      pigeonResult.setA((a == null) ? null : ((a instanceof Integer) ? (Integer) a : (Long) a));
      Object b = list.get(1);
      pigeonResult.setB((b == null) ? null : ((b instanceof Integer) ? (Integer) b : (Long) b));
      Object c = list.get(2);
      pigeonResult.setC((String) c);
      Object myList = list.get(3);
      pigeonResult.setMyList((List<Long>) myList);
      Object myKvMap = list.get(4);
      pigeonResult.setMyKvMap((Map<String, String>) myKvMap);
      return pigeonResult;
    }
  }

  private static class MethodChannelPigeonCodec extends StandardMessageCodec {
    public static final MethodChannelPigeonCodec INSTANCE = new MethodChannelPigeonCodec();

    private MethodChannelPigeonCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return ComplexStructure.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof ComplexStructure) {
        stream.write(128);
        writeValue(stream, ((ComplexStructure) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface MethodChannelPigeon {

    @NonNull 
    String reverse(@NonNull String input);

    @NonNull 
    Long add(@NonNull Long a, @NonNull Long b);

    @NonNull 
    Long subtract(@NonNull Long a, @NonNull Long b);

    @NonNull 
    Long multiply(@NonNull Long a, @NonNull Long b);

    @NonNull 
    Long divide(@NonNull Long a, @NonNull Long b);

    @NonNull 
    ComplexStructure getComplexStructure();

    /** The codec used by MethodChannelPigeon. */
    static @NonNull MessageCodec<Object> getCodec() {
      return MethodChannelPigeonCodec.INSTANCE;
    }
    /**Sets up an instance of `MethodChannelPigeon` to handle messages through the `binaryMessenger`. */
    static void setUp(@NonNull BinaryMessenger binaryMessenger, @Nullable MethodChannelPigeon api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.reverse", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String inputArg = (String) args.get(0);
                try {
                  String output = api.reverse(inputArg);
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.add", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                Number aArg = (Number) args.get(0);
                Number bArg = (Number) args.get(1);
                try {
                  Long output = api.add((aArg == null) ? null : aArg.longValue(), (bArg == null) ? null : bArg.longValue());
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.subtract", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                Number aArg = (Number) args.get(0);
                Number bArg = (Number) args.get(1);
                try {
                  Long output = api.subtract((aArg == null) ? null : aArg.longValue(), (bArg == null) ? null : bArg.longValue());
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.multiply", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                Number aArg = (Number) args.get(0);
                Number bArg = (Number) args.get(1);
                try {
                  Long output = api.multiply((aArg == null) ? null : aArg.longValue(), (bArg == null) ? null : bArg.longValue());
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.divide", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                Number aArg = (Number) args.get(0);
                Number bArg = (Number) args.get(1);
                try {
                  Long output = api.divide((aArg == null) ? null : aArg.longValue(), (bArg == null) ? null : bArg.longValue());
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.getComplexStructure", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  ComplexStructure output = api.getComplexStructure();
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
}
